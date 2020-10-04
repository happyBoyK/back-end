const { think } = require('thinkjs');
const Base = require('./base.js');

module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async allDataAction() {
    let data=await this.model("sys_role").allData()
    return this.success(data);
  }

  async pageDataAction() {
    let param=this.post();
    let data=await this.model("sys_role").pageData(param);
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    think.logger.info('接受到的参数', param);
    await this.model("sys_role").addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model("sys_role").updateData(param);
    return this.success();
  }   
    
  async delDataAction() {
    let param=this.post();
    await this.model("sys_role").delData(param);
    return this.success();
  }

};
