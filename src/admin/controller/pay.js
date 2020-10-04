const { think } = require('thinkjs');
const Base = require('./base.js');

module.exports = class extends Base {
  async payTypeListAction() {
    const list = await this.model('yxd_pay_type').select();
    return this.success(list);
  }
}