/**
*测试数据
*/
const Base = require('./base.js');
module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async allDataAction() {
    let data=await this.model('sys_test').allData()
    return this.success(data);
  }

  async pageDataAction() {
    let param=this.post();
    let data=await this.model('sys_test').pageData(param);
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    await this.model('sys_test').addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model('sys_test').updateData(param);
    return this.success();
  }

  async delDataAction() {
    let param=this.post();
    await this.model('sys_test').delData(param);
    return this.success();
  }
  async delFlagDataAction() {
    let param=this.post();
    await this.model('sys_test').delFlagData(param);
    return this.success();
  }
};