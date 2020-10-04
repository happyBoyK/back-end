module.exports = class extends think.Model {

	getTables() {
	   return this.query('select table_name as name,table_comment as comment from INFORMATION_SCHEMA.tables where   table_schema = (select database())');
	}

	getTableComment(tablename) {
	   return this.query("select table_name as name,table_comment as comment from INFORMATION_SCHEMA.tables where   table_schema = (select database()) and table_name ='"+tablename+"'");
	}

	getColumns(tablename) {
	   return this.query("select * from information_schema.columns where table_schema = (select database()) and table_name = '"+tablename+"'");
	}
};
