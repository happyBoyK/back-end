/**
*分类
*/
const Base = require('../../../admin/controller/base.js');
module.exports = class extends Base {
  
  async indexAction() {
    return this.display();
  }

  async allDataAction() {
    let data=await this.model('wx_category').allData()
    return this.success(data);
  }

  async pageDataAction() {
    let param=this.post();
    let data=await this.model('wx_category').pageData(param);
    return this.success(data);
  }

  async categoryListAction() {
    let data=await this.model('wx_category').categoryList()
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    await this.model('wx_category').addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model('wx_category').updateData(param);
    return this.success();
  }

  async delDataAction() {
    let param=this.post();
    await this.model('wx_category').delData(param);
    return this.success();
  }
  async delFlagDataAction() {
    let param=this.post();
    await this.model('wx_category').delFlagData(param);
    return this.success();
  }
};