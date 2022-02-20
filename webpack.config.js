const path = require('path');
const webpack = require('webpack');

module.exports = {
    mode: 'development',
    entry: {
        app: './app/presentation/assets/app.js',
        index: './app/presentation/assets/pages/index/index.js',
        manage: './app/presentation/assets/pages/manage/index.js',
    },
    output: {
        filename: '[name].js',
        path: path.resolve(__dirname, 'public/assets')
    },
    module: {
        rules: [
            {
                test: /\.(scss)$/,
                use: [
                    {
                        loader: 'style-loader'
                    },
                    {
                        loader: 'css-loader'
                    },
                    {
                        loader: 'resolve-url-loader'
                    },
                    {
                        loader: 'postcss-loader',
                        options: {
                            sourceMap: true,
                            postcssOptions: {
                                plugins: function () {
                                    return [
                                        require('autoprefixer')
                                    ];
                                },
                            }
                        }
                    },
                    {
                        loader: 'sass-loader',
                        options: {
                            sourceMap: true,
                        }
                    },
                ]
            },
        ]
    },
    plugins: [
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery',
            bootstrap: 'bootstrap'
        })
    ]
};
