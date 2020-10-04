/**
*分类
*/
'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

module.exports = class extends think.Model {
  getChildCategoryId(parentId) {
    var _this = this;

    return _asyncToGenerator(function* () {
      const childIds = yield _this.where({ parent_id: parentId }).getField('id', 10000);
      return childIds;
    })();
  }

  getCategoryWhereIn(categoryId) {
    var _this2 = this;

    return _asyncToGenerator(function* () {
      const childIds = yield _this2.getChildCategoryId(categoryId);
      childIds.push(categoryId);
      return childIds;
    })();
  }

  addData(param) {
    var _this3 = this;

    return _asyncToGenerator(function* () {
      param.create_date = think.datetime();
      param.parent_id = 0;
      param.del_flag = 0;
      //param.id=think.uuid('v1');
      yield _this3.add(param);
    })();
  }

  addData2(param) {
    var _this4 = this;

    return _asyncToGenerator(function* () {
      param.create_date = think.datetime();
      param.del_flag = 0;
      //param.id=think.uuid('v1');
      yield _this4.add(param);
    })();
  }

  delData(param) {
    var _this5 = this;

    return _asyncToGenerator(function* () {
      yield _this5.where({ id: param.id }).delete();
    })();
  }

  delFlagData(param) {
    var _this6 = this;

    return _asyncToGenerator(function* () {
      let id = param.id;
      yield _this6.where({ id: id }).update({ update_date: think.datetime(), del_flag: 1 });
    })();
  }

  updateData(param) {
    var _this7 = this;

    return _asyncToGenerator(function* () {
      let id = param.id;
      param.update_date = think.datetime();
      delete param.id;
      delete param.parent_id;
      delete param.create_date;
      yield _this7.where({ id: id }).update(param);
    })();
  }

  pageData(param) {
    var _this8 = this;

    return _asyncToGenerator(function* () {
      let sql = _this8.page(param.current).order('sort_order').where({ del_flag: 0, parent_id: 0 });
      if (!think.isEmpty(param.name)) {
        sql = sql.where({ name: ['like', '%' + param.name + '%'] });
      }
      let data = yield sql.countSelect();
      return data;
    })();
  }

  categoryList() {
    var _this9 = this;

    return _asyncToGenerator(function* () {
      let _data = [];
      let data = yield _this9.order('sort_order').where({ del_flag: 0, parent_id: 0 }).select();
      for (var i = 0; i < data.length; i++) {
        let item = data[i];
        let len = _data.push(item);
        let child = yield _this9.where({ parent_id: item.id, del_flag: 0 }).order("sort_order").select();
        _data[len - 1].child = child;
      }
      return data;
    })();
  }

  pageData2(param) {
    var _this10 = this;

    return _asyncToGenerator(function* () {
      let sql = _this10.page(param.current).order('sort_order').where({ del_flag: 0, parent_id: param.pid });
      if (!think.isEmpty(param.name)) {
        sql = sql.where({ name: ['like', '%' + param.name + '%'] });
      }
      let data = yield sql.countSelect();
      return data;
    })();
  }

  allData(param) {
    var _this11 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this11.where({ del_flag: 0 }).select();
      return data;
    })();
  }

  getData(id) {
    var _this12 = this;

    return _asyncToGenerator(function* () {
      return yield _this12.where({ id: id, del_flag: 0 }).find();
    })();
  }
};
//# sourceMappingURL=wx_category.js.map