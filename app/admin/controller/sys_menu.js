function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const Base = require('./base.js');

module.exports = class extends Base {
  indexAction() {
    var _this = this;

    return _asyncToGenerator(function* () {
      return _this.display();
    })();
  }

  myMenuAction() {
    var _this2 = this;

    return _asyncToGenerator(function* () {
      return yield _this2.model("sys_menu").getMyMenuData(_this2.userInfo().id, _this2.userInfo().role_id);
    })();
  }

  allDataAction() {
    var _this3 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this3.model("sys_menu").allData();
      return _this3.success(data);
    })();
  }

  addDataAction() {
    var _this4 = this;

    return _asyncToGenerator(function* () {
      let param = _this4.post();
      yield _this4.model("sys_menu").addData(param);
      return _this4.success();
    })();
  }

  updateDataAction() {
    var _this5 = this;

    return _asyncToGenerator(function* () {
      let param = _this5.post();
      yield _this5.model("sys_menu").updateData(param);
      return _this5.success();
    })();
  }

  delDataAction() {
    var _this6 = this;

    return _asyncToGenerator(function* () {
      let param = _this6.post();
      yield _this6.model("sys_menu").delData(param);
      return _this6.success();
    })();
  }

  getMenuTreeAction() {
    var _this7 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this7.model("sys_menu").getMenuTree();

      return _this7.success(data);
    })();
  }

  getMenuTreeIdsAction() {
    var _this8 = this;

    return _asyncToGenerator(function* () {
      let param = _this8.post();
      let data = yield _this8.model('sys_role_menu').field('menu_id as id').where({ role_id: param.id }).select();
      const list = [];
      for (const item of data) {
        list.push(item.id);
      }
      return _this8.success(list);
    })();
  }

};
//# sourceMappingURL=sys_menu.js.map