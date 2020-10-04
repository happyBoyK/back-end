'use strict';

module.exports = class extends think.Model {
	async addData(param){
		param.create_date=think.datetime();
		param.del_flag=0;
		param.id=think.uuid('v1');
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
		await this.where({id:id}).update(param);
	}

	async pageData(param){
		let sql=this.page(param.current).order("create_date desc");
		if(!think.isEmpty(param.type)){
			sql=sql.where({type:['like', '%'+param.type+'%']});
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

	async getGroupData(){
		let parent=await this.group('type').field('type').select();
		let datas={};
		for (var i = 0; i < parent.length; i++) {		
			let item=parent[i];			
	        let child=await this.where({type:item.type,del_flag:0}).order("sort").select();
			parent[i].children = {};			
			let _child={};
			for (var j = 0; j < child.length; j++) {		
				let ch=child[j];
				_child[ch.value]=ch.label;												
		    }
		    datas[item.type]=_child;
	    }
		return datas;
	}
};
