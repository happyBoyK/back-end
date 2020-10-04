const Base = require('./base.js');

module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async myMenuAction() {
    return await this.model("sys_menu").getMyMenuData(this.userInfo().id,this.userInfo().role_id);
  }

  async allDataAction() {
    let data=await this.model("sys_menu").allData();
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    await this.model("sys_menu").addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model("sys_menu").updateData(param);
    return this.success();
  }

  async delDataAction() {
    let param=this.post();
    await this.model("sys_menu").delData(param);
    return this.success();
  }

  async getMenuTreeAction() {
    let data = await this.model("sys_menu").getMenuTree();

    return this.success(data);
  }

  async getMenuTreeIdsAction() {
    let param = this.post();
    let data = await this.model('sys_role_menu').field('menu_id as id').where({role_id: param.id}).select();
    const list = [];
    for (const item of data) {
      list.push(item.id);
    }
    return this.success(list);
  }

};
