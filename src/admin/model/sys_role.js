'use strict';

module.exports = class extends think.Model {

	async addData(param){
		let menuids=param.menuids;
		param.create_date=think.datetime();
		param.del_flag=0;
		param.id=think.uuid('v1');
		delete param.menuids;
		await this.add(param);
		let list=[];
		if(menuids){
			for(var i=0;i<menuids.length;i++){
				let menu=menuids[i];
				list.push({role_id:param.id,menu_id:menu});			
			}
		}		
		if(list.length>0){
			await this.model('sys_role_menu').addMany(list);
		}
	}


	async delData(param){
		await this.where({id:param.id}).delete();
		await this.model('sys_role_menu').where({role_id: param.id}).delete(); // 删除菜单节点中的权限
	}

	async updateData(param){
		let id=param.id;
		let menuids=param.menuids;
		param.update_date=think.datetime();
		delete param.id;
		delete param.create_date;
		delete param.menuids;
		await this.where({id:id}).update(param);
		await this.model('sys_role_menu').where({role_id: id}).delete();
		let list=[];
		if(menuids){
			for(var i=0;i<menuids.length;i++){
				let menu=menuids[i];
				list.push({role_id:id,menu_id:menu});			
			}
		}
		if(list.length>0){
			await this.model('sys_role_menu').addMany(list);
		}
	}

	async pageData(param){
		let _sql = 'select role_id,GROUP_CONCAT(menu_id) as role_menus from sys_role_menu  GROUP BY role_id';//await this.model('sys_role_menu').field("role_id,GROUP_CONCAT(menu_id)").group('role_id').buildSql();
		let sql=this.alias('a').join({
	      table: _sql,
	      as: 'b',
	      on: ['id', 'role_id']
	    }).page(param.current).order("create_date desc");
		if(!think.isEmpty(param.name)){
			sql=sql.where({'a.name':['like', '%'+param.name+'%']});
		}
		let data = await sql.countSelect();
		return data;
	}

	async allData(param){
		let data=await this.where({del_flag:0}).select();
		return data;
	}

	async getData(id){
		return await this.where({id: id}).find();
	}
};
