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
                                        identified = input module ;
                                        server = ./server.js ;
                                        in
                                            with identified ;
                                                {
                                                    config.environment.sessionVariables.HELLO_WORLD = config.hello-world-express ;
                                                    options =
                                                        {
                                                            hello-world-express =
                                                                lib.mkOption
                                                                    {
                                                                        default =
                                                                            config.lazy-node-application
                                                                                {
                                                                                    code =
                                                                                        { config , lib , ... } :
                                                                                            [
                                                                                                (
                                                                                                    pkgs.writeShellApplication
                                                                                                        {
                                                                                                            name = "code" ;
                                                                                                            runtimeInputs = [ pkgs.coreutils ] ;
                                                                                                            text =
                                                                                                                ''
                                                                                                                    cat ${ server } > server.js
                                                                                                                    chmod 0400 server.js
                                                                                                                '' ;
                                                                                                        }
                                                                                                )
                                                                                            ] ;
                                                                                    dependencies = { config , ... } : [ config.express-package ] ;
                                                                                    entry-point = "server.js" ;
                                                                                    mounts = { } ;
                                                                                    name = "hello-world" ;
                                                                                    nodejs = pkgs.nodejs_22 ;
                                                                                    post = [ ] ;
                                                                                    variables = { } ;
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
