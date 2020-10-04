'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

module.exports = class extends think.Model {

	addData(param) {
		var _this = this;

		return _asyncToGenerator(function* () {
			param.create_date = think.datetime();
			param.is_show = 1;
			if (think.isEmpty(param.pid)) {
				param.pid = 0;
			}
			yield _this.add(param);
		})();
	}

	delData(param) {
		var _this2 = this;

		return _asyncToGenerator(function* () {
			yield _this2.where({ id: param.id }).delete();
		})();
	}

	updateData(param) {
		var _this3 = this;

		return _asyncToGenerator(function* () {
			let id = param.id;
			param.update_date = think.datetime();
			delete param.id;
			delete param.create_date;
			yield _this3.where({ id: id }).update(param);
		})();
	}

	pageData(param) {
		return _asyncToGenerator(function* () {})();
	}

	allData(param) {
		var _this4 = this;

		return _asyncToGenerator(function* () {
			let menu = [];
			let pMenu = yield _this4.where({ pid: 0, del_flag: 0, is_show: 1 }).order("sort").select();
			for (var i = 0; i < pMenu.length; i++) {
				let item = pMenu[i];
				let len = menu.push(item);
				let childMenu = yield _this4.where({ pid: item.id, del_flag: 0, is_show: 1 }).order("sort").select();
				menu[len - 1].children = childMenu;
			}
			return menu;
		})();
	}

	getData(id) {
		var _this5 = this;

		return _asyncToGenerator(function* () {
			return yield _this5.where({ id: id }).find();
		})();
	}

	getMyMenuData(user_id, role_id) {
		var _this6 = this;

		return _asyncToGenerator(function* () {
			let menu = [];
			if (user_id == '1' && think.isEmpty(role_id)) {
				let pMenu = yield _this6.where({ pid: 0, del_flag: 0, is_show: 1 }).order("sort").select();
				for (var i = 0; i < pMenu.length; i++) {
					let item = pMenu[i];
					let len = menu.push(item);
					let childMenu = yield _this6.where({ pid: item.id, del_flag: 0, is_show: 1 }).order("sort").select();
					menu[len - 1].children = childMenu;
				}
			} else {
				let rolemenu = yield _this6.model('sys_role_menu').where({ role_id: role_id }).select();
				let menuids = [];
				for (var i = 0; i < rolemenu.length; i++) {
					let item = rolemenu[i];
					menuids.push(item.menu_id);
				}

				let pMenu = yield _this6.where({ pid: 0, del_flag: 0, is_show: 1, id: ['IN', menuids] }).order("sort").select();
				for (var i = 0; i < pMenu.length; i++) {
					let item = pMenu[i];
					let len = menu.push(item);
					let childMenu = yield _this6.where({ pid: item.id, del_flag: 0, is_show: 1, id: ['IN', menuids] }).order("sort").select();
					menu[len - 1].children = childMenu;
				}
			}
			return menu;
		})();
	}

	getMenuTree() {
		var _this7 = this;

		return _asyncToGenerator(function* () {
			let menu = [];
			let pMenu = yield _this7.where({ pid: 0, del_flag: 0, is_show: 1 }).order("sort").select();
			for (var i = 0; i < pMenu.length; i++) {
				let item = pMenu[i];
				let len = menu.push(item);
				let childMenu = yield _this7.where({ pid: item.id, del_flag: 0, is_show: 1 }).order("sort").select();
				menu[len - 1].children = childMenu;
			}
			return menu;
		})();
	}

};
//# sourceMappingURL=sys_menu.js.map