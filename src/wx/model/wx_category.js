/**
*分类
*/
'use strict';
module.exports = class extends think.Model {
  async getChildCategoryId(parentId) {
    const childIds = await this.where({parent_id: parentId}).getField('id', 10000);
    return childIds;
  }

  async getCategoryWhereIn(categoryId) {
    const childIds = await this.getChildCategoryId(categoryId);
    childIds.push(categoryId);
    return childIds;
  }

  async addData(param){
    param.create_date=think.datetime();
    param.parent_id=0;
    param.del_flag=0;
    //param.id=think.uuid('v1');
    await this.add(param);
  }

  async addData2(param){
    param.create_date=think.datetime();
    param.del_flag=0;
    //param.id=think.uuid('v1');
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
    delete param.parent_id;
    delete param.create_date;
    await this.where({id:id}).update(param);
  }

  async pageData(param){
    let sql=this.page(param.current).order('sort_order').where({del_flag:0,parent_id:0});
    if(!think.isEmpty(param.name)){
      sql=sql.where({name:['like', '%'+param.name+'%']});
    }
    let data = await sql.countSelect();
    return data;
  }

  async categoryList(){
  	let _data=[];
    let data=await this.order('sort_order').where({del_flag:0,parent_id:0}).select();
    for (var i = 0; i < data.length; i++) {		
		let item=data[i];
		let len =_data.push(item);
        let child=await this.where({parent_id:item.id,del_flag:0}).order("sort_order").select();
		_data[len - 1].child = child;
    }
    return data;
  }


  async pageData2(param){
    let sql=this.page(param.current).order('sort_order').where({del_flag:0,parent_id:param.pid});
    if(!think.isEmpty(param.name)){
      sql=sql.where({name:['like', '%'+param.name+'%']});
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
};