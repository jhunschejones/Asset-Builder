# Asset Builder

The asset builder app is designed to work alongside Phoenix applications as a light-weight build tool for static assets. It can both compile SASS files to minified CSS and minify regular CSS and JS files.

## Setup
1. Place the `asset_builder` directory in your project's `lib` folder.
2. Modify `./config/dev.exs` to add asset builder to the `watchers` config for development:

  ```elixir
  config :hello_world, HelloWorldWeb.Endpoint,
    http: [port: 4000],
    debug_errors: true,
    code_reloader: true,
    check_origin: false,
    watchers: [
      npm: ["run", "watch",
      cd: Path.expand("../lib/asset_builder", __DIR__)]
    ]
  ```

3. `cd ./lib/asset_builder && npm install`

Now when you run your app with `mix phx.server` in development, asset builder will automatically handle minifying/compiling your assets from the `assets` directory down into their respective `priv/static/*` directories.

### No Webpack?
If you are intending to use asset builder in place of webpack, first, pat yourself on the back. Then, start start your project with the `--no-webpack` flag, ex: `mix phx.new ~/Workspace/hello_world --no-webpack`. Note: to use the default asset builder configs, you will need to create an `./assets` directory from the root of your project in which to store your static assets.

### Things Asset Builder Doesn't Do
Asset builder is a light-weight, static assets build tool. It does not combine multiple static files down into one file. It does not handle file-splitting or other, more complex build techniques. Asset builder works best with multi-page apps, allowing dev teams to create separate assets for each page without having to keep track of the minification and file management required for a Phoenix to know where to look for your static files. An added advantage to this approach is if your deploy pipeline runs `mix phx.digest` to digest and compress static files, no further configuration will be required.
