function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

/**
*商品轮播图
*/
const Base = require('../../../admin/controller/base.js');
module.exports = class extends Base {
  indexAction() {
    var _this = this;

    return _asyncToGenerator(function* () {
      return _this.display();
    })();
  }

  allDataAction() {
    var _this2 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this2.model('wx_goods_gallery').allData();
      return _this2.success(data);
    })();
  }

  pageDataAction() {
    var _this3 = this;

    return _asyncToGenerator(function* () {
      let param = _this3.post();
      let data = yield _this3.model('wx_goods_gallery').pageData(param);
      return _this3.success(data);
    })();
  }

  addDataAction() {
    var _this4 = this;

    return _asyncToGenerator(function* () {
      let param = _this4.post();
      yield _this4.model('wx_goods_gallery').addData(param);
      return _this4.success();
    })();
  }

  updateDataAction() {
    var _this5 = this;

    return _asyncToGenerator(function* () {
      let param = _this5.post();
      yield _this5.model('wx_goods_gallery').updateData(param);
      return _this5.success();
    })();
  }

  delDataAction() {
    var _this6 = this;

    return _asyncToGenerator(function* () {
      let param = _this6.post();
      yield _this6.model('wx_goods_gallery').delData(param);
      return _this6.success();
    })();
  }
  delFlagDataAction() {
    var _this7 = this;

    return _asyncToGenerator(function* () {
      let param = _this7.post();
      yield _this7.model('wx_goods_gallery').delFlagData(param);
      return _this7.success();
    })();
  }
};
//# sourceMappingURL=wx_goods_gallery.js.map