function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const Base = require('./base.js');

module.exports = class extends Base {
  indexAction() {
    var _this = this;

    return _asyncToGenerator(function* () {
      return _this.display();
    })();
  }

  loginAction() {
    var _this2 = this;

    return _asyncToGenerator(function* () {
      let param = _this2.post();
      let data = yield _this2.model("sys_user").login(param);
      if (think.isEmpty(data)) {
        return _this2.fail(9996);
      } else {
        data.token = _this2.service("token", "admin").createToken(data);
        data.menu = yield _this2.model("sys_menu").getMyMenuData(data.id, data.role_id);
        data.dicts = yield _this2.model("sys_dict").getGroupData();
        return _this2.success(data);
      }
    })();
  }

  myDetailAction() {
    var _this3 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this3.model("sys_user").myDetail(_this3.userInfo().id);
      return _this3.success(data);
    })();
  }

  updateInfoAction() {
    var _this4 = this;

    return _asyncToGenerator(function* () {
      let param = _this4.post();
      param.id = _this4.userInfo().id;
      yield _this4.model("sys_user").updateInfo(param);
      return _this4.success();
    })();
  }

  updatePwdAction() {
    var _this5 = this;

    return _asyncToGenerator(function* () {
      let param = _this5.post();
      param.id = _this5.userInfo().id;
      let data = yield _this5.model("sys_user").getData(param.id);
      if (data.password != think.md5(param.oldPass)) {
        return _this5.fail(9994);
      }
      yield _this5.model("sys_user").updatePwd(param);
      return _this5.success();
    })();
  }

  allDataAction() {
    var _this6 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this6.model("sys_user").allData();
      return _this6.success(data);
    })();
  }

  pageDataAction() {
    var _this7 = this;

    return _asyncToGenerator(function* () {
      let param = _this7.post();
      let data = yield _this7.model("sys_user").pageData(param);
      return _this7.success(data);
    })();
  }

  addDataAction() {
    var _this8 = this;

    return _asyncToGenerator(function* () {
      let param = _this8.post();
      let data = yield _this8.model("sys_user").findByLoginName(param.login_name);
      if (!think.isEmpty(data)) {
        return _this8.fail(9995);
      }
      yield _this8.model("sys_user").addData(param);
      return _this8.success();
    })();
  }

  updateDataAction() {
    var _this9 = this;

    return _asyncToGenerator(function* () {
      let param = _this9.post();
      yield _this9.model("sys_user").updateData(param);
      return _this9.success();
    })();
  }

  changeStatusAction() {
    var _this10 = this;

    return _asyncToGenerator(function* () {
      let param = _this10.post();
      yield _this10.model("sys_user").changeStatus(param);
      return _this10.success();
    })();
  }

  resetPwdAction() {
    var _this11 = this;

    return _asyncToGenerator(function* () {
      let param = _this11.post();
      yield _this11.model("sys_user").resetPwd(param);
      return _this11.success();
    })();
  }

  delDataAction() {
    var _this12 = this;

    return _asyncToGenerator(function* () {
      let param = _this12.post();
      yield _this12.model("sys_user").delData(param);
      return _this12.success();
    })();
  }

};
//# sourceMappingURL=sys_user.js.map