/**
*商品的常见问题
*/
'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

module.exports = class extends think.Model {

  addData(param) {
    var _this = this;

    return _asyncToGenerator(function* () {
      param.create_date = think.datetime();
      param.del_flag = 0;
      param.id = think.uuid('v1');
      yield _this.add(param);
    })();
  }

  delData(param) {
    var _this2 = this;

    return _asyncToGenerator(function* () {
      yield _this2.where({ id: param.id }).delete();
    })();
  }

  delFlagData(param) {
    var _this3 = this;

    return _asyncToGenerator(function* () {
      let id = param.id;
      yield _this3.where({ id: id }).update({ update_date: think.datetime(), del_flag: 1 });
    })();
  }

  updateData(param) {
    var _this4 = this;

    return _asyncToGenerator(function* () {
      let id = param.id;
      param.update_date = think.datetime();
      delete param.id;
      delete param.create_date;
      yield _this4.where({ id: id }).update(param);
    })();
  }

  pageData(param) {
    var _this5 = this;

    return _asyncToGenerator(function* () {
      let sql = _this5.page(param.current).where({ del_flag: 0, goods_id: param.goods_id }).order('create_date desc');
      let data = yield sql.countSelect();
      return data;
    })();
  }

  allData(param) {
    var _this6 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this6.where({ del_flag: 0 }).select();
      return data;
    })();
  }

  getData(id) {
    var _this7 = this;

    return _asyncToGenerator(function* () {
      return yield _this7.where({ id: id, del_flag: 0 }).find();
    })();
  }
};
//# sourceMappingURL=wx_goods_issue.js.map