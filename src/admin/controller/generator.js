const Base = require('./base.js');
const controllerTem = require('../../common/template/controller.js');
const logicTem = require('../../common/template/logic.js');
const modelTem = require('../../common/template/model.js');
const viewTem = require('../../common/template/view.js');

module.exports = class extends Base {
  async indexAction() {
    return this.display();
  }

  async getTablesAction() {
    let data=await this.model('generator').getTables();
    return this.success(data);
  }


  async getColumnsAction() {
  	let param=this.post();
    let data=await this.model('generator').getColumns(param.tablename);
    let _data=[];
    for(const item of data){
    	_data.push({
    		name:item['COLUMN_NAME'],
    		comment:item['COLUMN_COMMENT'],
    		is_show:0,
    		is_search:0,
    	});
    }
    return this.success(_data);
  }

  async todoCodeAction() {
  	let param=this.post();
    let data=await this.model('generator').getColumns(param.tablename);
    let time=think.datetime(new Date(), 'YYYYMMDDHHmmss');
    controllerTem.do(time,param,data);
    logicTem.do(time,param,data);
    modelTem.do(time,param,data);
    viewTem.do(time,param,data);
    return this.success({msg:'代码生成成功！目录为：'+think.config('generator_path')+'/'+time});
  }

}