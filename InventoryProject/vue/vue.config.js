module.exports = {
  transpileDependencies: true,
  devServer:{
    port:7000
  },
  chainWebpack: config => {
    config.plugin('html')
        .tap(args => {
          args[0].title = "Inventory";
          return args;
        })
  }
}
