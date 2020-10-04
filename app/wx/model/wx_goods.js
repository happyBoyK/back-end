function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

module.exports = class extends think.Model {
  /**
   * 获取商品的product
   * @param goodsId
   * @returns {Promise.<*>}
   */
  getProductList(goodsId) {
    var _this = this;

    return _asyncToGenerator(function* () {
      const goods = yield _this.model('wx_product').where({ goods_id: goodsId }).select();
      return goods;
    })();
  }

  /**
   * 获取商品的规格信息
   * @param goodsId
   * @returns {Promise.<Array>}
   */
  getSpecificationList(goodsId) {
    var _this2 = this;

    return _asyncToGenerator(function* () {
      // 根据sku商品信息，查找规格值列表
      const specificationRes = yield _this2.model('wx_goods_specification').alias('gs').field(['gs.*', 's.name']).join({
        table: 'wx_specification',
        join: 'inner',
        as: 's',
        on: ['specification_id', 'id']
      }).where({ goods_id: goodsId }).select();

      const specificationList = [];
      const hasSpecificationList = {};
      // 按规格名称分组
      for (let i = 0; i < specificationRes.length; i++) {
        const specItem = specificationRes[i];
        if (!hasSpecificationList[specItem.specification_id]) {
          specificationList.push({
            specification_id: specItem.specification_id,
            name: specItem.name,
            valueList: [specItem]
          });
          hasSpecificationList[specItem.specification_id] = specItem;
        } else {
          for (let j = 0; j < specificationList.length; j++) {
            if (specificationList[j].specification_id === specItem.specification_id) {
              specificationList[j].valueList.push(specItem);
              break;
            }
          }
        }
      }

      return specificationList;
    })();
  }

  addData(param) {
    var _this3 = this;

    return _asyncToGenerator(function* () {
      param.create_date = think.datetime();
      param.del_flag = 0;
      param.id = think.uuid('v1');
      yield _this3.add(param);
    })();
  }

  delData(param) {
    var _this4 = this;

    return _asyncToGenerator(function* () {
      yield _this4.where({ id: param.id }).delete();
    })();
  }

  delFlagData(param) {
    var _this5 = this;

    return _asyncToGenerator(function* () {
      let id = param.id;
      yield _this5.where({ id: id }).update({ update_date: think.datetime(), del_flag: 1 });
    })();
  }

  updateData(param) {
    var _this6 = this;

    return _asyncToGenerator(function* () {
      let id = param.id;
      param.update_date = think.datetime();
      delete param.id;
      delete param.create_date;
      yield _this6.where({ id: id }).update(param);
    })();
  }

  pageData(param) {
    var _this7 = this;

    return _asyncToGenerator(function* () {
      let sql = _this7.page(param.current).field(['f.*', 'g.name as categoryname', 'h.name as brandname']).alias('f').join({
        table: 'wx_category',
        join: 'left',
        as: 'g',
        on: ['f.category_id', 'g.id']
      }).join({
        table: 'wx_brand',
        join: 'left',
        as: 'h',
        on: ['f.brand_id', 'h.id']
      }).where({ 'f.del_flag': 0 }).order('f.create_date desc');
      if (!think.isEmpty(param.category_id) && param.category_id != "-1") {
        sql = sql.where({ 'f.category_id': ['like', '%' + param.category_id + '%'] });
      }
      if (!think.isEmpty(param.name)) {
        sql = sql.where({ 'f.name': ['like', '%' + param.name + '%'] });
      }
      if (!think.isEmpty(param.brand_id) && param.brand_id != "-1") {
        sql = sql.where({ 'f.brand_id': ['like', '%' + param.brand_id + '%'] });
      }
      if (!think.isEmpty(param.is_on_sale) && param.is_on_sale != "-1") {
        sql = sql.where({ 'f.is_on_sale': ['like', '%' + param.is_on_sale + '%'] });
      }
      if (!think.isEmpty(param.is_new) && param.is_new != "-1") {
        sql = sql.where({ 'f.is_new': ['like', '%' + param.is_new + '%'] });
      }
      if (!think.isEmpty(param.is_hot) && param.is_hot != "-1") {
        sql = sql.where({ 'f.is_hot': ['like', '%' + param.is_hot + '%'] });
      }
      let data = yield sql.countSelect();
      return data;
    })();
  }

  allData(param) {
    var _this8 = this;

    return _asyncToGenerator(function* () {
      let data = yield _this8.where({ del_flag: 0 }).select();
      return data;
    })();
  }

  getData(id) {
    var _this9 = this;

    return _asyncToGenerator(function* () {
      return yield _this9.where({ id: id, del_flag: 0 }).find();
    })();
  }

  changeStatus(param) {
    var _this10 = this;

    return _asyncToGenerator(function* () {
      let id = param.id;
      param.update_date = think.datetime();
      let type = param.type;
      if (type == 1) {
        yield _this10.where({ id: id }).update({ is_on_sale: param.data, update_date: param.update_date });
      } else if (type == 2) {
        yield _this10.where({ id: id }).update({ is_new: param.data, update_date: param.update_date });
      } else if (type == 3) {
        yield _this10.where({ id: id }).update({ is_hot: param.data, update_date: param.update_date });
      }
    })();
  }

};
//# sourceMappingURL=wx_goods.js.map