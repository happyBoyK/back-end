function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const Base = require('./base.js');

module.exports = class extends Base {
  indexAction() {
    var _this = this;

    return _asyncToGenerator(function* () {
      // return this.display();
      const sys_user = _this.model('sys_user');
      sys_user.where({ id: 1 });
      sys_user.where({ name1: 1 });
      yield sys_user.find();
      return _this.success({ "id": 2 });
    })();
  }
};
//# sourceMappingURL=index.js.map