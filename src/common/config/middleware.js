const path = require('path');
const isDev = think.env === 'development';
const id_16 = require('id-16');
const id = id_16.generator(4);
const kcors = require('kcors');

module.exports = [
  {  
    handle: kcors, // 处理跨域
    options: {}
  },
  {
    handle: 'meta',
    options: {
      logRequest: isDev,
      sendResponseTime: isDev
    }
  },
  {
    handle: 'resource',
    enable: isDev,
    options: {
      root: path.join(think.ROOT_PATH, 'www'),
      publicPath: /^\/(static|favicon\.ico)/
    }
  },
  {
    handle: 'trace',
    enable: !think.isCli,
    options: {
      debug: true,
      sourceMap: false,
      error(err, ctx) {
        let _id=think.datetime(new Date(),'YYYYMMDDHHmmss'+id());
        think.logger.error("异常编号:",_id," , 异常内容:",err);
        return ctx.fail(Number(ctx.body.errno),"请求失败！错误ID："+_id);
      }
    }
  },
  {
    handle: 'payload',
    options: {}
  },
  {
    handle: 'router',
    options: {}
  },
  {
    handle: 'paramMid',
    options: {}
  },
  'logic',
  'controller'
];
