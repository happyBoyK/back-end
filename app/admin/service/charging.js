'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const { think } = require("thinkjs");

module.exports = class extends think.Service {

  /**
   * 茶楼计费模型
   * @param {*} 座位数据
   */
  tea(seatInfo) {
    var _this = this;

    return _asyncToGenerator(function* () {
      let price = 0; // 计算费用
      let time_out_price = 0; // 超时费
      let ohter_out_price = 0; // 服务费
      let out_date = 0; // 超时时间
      let other_out_date = 0; // 服务费计算时间
      // 判断座位类型，如果是包间则需计算基础费用，如果不是包间则不需要计算基础费用
      if (seatInfo.charging_type && seatInfo.max_time) {
        // 当前时间
        const currTime = Date.now();
        // const currTime = 1601655609000;
        price = price + seatInfo.basics_price; // 加入基础费用
        // 计算超时费
        const maxTime = seatInfo.start_time + seatInfo.max_time * 60 * 60 * 1000;
        // 没有超出5分钟不计费
        if (currTime > maxTime) {
          let MoreTime = currTime - maxTime; // 得出超出的时间
          MoreTime = Math.floor(MoreTime / 1000 / 60); // 得到超出多少分钟
          const MoreYu = MoreTime % 30; // 取余
          out_date = Math.floor(MoreTime / 60) + '小时' + MoreTime % 60 + '分';
          MoreTime = Math.floor(MoreTime / 30);
          if (MoreYu > 5) MoreTime = MoreTime + 1; // 没超出规定时间5分钟则不计费
          console.log('超时多少个小时', MoreTime / 2, MoreYu);
          time_out_price = MoreTime * seatInfo.time_out_price; // 超时费
          price = price + time_out_price;

          let other_time = _this.getOterTime(seatInfo.start_time, seatInfo.start_time, currTime, seatInfo.other_price_start_time, seatInfo.other_price_end_time);
          // 服务费
          // 产生了服务费
          if (other_time > 0) {
            other_time = Math.floor(other_time / 1000 / 60);
            const otherTimeYu = other_time % 30;
            other_out_date = Math.floor(other_time / 60) + '小时' + other_time % 60 + '分';
            other_time = Math.floor(other_time / 30);
            if (otherTimeYu > 5) {
              other_time = other_time + 1;
            }
            ohter_out_price = other_time * seatInfo.other_price;

            price = price + ohter_out_price;
          }
        }
      }
      let goodsPrice = yield _this.model('yxd_seat_goods_order').where({ seat_id: seatInfo.id, order_id: seatInfo.order_id }).sum('price');
      if (!think.isEmpty(goodsPrice)) price = price + goodsPrice;
      think.logger.info('当前价格为', price, time_out_price, ohter_out_price);
      goodsPrice = goodsPrice ? goodsPrice : 0;
      return { price, time_out_price, ohter_out_price, out_date, other_out_date, goodsPrice };
    })();
  }
  /**
   * 计算收取服务费的总时间
   * @param {*} start_time 座位计费时间 常量
   * @param {*} start_time2 开始时间 变量
   * @param {*} currTime 当前时间 常量
   * @param {*} other_start_date 服务费开始时间 常量
   * @param {*} other_end_date 服务费结束时间 常量
   * @param {*} all_time 总时间 变量
   */
  getOterTime(start_time, start_time2, currTime, other_start_date, other_end_date, all_time = 0) {
    let other_start_time = think.datetime(start_time2, 'YYYY-MM-DD') + ' ' + other_start_date; // 起始时间
    let other_end_time = think.datetime(start_time2, 'YYYY-MM-DD') + ' ' + other_end_date; // 结束时间
    other_start_time = new Date(other_start_time).getTime(); // 计费起始时间
    other_end_time = new Date(other_end_time).getTime(); // 计费结束时间
    think.logger.info('起始时间', think.datetime(other_start_time, 'YYYY-MM-DD HH:mm'));
    think.logger.info('结束时间', think.datetime(other_end_time, 'YYYY-MM-DD HH:mm'));
    other_end_time = other_end_time > currTime ? currTime : other_end_time; // 当前时间是否超过结束时间没有超过则按照当前时间计算，超过了则按照结束时间计算
    // 说明是在服务计费期间开始计时需要减时间
    if (start_time == start_time2 && start_time >= other_start_time && start_time < other_end_time) {
      all_time = all_time + (other_end_time - other_start_time - (start_time - other_start_time));
      start_time2 = other_start_time + 24 * 60 * 60 * 1000;
      think.logger.info('刚好凌晨计费', all_time);
      if (start_time2 < currTime) return this.getOterTime(start_time, start_time2, currTime, other_start_date, other_end_date, all_time);
      return all_time;
    }
    // 还没有到计算服务费的时间
    if (start_time == start_time2 && start_time > other_end_time) {
      if (currTime < other_start_time + 24 * 60 * 60 * 1000) return all_time;
      start_time2 = other_start_time + 24 * 60 * 60 * 1000;
      if (start_time2 < currTime) return this.getOterTime(start_time, start_time2, currTime, other_start_date, other_end_date, all_time);
    }
    think.logger.info('计算时间比较', think.datetime(currTime, 'YYYY-MM-DD HH:mm'), think.datetime(other_start_time, 'YYYY-MM-DD HH:mm'));
    if (currTime < other_start_time) return all_time; // 当前时间还未到计费时刻

    all_time = all_time + (other_end_time - other_start_time);
    think.logger.info('完整计费', Math.floor(all_time / 60 / 1000));
    // 消费时间天+1;
    start_time2 = other_start_time + 24 * 60 * 60 * 1000;
    if (start_time2 < currTime) return this.getOterTime(start_time, start_time2, currTime, other_start_date, other_end_date, all_time);
    return all_time;
  }
};
//# sourceMappingURL=charging.js.map