'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

module.exports = class extends think.Model {
	addData(param) {
		var _this = this;

		return _asyncToGenerator(function* () {
			param.create_date = think.datetime();
			param.del_flag = 0;
			param.id = think.uuid('v1');
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
		var _this4 = this;

		return _asyncToGenerator(function* () {
			let sql = _this4.page(param.current).order("create_date desc");
			if (!think.isEmpty(param.type)) {
				sql = sql.where({ type: ['like', '%' + param.type + '%'] });
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

	getGroupData() {
		var _this7 = this;

		return _asyncToGenerator(function* () {
			let parent = yield _this7.group('type').field('type').select();
			let datas = {};
			for (var i = 0; i < parent.length; i++) {
				let item = parent[i];
				let child = yield _this7.where({ type: item.type, del_flag: 0 }).order("sort").select();
				parent[i].children = {};
				let _child = {};
				for (var j = 0; j < child.length; j++) {
					let ch = child[j];
					_child[ch.value] = ch.label;
				}
				datas[item.type] = _child;
			}
			return datas;
		})();
	}
};
//# sourceMappingURL=sys_dict.js.map