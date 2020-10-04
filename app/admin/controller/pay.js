function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const { think } = require('thinkjs');
const Base = require('./base.js');

module.exports = class extends Base {
  payTypeListAction() {
    var _this = this;

    return _asyncToGenerator(function* () {
      const list = yield _this.model('yxd_pay_type').select();
      return _this.success(list);
    })();
  }
};
//# sourceMappingURL=pay.js.map