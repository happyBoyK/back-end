const Base = require('./base.js');

module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async allDataAction() {
    let data=await this.model("sys_dict").allData()
    return this.success(data);
  }

  async pageDataAction() {
    let param=this.post();
    let data=await this.model("sys_dict").pageData(param);
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    await this.model("sys_dict").addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model("sys_dict").updateData(param);
    return this.success();
  }

  async delDataAction() {
    let param=this.post();
    await this.model("sys_dict").delData(param);
    return this.success();
  }

};
