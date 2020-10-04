/**
 * 自动生成代码：model模版
 * 2018年1月17日 
 */
const fs = require('fs');
const common = require('../util/common.js');
const _path='/back-end/src/';

module.exports =  {
  do(time,param,data) {
  	/*
  	创建目录
  	 */
    let mokuai=param.mokuainame;
    let index=mokuai.indexOf('/');
  	let targetDir=think.config('generator_path')+'/'+time+_path+(index<0?mokuai:mokuai.substring(0,index))+'/model';
  	common.mkdirs(targetDir);
  	let file=targetDir+'/'+param.tablename+'.js';
  	let template=
      "/**\r\n"+
      "*"+param.tablecomment+"\r\n"+
      "*/\r\n"+
  		"'use strict';\r\n"+
      "module.exports = class extends think.Model {\r\n"+
      "\r\n"+
      "  async addData(param){\r\n"+
      "    param.create_date=think.datetime();\r\n"+
      "    param.del_flag=0;\r\n"+
      "    param.id=think.uuid('v1');\r\n"+
      "    await this.add(param);\r\n"+
      "  }\r\n"+
      "\r\n"+
      "  async delData(param){\r\n"+
      "    await this.where({id:param.id}).delete();\r\n"+
      "  }\r\n"+
      "\r\n"+
      "  async delFlagData(param){\r\n"+
      "    let id=param.id;\r\n"+
      "    await this.where({id:id}).update({update_date:think.datetime(),del_flag:1});\r\n"+
      "  }\r\n"+
      "\r\n"+
      "  async updateData(param){\r\n"+
      "    let id=param.id;\r\n"+
      "    param.update_date=think.datetime();\r\n"+
      "    delete param.id;\r\n"+
      "    delete param.create_date;\r\n"+
      "    await this.where({id:id}).update(param);\r\n"+
      "  }\r\n"+
      "\r\n"+
      "  async pageData(param){\r\n"+
      "    let sql=this.page(param.current).where({del_flag:0}).order('create_date desc');\r\n";
      for(let p of param.parameter){
        if(p.is_search==1){
          template+=
          "    if(!think.isEmpty(param."+p.name+")){\r\n"+
          "      sql=sql.where({"+p.name+":['like', '%'+param."+p.name+"+'%']});\r\n"+
          "    }\r\n";
        }
      }
      template+=
      "    let data = await sql.countSelect();\r\n"+
      "    return data;\r\n"+
      "  }\r\n"+
      "\r\n"+
      "  async allData(param){\r\n"+
      "    let data=await this.where({del_flag:0}).select();\r\n"+
      "    return data;\r\n"+
      "  }\r\n"+
      "\r\n"+
      "  async getData(id){\r\n"+
      "    return await this.where({id: id,del_flag:0}).find();\r\n"+
      "  }\r\n"+
      "};";
  	fs.writeFileSync(file,template);
  }
};
