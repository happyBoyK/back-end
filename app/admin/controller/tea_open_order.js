function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const { think } = require('thinkjs');
const Base = require('./base.js');

module.exports = class extends Base {

  indexAction() {
    var _this = this;

    return _asyncToGenerator(function* () {
      const user = _this.userInfo();
      const list = yield _this.model('yxd_seat_cat').where({ shop_id: user.shop_id }).field('id, cat_name as name').select();
      const list1 = yield _this.model('yxd_seat_list').alias('s').field('s.*, c.charging_type').where({ 's.shop_id': user.shop_id }).join(['LEFT JOIN yxd_seat_cat as c ON c.id = s.cat_id']).select();
      const list2 = {};
      for (const item of list) {
        list2[item.id] = {
          cat: item,
          list: []
        };
      }
      for (const item of list1) {
        if (list2[item.cat_id]) list2[item.cat_id].list.push(item);
      }
      return _this.success(list2);
    })();
  }
  /** 预定 或取消预定 */
  reserveAction() {
    var _this2 = this;

    return _asyncToGenerator(function* () {
      const params = _this2.post();
      const data = yield _this2.model('yxd_seat_list').where({ id: params.id }).find();
      think.logger.info('查询结果', data);
      if (think.isEmpty(data)) return _this2.fail('该座位不存在!');
      if (data.status == 2) return _this2.fail('座位未结算!');
      const status = data.status == 1 ? 0 : 1;
      const result = yield _this2.model('yxd_seat_list').where({ id: params.id }).update({ status });
      if (!result) return _this2.fail('预定失败!');
      return _this2.success(status);
    })();
  }
  /** 座位开始计费 */
  startAction() {
    var _this3 = this;

    return _asyncToGenerator(function* () {
      const params = _this3.post();
      const data = yield _this3.model('yxd_seat_list').where({ id: params.id }).find();
      if (data.status == 2) return _this3.fail('座位已经开始计费!');
      const start_time = Date.now();
      const uuid = think.uuid('v1');
      const user = _this3.userInfo();
      const result = yield _this3.model('yxd_seat_list').where({ id: params.id }).update({ status: 2, start_time, order_id: uuid, user_id: user.id });
      if (result) return _this3.success({ start_time, order_id: uuid, status: 2 });
      return _this3.fail('计费失败!');
    })();
  }
  /** 获取座位或者包间详情 */
  seatinfoAction() {
    var _this4 = this;

    return _asyncToGenerator(function* () {
      const params = _this4.post();
      const info = yield _this4.model('yxd_seat_list').alias('s').field('s.*, c.cat_name, c.basics_price, c.max_time, c.time_out_price,c.other_price,c.other_price_start_time,c.other_price_end_time,c.charging_type').where({ 's.id': params.id }).join({
        yxd_seat_cat: {
          join: 'left',
          as: 'c',
          on: ['cat_id', 'id']
        }
      }).find();
      if (think.isEmpty(info)) return _this4.fail('该座位不存在!');
      info.time_range = 0;
      info.goodsList = []; // 商品列表
      if (info.status == 0 || info.status == 1) {
        return _this4.success(info);
      }

      const { price, time_out_price, ohter_out_price, out_date, other_out_date, goodsPrice } = yield _this4.service("charging", "admin").tea(info);
      info.total_price = price;
      info.total_time_out_price = time_out_price;
      info.total_ohter_out_price = ohter_out_price;
      info.out_date = out_date;
      info.other_out_date = other_out_date;
      info.goods_price = goodsPrice;
      // 获取商品列表
      info.goodsList = yield _this4.model('yxd_seat_goods_order').alias('gr').field('gr.*,g.goods_name').join(['LEFT JOIN yxd_tea_goods as g ON gr.goods_id = g.id']).where({ order_id: info.order_id, seat_id: info.id }).select();
      info.order = null; // 订单详情， 如果已结账的情况下
      // 如果已结账
      if (!think.isEmpty(info.order_id)) {
        info.order = yield _this4.model('yxd_tea_order').where({ order_id: info.order_id }).find();
        info.order = think.isEmpty(info.order) ? null : info.order;
      }
      return _this4.success(info);
    })();
  }
  // 读取商品列表
  goodsListAction() {
    var _this5 = this;

    return _asyncToGenerator(function* () {
      const user = _this5.userInfo();
      // 获取商品列表
      const list = yield _this5.model('yxd_tea_goods').where({ shop_id: user.shop_id }).order('sort DESC').select();
      return _this5.success(list);
    })();
  }

  // 给座位添加计费物品
  selectGoodsAction() {
    var _this6 = this;

    return _asyncToGenerator(function* () {
      const params = _this6.post();
      const user = _this6.userInfo();
      const goodsInfo = yield _this6.model('yxd_tea_goods').where({ id: params.id }).find();
      const seatInfo = yield _this6.model('yxd_seat_list').where({ id: params.seat_id }).find();
      if (think.isEmpty(goodsInfo)) return _this6.fail('商品不存在!');
      if (think.isEmpty(seatInfo)) return _this6.fail('座位不存在!');
      if (seatInfo.status !== 2) return _this6.fail('当前座位未计费');
      const data = {
        shop_id: user.shop_id,
        price: goodsInfo.price,
        seat_id: seatInfo.id,
        goods_id: goodsInfo.id,
        order_id: seatInfo.order_id,
        create_time: Date.now()
      };
      const result = yield _this6.model('yxd_seat_goods_order').add(data);
      if (result) return _this6.success('添加成功!');
      return _this6.success('添加失败!');
    })();
  }
  // 删除订单商品
  removeGoodsOrderAction() {
    var _this7 = this;

    return _asyncToGenerator(function* () {
      const params = _this7.post();
      const user = _this7.userInfo();
      const order = yield _this7.model('yxd_tea_order').where({ order_id: params.order_id }).find();
      if (!think.isEmpty(order) && order.status === 0) return _this7.success('订单已锁定!');
      if (!think.isEmpty(order) && order.status === 1) return _this7.fail('订单已完成!');
      const result = yield _this7.model('yxd_seat_goods_order').where({ id: params.id, order_status: 0 }).delete();
      return result ? _this7.success() : _this7.fail('删除失败!');
    })();
  }
  // 结算
  settlementAction() {
    var _this8 = this;

    return _asyncToGenerator(function* () {
      const params = _this8.post();
      if (isNaN(Number(params.discount_price))) return _this8.fail('优惠价格格式错误');
      params.discount_price = Number(params.discount_price);
      const user = _this8.userInfo();
      if (think.isEmpty(params.pay_type)) return _this8.fail('请选择支付方式!');
      const pay_type = _this8.model('yxd_pay_type').where({ id: params.pay_type }).find();
      if (think.isEmpty(pay_type)) return _this8.fail('支付方式不存在!');
      const info = yield _this8.model('yxd_seat_list').alias('s').field('s.*, c.cat_name, c.basics_price, c.max_time, c.time_out_price,c.other_price,c.other_price_start_time,c.other_price_end_time,c.charging_type').where({ 's.id': params.id }).join({
        yxd_seat_cat: {
          join: 'left',
          as: 'c',
          on: ['cat_id', 'id']
        }
      }).find();
      if (think.isEmpty(info)) return _this8.fail('此订单不存在!');
      let order = yield _this8.model('yxd_tea_order').where({ order_id: info.order_id }).find();
      if (!think.isEmpty(order)) {
        console.log('结算总价1', order);
        if (order.status == 0) return _this8.success(order);
        if (order.status == 1) return _this8.fail('无法操作，订单已完成!');
      }
      think.logger.info('结算信息', info);
      const { price, time_out_price, ohter_out_price, out_date, other_out_date, goodsPrice } = yield _this8.service("charging", "admin").tea(info);
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
        guest_source: think.isEmpty(params.guest_source) ? 1 : params.guest_source
      };
      const db = _this8.model('yxd_tea_order').db();
      const orderModel = _this8.model('yxd_tea_order').db(db);
      const goodsOrderModel = _this8.model("yxd_seat_goods_order").db(db);
      const goodsOrderCount = yield _this8.model('yxd_seat_goods_order').where({ order_id: info.order_id, order_status: 0 }).count('id');
      try {
        yield orderModel.startTrans();
        const result = yield orderModel.add(data);
        if (!result) {
          yield orderModel.rollback();
          return _this8.fail('结算失败!');
        }
        const updateGoodsStatus = yield goodsOrderModel.where({ order_id: info.order_id }).update({ order_status: 1 });
        if (updateGoodsStatus !== goodsOrderCount) {
          yield orderModel.rollback();
          return _this8.fail('结算失败!');
        }
        yield orderModel.commit();
        order = yield _this8.model('yxd_tea_order').where({ order_id: info.order_id }).find();
        console.log('结算总价', data);
        return _this8.success(order);
      } catch (e) {
        yield orderModel.rollback();
        return _this8.fail('结算失败!');
      }
    })();
  }
  /** 完成订单确认收款 */
  completeOrderAction() {
    var _this9 = this;

    return _asyncToGenerator(function* () {
      const params = _this9.post();
      const order = yield _this9.model('yxd_tea_order').field('status').where({ order_id: params.id }).find();
      if (think.isEmpty(order)) return _this9.fail('订单不存在!');
      const db = _this9.model('yxd_tea_order').db();
      const orderModel = _this9.model('yxd_tea_order').db(db);
      const seatModel = _this9.model('yxd_seat_list').db(db);
      try {
        yield orderModel.startTrans();
        const updateStatus = yield orderModel.where({ order_id: params.id }).update({ status: 1, complete_time: Date.now() });
        if (!updateStatus && order.status == 0) {
          yield orderModel.rollback();
          return _this9.fail('收款确认失败!');
        }
        const seatData = {
          start_time: null,
          order_id: null,
          user_id: null,
          status: 0
        };
        const updateSeat = yield seatModel.where({ order_id: params.id }).update(seatData);
        orderModel.commit();
        return _this9.success();
      } catch (e) {
        yield orderModel.rollback();
        return _this9.fail('收款确认失败!');
      }
    })();
  }
  /**
   * 获取已完成订单列表
   */
  orderListAction() {
    var _this10 = this;

    return _asyncToGenerator(function* () {
      const [page, pageSize] = _this10.getPage();
      const where = {};
      where['o.shop_id'] = _this10.getShopId();
      const list = yield _this10.model('yxd_tea_order').alias('o').field('o.*, u.nickname, p.pay_name').where(where).order('order_end_time desc').join(['LEFT JOIN sys_user as u ON u.id = o.complete_order_user_id', 'LEFT JOIN yxd_pay_type as p ON o.pay_type = p.id']).page(page, pageSize).select();
      return _this10.success(list);
    })();
  }

  // 获取订单列表
  orderLisCountAction() {
    var _this11 = this;

    return _asyncToGenerator(function* () {
      const count = yield _this11.model('yxd_tea_order').where({ shop_id: _this11.getShopId() }).count('id');
      return _this11.success(count);
    })();
  }
  /** 客源 */
  guestSourceListAction() {
    var _this12 = this;

    return _asyncToGenerator(function* () {
      const list = yield _this12.model('yxd_guest_source').where({ type: 1 }).select();
      return _this12.success(list);
    })();
  }
  // async orderGoodListAction() {
  //   const params = this.post();
  //   if (isEmpty(params.order_id)) return this.fail('订单号错误!');
  //   if (isEmpty(params.seat_id)) return this.fail('座位错误!');
  //   const list = await this.model('yxd_seat_goods_order').where({order_id: params.order_id, seat_id: params.seat_id}).select();
  //   return this.success(list);
  // }
};
//# sourceMappingURL=tea_open_order.js.map