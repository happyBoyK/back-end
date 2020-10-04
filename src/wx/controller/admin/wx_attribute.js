/**
*属性
*/
const Base = require('../../../admin/controller/base.js');
module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async allDataAction() {
    let data=await this.model('wx_attribute').allData()
    return this.success(data);
  }

  async findListByPidAction() {
    let param=this.post();
    let data=await this.model('wx_attribute').findListByPid(param)
    return this.success(data);
  }
  
  async pageDataAction() {
    let param=this.post();
    let data=await this.model('wx_attribute').pageData(param);
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    await this.model('wx_attribute').addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model('wx_attribute').updateData(param);
    return this.success();
  }

  async delDataAction() {
    let param=this.post();
    await this.model('wx_attribute').delData(param);
    return this.success();
  }
  async delFlagDataAction() {
    let param=this.post();
    await this.model('wx_attribute').delFlagData(param);
    return this.success();
  }
};