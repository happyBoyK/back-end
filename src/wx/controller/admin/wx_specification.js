/**
*规格
*/
const Base = require('../../../admin/controller/base.js');
module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async allDataAction() {
    let data=await this.model('wx_specification').allData()
    return this.success(data);
  }

  async pageDataAction() {
    let param=this.post();
    let data=await this.model('wx_specification').pageData(param);
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    await this.model('wx_specification').addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model('wx_specification').updateData(param);
    return this.success();
  }

  async delDataAction() {
    let param=this.post();
    await this.model('wx_specification').delData(param);
    return this.success();
  }
  async delFlagDataAction() {
    let param=this.post();
    await this.model('wx_specification').delFlagData(param);
    return this.success();
  }
};