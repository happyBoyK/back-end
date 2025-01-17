/**
 *常用工具类
 */
const fs = require('fs');
const path = require('path');

module.exports = {
    mkdirs(dirname) {
        return mkdirsSync(dirname);
    }
};

function mkdirsSync(dirname) {
    if (fs.existsSync(dirname)) {
        return true;
    } else {
        if (mkdirsSync(path.dirname(dirname))) {
            fs.mkdirSync(dirname);
            return true;
        }
    }
}
//# sourceMappingURL=common.js.map