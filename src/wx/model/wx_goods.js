module.exports = class extends think.Model {
  /**
   * 获取商品的product
   * @param goodsId
   * @returns {Promise.<*>}
   */
  async getProductList(goodsId) {
    const goods = await this.model('wx_product').where({goods_id: goodsId}).select();
    return goods;
  }

  /**
   * 获取商品的规格信息
   * @param goodsId
   * @returns {Promise.<Array>}
   */
  async getSpecificationList(goodsId) {
    // 根据sku商品信息，查找规格值列表
    const specificationRes = await this.model('wx_goods_specification').alias('gs')
      .field(['gs.*', 's.name'])
      .join({
        table: 'wx_specification',
        join: 'inner',
        as: 's',
        on: ['specification_id', 'id']
      })
      .where({goods_id: goodsId}).select();

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
  }


  async addData(param){
    param.create_date=think.datetime();
    param.del_flag=0;
    param.id=think.uuid('v1');
    await this.add(param);
  }

  async delData(param){
    await this.where({id:param.id}).delete();
  }

  async delFlagData(param){
    let id=param.id;
    await this.where({id:id}).update({update_date:think.datetime(),del_flag:1});
  }

  async updateData(param){
    let id=param.id;
    param.update_date=think.datetime();
    delete param.id;
    delete param.create_date;
    await this.where({id:id}).update(param);
  }

  async pageData(param){
    let sql=this.page(param.current).field(['f.*', 'g.name as categoryname', 'h.name as brandname'])
      .alias('f')
      .join({
        table: 'wx_category',
        join: 'left',
        as: 'g',
        on: ['f.category_id', 'g.id']
      }).join({
        table: 'wx_brand',
        join: 'left',
        as: 'h',
        on: ['f.brand_id', 'h.id']
      }).where({'f.del_flag':0}).order('f.create_date desc');
    if(!think.isEmpty(param.category_id)&&param.category_id!="-1"){
      sql=sql.where({'f.category_id':['like', '%'+param.category_id+'%']});
    }
    if(!think.isEmpty(param.name)){
      sql=sql.where({'f.name':['like', '%'+param.name+'%']});
    }
    if(!think.isEmpty(param.brand_id)&&param.brand_id!="-1"){
      sql=sql.where({'f.brand_id':['like', '%'+param.brand_id+'%']});
    }
    if(!think.isEmpty(param.is_on_sale)&&param.is_on_sale!="-1"){
      sql=sql.where({'f.is_on_sale':['like', '%'+param.is_on_sale+'%']});
    }
    if(!think.isEmpty(param.is_new)&&param.is_new!="-1"){
      sql=sql.where({'f.is_new':['like', '%'+param.is_new+'%']});
    }
    if(!think.isEmpty(param.is_hot)&&param.is_hot!="-1"){
      sql=sql.where({'f.is_hot':['like', '%'+param.is_hot+'%']});
    }
    let data = await sql.countSelect();
    return data;
  }

  async allData(param){
    let data=await this.where({del_flag:0}).select();
    return data;
  }

  async getData(id){
    return await this.where({id: id,del_flag:0}).find();
  }


  async changeStatus(param){
    let id=param.id;
    param.update_date=think.datetime();
    let type=param.type;
    if(type==1){
        await this.where({id:id}).update({is_on_sale:param.data,update_date:param.update_date});
    }else if(type==2){
        await this.where({id:id}).update({is_new:param.data,update_date:param.update_date});
    }else if(type==3){
        await this.where({id:id}).update({is_hot:param.data,update_date:param.update_date});
    }    
  }

};
