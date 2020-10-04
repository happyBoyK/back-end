function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

const Base = require('./base.js');
const controllerTem = require('../../common/template/controller.js');
const logicTem = require('../../common/template/logic.js');
const modelTem = require('../../common/template/model.js');
const viewTem = require('../../common/template/view.js');

module.exports = class extends Base {
  indexAction() {
    var _this = this;

    return _asyncToGenerator(function* () {
      return _this.display();
    })();
  }

  getTablesAction() {
    var _this2 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this2.model('generator').getTables();
      return _this2.success(data);
    })();
  }

  getColumnsAction() {
    var _this3 = this;

    return _asyncToGenerator(function* () {
      let param = _this3.post();
      let data = yield _this3.model('generator').getColumns(param.tablename);
      let _data = [];
      for (const item of data) {
        _data.push({
          name: item['COLUMN_NAME'],
          comment: item['COLUMN_COMMENT'],
          is_show: 0,
          is_search: 0
        });
      }
      return _this3.success(_data);
    })();
  }

  todoCodeAction() {
    var _this4 = this;

    return _asyncToGenerator(function* () {
      let param = _this4.post();
      let data = yield _this4.model('generator').getColumns(param.tablename);
      let time = think.datetime(new Date(), 'YYYYMMDDHHmmss');
      controllerTem.do(time, param, data);
      logicTem.do(time, param, data);
      modelTem.do(time, param, data);
      viewTem.do(time, param, data);
      return _this4.success({ msg: '代码生成成功！目录为：' + think.config('generator_path') + '/' + time });
    })();
  }

};
//# sourceMappingURL=generator.js.map