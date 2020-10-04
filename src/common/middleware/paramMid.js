const { think } = require("thinkjs");

// 是否打印执行时间的配置
const defaultOptions = {
  consoleExecTime: true 
}

// 错误代码的文字说明配置
const errmsgOptions = {
  9999 : '系统异常,如有疑问请联系管理员！',
  9998 : '未登录，不允许操作！',
  9997 : '登陆验证失败，请重新登陆！',
  9996 : '帐号或者密码不正确！',
  9995 : '该用户名已被使用！',
  9994 : '原密码不正确！',
  9993 : 'HTTP请求方式不正确！',
  401  : '请先登录',
  404  : '请求的URL不存在！'
}

module.exports = (options = {}) => {
  // 合并传递进来的配置
  options = Object.assign({}, defaultOptions, options,errmsgOptions);
  return (ctx, next) => {
    if(!options.consoleExecTime) {
      return next(); // 如果不需要打印执行时间，直接调用后续执行逻辑
    }
    think.logger.info('--------------新请求开始----------------');
    think.logger.info('请求href:',ctx.href);
    think.logger.info('请求GET参数:',ctx.param());
    think.logger.info('请求POST参数:',ctx.post());
    const startTime = Date.now();
    let err = null;
    // 调用 next 统计后续执行逻辑的所有时间
    return next().catch(e => {
      think.logger.error('系统异常:',e);
      err = e; // 这里先将错误保存在一个错误对象上，方便统计出错情况下的执行时间
    }).then(() => {   
      const status=ctx.status;
      if(status!=200){ 
        ctx.body={};
        ctx.body.errno=status;
      }
      if(ctx.response&&!ctx.body){
        ctx.body={};
        ctx.body.errno='9999'
      }
      if(ctx.body.errno&&ctx.body.errno!=0){
        if(!think.isEmpty(ctx.body.errmsg)||!think.isEmpty(ctx.body.data)){
          if(think.isEmpty(ctx.body.errmsg)){
            ctx.body.errmsg=ctx.body.data;
          }else{
            ctx.body.errmsg=ctx.body.errmsg;
          }
        }else{
          if(think.isEmpty(options[ctx.body.errno])){
            ctx.body.errmsg='未知异常！';
          }else{
            ctx.body.errmsg=options[ctx.body.errno];
          }     
        }   
      }
      const endTime = Date.now();
      if(status==200){
        think.logger.info('返回状态:',status,',返回结果:',JSON.stringify(ctx.body));
      }else{
        think.logger.error('返回状态:',status,',返回结果:',JSON.stringify(ctx.body));
      }
      
      think.logger.info('请求处理时间:',(endTime - startTime),'ms');
      think.logger.info('--------------新请求结束----------------');
      if(err||status!=200){
        return Promise.reject(new Error(err)); // 如果后续执行逻辑有错误，则将错误返回
      }
    })
  }
}