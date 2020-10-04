'use strict';

module.exports = class extends think.Model {
	async addData(param){
		param.create_date=think.datetime();
		param.del_flag=0;
		param.id=think.uuid('v1');
		param.password=think.md5('111111');
		param.status=1;
		await this.add(param);
	}


	async delData(param){
		await this.where({id:param.id}).delete();
	}

	async updateData(param){
		let id=param.id;
		param.update_date=think.datetime();
		delete param.id;
		delete param.create_date;
		delete param.password;
		await this.where({id:id}).update(param);
	}

	async updateInfo(param){
		let id=param.id;
		param.update_date=think.datetime();
		await this.where({id:id}).update({update_date:param.update_date,
			name:param.name,email:param.email,phone:param.phone});
	}


	async changeStatus(param){
		let id=param.id;
		param.update_date=think.datetime();
		await this.where({id:id}).update({status:param.status,update_date:param.update_date});
	}

	async resetPwd(param){
		let id=param.id;
		param.update_date=think.datetime();
		await this.where({id:id}).update({password:think.md5('111111'),update_date:param.update_date});
	}

	async updatePwd(param){
		let id=param.id;
		param.update_date=think.datetime();
		await this.where({id:id}).update({password:think.md5(param.newPass),update_date:param.update_date});
	}


	async pageData(param){
		let sql=this.alias('a').join({
	      table: 'sys_role',
	      as: 'b',
	      on: ['role_id', 'id']
	    }).field("a.*,b.name as rolename").where({'a.id': ['!=', 1]}).page(param.current).order("create_date desc");
		if(!think.isEmpty(param.name)){
			sql=sql.where({'a.name':['like', '%'+param.name+'%']});
		}
		let data = await sql.countSelect();
		return data;
	}

	async myDetail(id){
		let data= await this.alias('a').join({
	      table: 'sys_role',
	      as: 'b',
	      on: ['role_id', 'id']
	    }).field("a.*,b.name as rolename").where({'a.id': id}).find();
	    delete data.password;
	    if(id=='1'){
			data.rolename='超级管理员';
	    }
	    return data;
	}

	async allData(param){
		let data=await this.where({del_flag:0}).select();
		return data;
	}

	async getData(id){
		return await this.where({id: id}).find();
	}

	async findByLoginName(login_name){
		return await this.where({login_name: login_name}).find();
	}

	async login(param){
		return await this.where({login_name: param.login_name,password:think.md5(param.password)}).find();
	}
};
