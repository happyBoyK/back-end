const Base = require('./base.js');

module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async loginAction() {
    let param=this.post();
    let data=await this.model("sys_user").login(param);
    if(think.isEmpty(data)){
      return this.fail(9996);
    }else{
      data.token= this.service("token","admin").createToken(data);
      data.menu= await this.model("sys_menu").getMyMenuData(data.id,data.role_id);
      data.dicts=await this.model("sys_dict").getGroupData();
      return this.success(data);
    }
    
  }

  async myDetailAction() {
    let data=await this.model("sys_user").myDetail(this.userInfo().id);
    return this.success(data);
  }

  async updateInfoAction() {
    let param=this.post();
    param.id=this.userInfo().id;
    await this.model("sys_user").updateInfo(param);
    return this.success();
  }

  async updatePwdAction() {
    let param=this.post();
    param.id=this.userInfo().id;
    let data=await this.model("sys_user").getData(param.id);
    if(data.password!=think.md5(param.oldPass)){
      return this.fail(9994);
    }
    await this.model("sys_user").updatePwd(param);
    return this.success();
  }


  async allDataAction() {
    let data=await this.model("sys_user").allData()
    return this.success(data);
  }

  async pageDataAction() {
    let param=this.post();
    let data=await this.model("sys_user").pageData(param);
    return this.success(data);
  }

  async addDataAction() {
    let param=this.post();
    let data=await this.model("sys_user").findByLoginName(param.login_name);
    if(!think.isEmpty(data)){
      return this.fail(9995);
    }
    await this.model("sys_user").addData(param);
    return this.success();
  }

  async updateDataAction() {
    let param=this.post();
    await this.model("sys_user").updateData(param);
    return this.success();
  }

  async changeStatusAction() {
    let param=this.post();
    await this.model("sys_user").changeStatus(param);
    return this.success();
  }

  async resetPwdAction() {
    let param=this.post();
    await this.model("sys_user").resetPwd(param);
    return this.success();
  }

  async delDataAction() {
    let param=this.post();
    await this.model("sys_user").delData(param);
    return this.success();
  }

};
