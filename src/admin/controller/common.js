const Base = require('./base.js');
const qiniu = require('qiniu');
const accessKey=think.config('qiniu_ak')
const secretKey=think.config('qiniu_sk')
const bucket=think.config('qiniu_bucket');
const key=think.config('qiniu_key');

module.exports = class extends Base {
	async indexAction() {
    	return this.success();
  	}

  	uploadTokenAction() {
  		const mac = new qiniu.auth.digest.Mac(accessKey, secretKey);
	    const options = {
	      scope: bucket //+ ':'+key
	    };
	    const putPolicy = new qiniu.rs.PutPolicy(options);
   		const uploadToken = putPolicy.uploadToken(mac);
	    return this.success({'token':uploadToken});
  	}
};
