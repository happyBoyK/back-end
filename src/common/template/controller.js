/**
 * 自动生成代码：controller模版
 * 2018年1月17日 
 */
const fs = require('fs');
const common = require('../util/common.js');
const _path='/back-end/src/';

module.exports =  {
  do(time,param,data) {
  	/**
  	*创建目录
  	*/
  	let mokuai=param.mokuainame;
  	let index=mokuai.indexOf('/');
  	let targetDir=think.config('generator_path')+'/'+time+_path+(index<0?mokuai:mokuai.substring(0,index))+'/controller'+(index<0?'':mokuai.substring(index,mokuai.length));
  	common.mkdirs(targetDir);
  	let file=targetDir+'/'+param.tablename+'.js';
	let template=
		"/**\r\n"+
	  	"*"+param.tablecomment+"\r\n"+
	  	"*/\r\n"+
		"const Base = require('../../../admin/controller/base.js');\r\n"+
		"module.exports = class extends Base {\r\n"+
		"  async indexAction() {\r\n"+
		"    return this.display();\r\n"+
		"  }\r\n"+
		"\r\n"+
		"  async allDataAction() {\r\n"+
		"    let data=await this.model('"+param.tablename+"').allData()\r\n"+
		"    return this.success(data);\r\n"+
		"  }\r\n"+
		"\r\n"+
		"  async pageDataAction() {\r\n"+
		"    let param=this.post();\r\n"+
		"    let data=await this.model('"+param.tablename+"').pageData(param);\r\n"+
		"    return this.success(data);\r\n"+
		"  }\r\n"+
		"\r\n"+
		"  async addDataAction() {\r\n"+
		"    let param=this.post();\r\n"+
		"    await this.model('"+param.tablename+"').addData(param);\r\n"+
		"    return this.success();\r\n"+
		"  }\r\n"+
		"\r\n"+
		"  async updateDataAction() {\r\n"+
		"    let param=this.post();\r\n"+
		"    await this.model('"+param.tablename+"').updateData(param);\r\n"+
		"    return this.success();\r\n"+
		"  }\r\n"+
		"\r\n"+
		"  async delDataAction() {\r\n"+
		"    let param=this.post();\r\n"+
		"    await this.model('"+param.tablename+"').delData(param);\r\n"+
		"    return this.success();\r\n"+
		"  }\r\n"+
		"  async delFlagDataAction() {\r\n"+
		"    let param=this.post();\r\n"+
		"    await this.model('"+param.tablename+"').delFlagData(param);\r\n"+
		"    return this.success();\r\n"+
		"  }\r\n"+
		"};";
	fs.writeFileSync(file,template);
  }
};
