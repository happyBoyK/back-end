
'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const { think } = require("thinkjs");

//定义用户数据变量
module.exports = class extends think.Controller {
  user;
  /**
   *@description action请求验证用户token
   */
  __before() {
    var _this = this;

    return _asyncToGenerator(function* () {
      if (_this.ctx.method != 'POST') {
        return _this.fail(9993);
      }
      if (_this.ctx.action === 'login' || _this.ctx.action === 'register') {
        return;
      }

      //登录、注册不验证token
      if (_this.ctx.action === 'login' || _this.ctx.action === 'register') {
        return;
      }
      //获取http-header token
      let userToken = _this.header("x-token");
      if (think.isEmpty(userToken)) {
        return _this.fail(9998);
      }
      //调用tokenservice中间件
      let tokenServiceInstance = _this.service("token", "admin");
      //验证token
      let verifyTokenResult = yield tokenServiceInstance.verifyToken(userToken);
      //服务器错误时
      if (!verifyTokenResult) {
        return _this.fail(9997);
      }
      //获取用户信息
      _this.user = verifyTokenResult.userinfo;
      //写入新token
      /*
      let newToken = await tokenServiceInstance.createToken({
        userInfo: verifyTokenResult.userInfo
      });
      this.header("x-token", newToken);
      */
    })();
  }
  getPage() {
    const params = this.get();
    let page = think.isEmpty(Number(params.page)) ? 1 : Number(params.page);
    let pageSize = think.isEmpty(Number(params.pageSize)) ? 10 : Number(params.pageSize);
    page = page < 1 ? 1 : page;
    pageSize = pageSize < 10 ? 10 : pageSize;
    return [page, pageSize];
  }
  getShopId() {
    const user = this.userInfo();
    return user.shop_id;
  }
  //用户信息
  userInfo() {
    return this.user;
  }
};
//# sourceMappingURL=base.js.map