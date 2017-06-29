require("core/getapi")

entityList = {}


server.ServerRunEvent:connect(function(delta)
    for inc, entity in pairs(entityList) do
        entity:_run()
    end
end)