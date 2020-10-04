function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const Base = require('./base.js');
const qiniu = require('qiniu');
const accessKey = think.config('qiniu_ak');
const secretKey = think.config('qiniu_sk');
const bucket = think.config('qiniu_bucket');
const key = think.config('qiniu_key');

module.exports = class extends Base {
  indexAction() {
    var _this = this;

    return _asyncToGenerator(function* () {
      return _this.success();
    })();
  }

  uploadTokenAction() {
    const mac = new qiniu.auth.digest.Mac(accessKey, secretKey);
    const options = {
      scope: bucket //+ ':'+key
    };
    const putPolicy = new qiniu.rs.PutPolicy(options);
    const uploadToken = putPolicy.uploadToken(mac);
    return this.success({ 'token': uploadToken });
  }
};
//# sourceMappingURL=common.js.map