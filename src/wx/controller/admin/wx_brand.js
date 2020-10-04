/**
*制造商
*/
const Base = require('../../../admin/controller/base.js');
module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async allDataAction() {
    let data=await this.model('wx_brand').allData()
    return this.success(data);
  }

  async pageDataAction() {
    let param=this.post();
    let data=await this.model('wx_brand').pageData(param);
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    await this.model('wx_brand').addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model('wx_brand').updateData(param);
    return this.success();
  }

  async delDataAction() {
    let param=this.post();
    await this.model('wx_brand').delData(param);
    return this.success();
  }
  async delFlagDataAction() {
    let param=this.post();
    await this.model('wx_brand').delFlagData(param);
    return this.success();
  }

  async changeStatusAction() {
    let param=this.post();
    await this.model("wx_brand").changeStatus(param);
    return this.success();
  }
};