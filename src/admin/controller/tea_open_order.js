const { think } = require('thinkjs');
const Base = require('./base.js');

module.exports = class extends Base {

  async indexAction() {
    const user = this.userInfo();
    const list = await this.model('yxd_seat_cat').where({ shop_id: user.shop_id }).field('id, cat_name as name').select();
    const list1 = await this.model('yxd_seat_list').alias('s').field('s.*, c.charging_type').where({ 's.shop_id': user.shop_id }).join([
      'LEFT JOIN yxd_seat_cat as c ON c.id = s.cat_id'
    ]).select();
    const list2 = {};
    for (const item of list) {
      list2[item.id] = {
        cat: item,
        list: []
      }
    }
    for (const item of list1) {
      if (list2[item.cat_id]) list2[item.cat_id].list.push(item);
    }
    return this.success(list2);
  }
  /** 预定 或取消预定 */
  async reserveAction() {
    const params = this.post();
    const data = await this.model('yxd_seat_list').where({ id: params.id }).find();
    think.logger.info('查询结果', data);
    if (think.isEmpty(data)) return this.fail('该座位不存在!');
    if (data.status == 2) return this.fail('座位未结算!');
    const status = data.status == 1 ? 0 : 1;
    const result = await this.model('yxd_seat_list').where({ id: params.id }).update({ status });
    if (!result) return this.fail('预定失败!')
    return this.success(status);
  }
  /** 座位开始计费 */
  async startAction() {
    const params = this.post();
    const data = await this.model('yxd_seat_list').where({ id: params.id }).find();
    if (data.status == 2) return this.fail('座位已经开始计费!');
    const start_time = Date.now();
    const uuid = think.uuid('v1')
    const user = this.userInfo();
    const result = await this.model('yxd_seat_list').where({ id: params.id }).update({ status: 2, start_time, order_id: uuid, user_id: user.id });
    if (result) return this.success({ start_time, order_id: uuid, status: 2 });
    return this.fail('计费失败!');
  }
  /** 获取座位或者包间详情 */
  async seatinfoAction() {
    const params = this.post();
    const info = await this.model('yxd_seat_list').alias('s')
      .field('s.*, c.cat_name, c.basics_price, c.max_time, c.time_out_price,c.other_price,c.other_price_start_time,c.other_price_end_time,c.charging_type')
      .where({ 's.id': params.id }).join({
        yxd_seat_cat: {
          join: 'left',
          as: 'c',
          on: ['cat_id', 'id']
        }
      }).find();
    if (think.isEmpty(info)) return this.fail('该座位不存在!');
    info.time_range = 0;
    info.goodsList = []; // 商品列表
    if (info.status == 0 || info.status == 1) {
      return this.success(info);
    }

    const { price, time_out_price, ohter_out_price, out_date, other_out_date, goodsPrice } = await this.service("charging", "admin").tea(info);
    info.total_price = price;
    info.total_time_out_price = time_out_price;
    info.total_ohter_out_price = ohter_out_price;
    info.out_date = out_date;
    info.other_out_date = other_out_date;
    info.goods_price = goodsPrice;
    // 获取商品列表
    info.goodsList = await this.model('yxd_seat_goods_order')
      .alias('gr')
      .field('gr.*,g.goods_name')
      .join([
        'LEFT JOIN yxd_tea_goods as g ON gr.goods_id = g.id'
      ])
      .where({ order_id: info.order_id, seat_id: info.id })
      .select();
    info.order = null; // 订单详情， 如果已结账的情况下
    // 如果已结账
    if (!think.isEmpty(info.order_id)) {
      info.order = await this.model('yxd_tea_order').where({ order_id: info.order_id }).find();
      info.order = think.isEmpty(info.order) ? null : info.order;
    }
    return this.success(info);
  }
  // 读取商品列表
  async goodsListAction() {
    const user = this.userInfo();
    // 获取商品列表
    const list = await this.model('yxd_tea_goods').where({ shop_id: user.shop_id }).order('sort DESC').select();
    return this.success(list);
  }

  // 给座位添加计费物品
  async selectGoodsAction() {
    const params = this.post();
    const user = this.userInfo();
    const goodsInfo = await this.model('yxd_tea_goods').where({ id: params.id }).find();
    const seatInfo = await this.model('yxd_seat_list').where({ id: params.seat_id }).find();
    if (think.isEmpty(goodsInfo)) return this.fail('商品不存在!');
    if (think.isEmpty(seatInfo)) return this.fail('座位不存在!');
    if (seatInfo.status !== 2) return this.fail('当前座位未计费');
    const data = {
      shop_id: user.shop_id,
      price: goodsInfo.price,
      seat_id: seatInfo.id,
      goods_id: goodsInfo.id,
      order_id: seatInfo.order_id,
      create_time: Date.now(),
    }
    const result = await this.model('yxd_seat_goods_order').add(data);
    if (result) return this.success('添加成功!');
    return this.success('添加失败!');
  }
  // 删除订单商品
  async removeGoodsOrderAction() {
    const params = this.post();
    const user = this.userInfo();
    const order = await this.model('yxd_tea_order').where({ order_id: params.order_id }).find();
    if (!think.isEmpty(order) && order.status === 0) return this.success('订单已锁定!');
    if (!think.isEmpty(order) && order.status === 1) return this.fail('订单已完成!');
    const result = await this.model('yxd_seat_goods_order').where({ id: params.id, order_status: 0 }).delete();
    return result ? this.success() : this.fail('删除失败!');
  }
  // 结算
  async settlementAction() {
    const params = this.post();
    if (isNaN(Number(params.discount_price))) return this.fail('优惠价格格式错误');
    params.discount_price = Number(params.discount_price);
    const user = this.userInfo();
    if (think.isEmpty(params.pay_type)) return this.fail('请选择支付方式!');
    const pay_type = this.model('yxd_pay_type').where({id: params.pay_type}).find();
    if (think.isEmpty(pay_type)) return this.fail('支付方式不存在!');
    const info = await this.model('yxd_seat_list').alias('s')
      .field('s.*, c.cat_name, c.basics_price, c.max_time, c.time_out_price,c.other_price,c.other_price_start_time,c.other_price_end_time,c.charging_type')
      .where({ 's.id': params.id }).join({
        yxd_seat_cat: {
          join: 'left',
          as: 'c',
          on: ['cat_id', 'id']
        }
      }).find();
    if (think.isEmpty(info)) return this.fail('此订单不存在!');
    let order = await this.model('yxd_tea_order').where({ order_id: info.order_id }).find();
    if (!think.isEmpty(order)) {
      console.log('结算总价1', order);
      if (order.status == 0) return this.success(order);
      if (order.status == 1) return this.fail('无法操作，订单已完成!');
    }
    think.logger.info('结算信息', info)
    const { price, time_out_price, ohter_out_price, out_date, other_out_date, goodsPrice } = await this.service("charging", "admin").tea(info);
    params.discount_price = Number(params.discount_price.toFixed(2));
    const complete_price = Number(price) + Number(params.discount_price);
    const data = {
      order_id: info.order_id,
      shop_id: info.shop_id,
      seat_name: info.name,
      total_price: price, // 计算总价
      order_end_time: Date.now(),
      room_price: info.basics_price, // 包间价格
      room_out_price: time_out_price, // 包间超时费
      room_server_price: ohter_out_price, // 包间服务费
      open_order_user_id: info.user_id, // 开单用户
      complete_order_user_id: user.id, // 结单用户
      remarks: params.order_remarks, // 订单备注
      discount_price: params.discount_price, // 优惠或者加价价格
      complete_price, // 实际结算价格
      goods_total_price: goodsPrice, // 商品总价
      status: 0, // 订单锁定
      pay_type: params.pay_type,
      guest_source: think.isEmpty(params.guest_source) ? 1 : params.guest_source,
    }
    const db = this.model('yxd_tea_order').db();
    const orderModel = this.model('yxd_tea_order').db(db);
    const goodsOrderModel = this.model("yxd_seat_goods_order").db(db);
    const goodsOrderCount = await this.model('yxd_seat_goods_order').where({order_id: info.order_id, order_status: 0}).count('id');
    try {
      await orderModel.startTrans();
      const result = await orderModel.add(data);
      if (!result) {
        await orderModel.rollback();
        return this.fail('结算失败!');
      }
      const updateGoodsStatus = await goodsOrderModel.where({order_id: info.order_id}).update({order_status: 1});
      if (updateGoodsStatus !== goodsOrderCount) {
        await orderModel.rollback();
        return this.fail('结算失败!');
      }
      await orderModel.commit();
      order =  await this.model('yxd_tea_order').where({ order_id: info.order_id }).find();
      console.log('结算总价', data);
      return this.success(order)
    } catch(e) {
      await orderModel.rollback();
      return this.fail('结算失败!');
    }
  
  }
  /** 完成订单确认收款 */
  async completeOrderAction() {
    const params = this.post();
    const order = await this.model('yxd_tea_order').field('status').where({order_id: params.id}).find();
    if (think.isEmpty(order)) return this.fail('订单不存在!');
    const db = this.model('yxd_tea_order').db();
    const orderModel = this.model('yxd_tea_order').db(db);
    const seatModel = this.model('yxd_seat_list').db(db);
    try {
      await orderModel.startTrans();
      const updateStatus = await orderModel.where({order_id: params.id}).update({status: 1, complete_time: Date.now()});
      if (!updateStatus && order.status == 0) { 
        await orderModel.rollback(); 
        return this.fail('收款确认失败!');
      }
      const seatData = {
        start_time: null,
        order_id: null,
        user_id: null,
        status: 0,
      }
      const updateSeat = await seatModel.where({order_id: params.id}).update(seatData);
      orderModel.commit();
      return this.success();
    } catch(e) {
      await orderModel.rollback(); 
      return this.fail('收款确认失败!');
    }
    
   

  }
  /**
   * 获取已完成订单列表
   */
  async orderListAction() {
    const [page, pageSize] = this.getPage();
    const where = {}
    where['o.shop_id'] = this.getShopId();
    const list = await this.model('yxd_tea_order').alias('o').field('o.*, u.nickname, p.pay_name').where(where).order('order_end_time desc').join([
      'LEFT JOIN sys_user as u ON u.id = o.complete_order_user_id',
      'LEFT JOIN yxd_pay_type as p ON o.pay_type = p.id'
    ]).page(page, pageSize).select();
    return this.success(list);
  }

  // 获取订单列表
  async orderLisCountAction() {
    const count = await this.model('yxd_tea_order').where({shop_id: this.getShopId()}).count('id');
    return this.success(count);
  }
  /** 客源 */
  async guestSourceListAction() {
    const list = await this.model('yxd_guest_source').where({type: 1}).select();
    return this.success(list);
  }
  // async orderGoodListAction() {
  //   const params = this.post();
  //   if (isEmpty(params.order_id)) return this.fail('订单号错误!');
  //   if (isEmpty(params.seat_id)) return this.fail('座位错误!');
  //   const list = await this.model('yxd_seat_goods_order').where({order_id: params.order_id, seat_id: params.seat_id}).select();
  //   return this.success(list);
  // }
};
