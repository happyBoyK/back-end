// default config
module.exports = {
  // 可以公开访问的Controller
  publicController: [
    // 格式为controller
    'api/index',
    'api/catalog',
    'api/topic',
    'api/auth',
    'api/goods',
    'api/brand',
    'api/search',
    'api/region'
  ],

  // 可以公开访问的Action
  publicAction: [
    // 格式为： controller+action
    'api/comment/list',
    'api/comment/count',
    'api/cart/index',
    'api/cart/add',
    'api/cart/checked',
    'api/cart/update',
    'api/cart/delete',
    'api/cart/goodscount',
    'api/pay/notify'
  ]
};
