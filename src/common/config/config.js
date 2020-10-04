// default config
module.exports = {
  workers: 1,
  jwtsecret: "ohmygod@2017",

  //七牛配置
  qiniu_bucket:'thinkjs-iview-admin',
  qiniu_ak:'-HJl3HU59lCkmusRoQVGj25QzQXsNCUtjXLmeVPE',
  qiniu_sk:'vGFvf0suaL2D2alIgSE_Y13oJQgl3BCo7-qvAgzg',
  qiniu_key:'ceshi',

  //自动生成代码的路径
  generator_path:'D:/thinkjs-iview-admin-generator-code',

  weixin: {
    appid: 'wx359607bb8878036f', // 小程序 appid
    secret: '6a053a856ecb8fc54c32f55383209f11', // 小程序密钥
    mch_id: '', // 商户帐号ID
    partner_key: '', // 微信支付密钥
    notify_url: '' // 微信异步通知，例：https://www.nideshop.com/api/pay/notify
  }
};
