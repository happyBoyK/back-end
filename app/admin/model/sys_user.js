'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

module.exports = class extends think.Model {
	addData(param) {
		var _this = this;

		return _asyncToGenerator(function* () {
			param.create_date = think.datetime();
			param.del_flag = 0;
			param.id = think.uuid('v1');
			param.password = think.md5('111111');
			param.status = 1;
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
			delete param.password;
			yield _this3.where({ id: id }).update(param);
		})();
	}

	updateInfo(param) {
		var _this4 = this;

		return _asyncToGenerator(function* () {
			let id = param.id;
			param.update_date = think.datetime();
			yield _this4.where({ id: id }).update({ update_date: param.update_date,
				name: param.name, email: param.email, phone: param.phone });
		})();
	}

	changeStatus(param) {
		var _this5 = this;

		return _asyncToGenerator(function* () {
			let id = param.id;
			param.update_date = think.datetime();
			yield _this5.where({ id: id }).update({ status: param.status, update_date: param.update_date });
		})();
	}

	resetPwd(param) {
		var _this6 = this;

		return _asyncToGenerator(function* () {
			let id = param.id;
			param.update_date = think.datetime();
			yield _this6.where({ id: id }).update({ password: think.md5('111111'), update_date: param.update_date });
		})();
	}

	updatePwd(param) {
		var _this7 = this;

		return _asyncToGenerator(function* () {
			let id = param.id;
			param.update_date = think.datetime();
			yield _this7.where({ id: id }).update({ password: think.md5(param.newPass), update_date: param.update_date });
		})();
	}

	pageData(param) {
		var _this8 = this;

		return _asyncToGenerator(function* () {
			let sql = _this8.alias('a').join({
				table: 'sys_role',
				as: 'b',
				on: ['role_id', 'id']
			}).field("a.*,b.name as rolename").where({ 'a.id': ['!=', 1] }).page(param.current).order("create_date desc");
			if (!think.isEmpty(param.name)) {
				sql = sql.where({ 'a.name': ['like', '%' + param.name + '%'] });
			}
			let data = yield sql.countSelect();
			return data;
		})();
	}

	myDetail(id) {
		var _this9 = this;

		return _asyncToGenerator(function* () {
			let data = yield _this9.alias('a').join({
				table: 'sys_role',
				as: 'b',
				on: ['role_id', 'id']
			}).field("a.*,b.name as rolename").where({ 'a.id': id }).find();
			delete data.password;
			if (id == '1') {
				data.rolename = '超级管理员';
			}
			return data;
		})();
	}

	allData(param) {
		var _this10 = this;

		return _asyncToGenerator(function* () {
			let data = yield _this10.where({ del_flag: 0 }).select();
			return data;
		})();
	}

	getData(id) {
		var _this11 = this;

		return _asyncToGenerator(function* () {
			return yield _this11.where({ id: id }).find();
		})();
	}

	findByLoginName(login_name) {
		var _this12 = this;

		return _asyncToGenerator(function* () {
			return yield _this12.where({ login_name: login_name }).find();
		})();
	}

	login(param) {
		var _this13 = this;

		return _asyncToGenerator(function* () {
			return yield _this13.where({ login_name: param.login_name, password: think.md5(param.password) }).find();
		})();
	}
};
//# sourceMappingURL=sys_user.js.map