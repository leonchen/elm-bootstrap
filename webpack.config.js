const path = require('path');
const webpack = require('webpack');

module.exports = {
  entry: {
    app: ['./src/index.js'],
  },

  output: {
    path: path.join(__dirname, 'dist'),
    filename: "app.js",
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader'
      }
    ],
    noParse: /\.elm$/,
  },

  devServer: {
    port: 3030,
    inline: true,
    contentBase: path.join(__dirname, 'dist'),
  }
};
