'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

module.exports = class extends think.Model {

	addData(param) {
		var _this = this;

		return _asyncToGenerator(function* () {
			let menuids = param.menuids;
			param.create_date = think.datetime();
			param.del_flag = 0;
			param.id = think.uuid('v1');
			delete param.menuids;
			yield _this.add(param);
			let list = [];
			if (menuids) {
				for (var i = 0; i < menuids.length; i++) {
					let menu = menuids[i];
					list.push({ role_id: param.id, menu_id: menu });
				}
			}
			if (list.length > 0) {
				yield _this.model('sys_role_menu').addMany(list);
			}
		})();
	}

	delData(param) {
		var _this2 = this;

		return _asyncToGenerator(function* () {
			yield _this2.where({ id: param.id }).delete();
			yield _this2.model('sys_role_menu').where({ role_id: param.id }).delete(); // 删除菜单节点中的权限
		})();
	}

	updateData(param) {
		var _this3 = this;

		return _asyncToGenerator(function* () {
			let id = param.id;
			let menuids = param.menuids;
			param.update_date = think.datetime();
			delete param.id;
			delete param.create_date;
			delete param.menuids;
			yield _this3.where({ id: id }).update(param);
			yield _this3.model('sys_role_menu').where({ role_id: id }).delete();
			let list = [];
			if (menuids) {
				for (var i = 0; i < menuids.length; i++) {
					let menu = menuids[i];
					list.push({ role_id: id, menu_id: menu });
				}
			}
			if (list.length > 0) {
				yield _this3.model('sys_role_menu').addMany(list);
			}
		})();
	}

	pageData(param) {
		var _this4 = this;

		return _asyncToGenerator(function* () {
			let _sql = 'select role_id,GROUP_CONCAT(menu_id) as role_menus from sys_role_menu  GROUP BY role_id'; //await this.model('sys_role_menu').field("role_id,GROUP_CONCAT(menu_id)").group('role_id').buildSql();
			let sql = _this4.alias('a').join({
				table: _sql,
				as: 'b',
				on: ['id', 'role_id']
			}).page(param.current).order("create_date desc");
			if (!think.isEmpty(param.name)) {
				sql = sql.where({ 'a.name': ['like', '%' + param.name + '%'] });
			}
			let data = yield sql.countSelect();
			return data;
		})();
	}

	allData(param) {
		var _this5 = this;

		return _asyncToGenerator(function* () {
			let data = yield _this5.where({ del_flag: 0 }).select();
			return data;
		})();
	}

	getData(id) {
		var _this6 = this;

		return _asyncToGenerator(function* () {
			return yield _this6.where({ id: id }).find();
		})();
	}
};
//# sourceMappingURL=sys_role.js.map