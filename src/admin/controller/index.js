const Base = require('./base.js');

module.exports = class extends Base {
  async indexAction() {
    // return this.display();
    const sys_user=this.model('sys_user');
    sys_user.where({id:1});
    sys_user.where({name1:1});
    await sys_user.find();
    return this.success({"id":2});
  }
};
