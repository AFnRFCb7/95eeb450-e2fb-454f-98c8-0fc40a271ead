# 2461544578681338
{
    inputs = { } ;
    outputs =
        { self } :
            {
                lib =
                    { input ? x : x , output ? x : x } :
                        let
                            implementation =
                                { lib , pkgs , ... } @module :
                                    let
                                        identified =
                                            if builtins.typeOf input == "lambda" then input module
                                            else if builtins.typeOf input == "null" then module
                                            else builtins.throw "6139038609734612" ;
                                        server = ./server.js ;
                                        in
                                            with identified ;
                                                {
                                                    config.environment.sessionVariables.HELLO_WORLD = config.helloworld-express ;
                                                    options =
                                                        {
                                                            hello-world-express =
                                                                lib.mkOption
                                                                    {
                                                                        default =
                                                                            config.lazy-node-application
                                                                                {
                                                                                    code-script =
                                                                                        { config , lib , ... } :
                                                                                            {
                                                                                                options.hello-world-express =
                                                                                                    lib.mkOption
                                                                                                        {
                                                                                                            default =
                                                                                                                config.lazy-shell-application
                                                                                                                    {
                                                                                                                        mounts = { } ;
                                                                                                                        name = "code-script" ;
                                                                                                                        post = [ ] ;
                                                                                                                        runtime-inputs = { pkgs , ... } : [ pkgs.coreutils ] ;
                                                                                                                        text =
                                                                                                                            ''
                                                                                                                                cat ${ server } > server.js
                                                                                                                                chmod 0400 server.js
                                                                                                                            '' ;
                                                                                                                        variables = { } ;
                                                                                                                    } ;
                                                                                                            type = lib.types.package ;
                                                                                                        } ;
                                                                                    dependencies = [ config.express-package ] ;
                                                                                    entry-point = "server.js" ;
                                                                                    mounts = { } ;
                                                                                    name = "hello-world" ;
                                                                                    node = pkgs.nodejs ;
                                                                                    post = [ ] ;
                                                                                    variable = { } ;
                                                                                } ;
                                                                        type = lib.types.package ;
                                                                    } ;
                                                        } ;
                                                } ;
                            in
                                {
                                    checks = null ;
                                    implementation =
                                        if builtins.typeOf output == "lambda" then output implementation
                                        else if builtins.typeOf output == "null" then implementation
                                        else builtins.throw "6933818093621186" ;
                                    imports = [ ] ;
                                } ;
            } ;
}