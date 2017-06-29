require("core/getapi")


MapService = server:Singleton("MapService")
    ms.maps = {}
    function ms:LoadMap()
        local map = Map()
        ms.maps[name] = map
    end

    function ms:GetMap(name)

    end

    server.LoginEvent:connect(function(playerName)

        local player = PlayerService:GetPlayerByUsername(playerName)
        print("time to start downloading maps.")

        for _, map in pairs(ms.maps) do
            server:SendUDPString(playerName, string.format("%s %s %s", "DOWNLOADMAP"))

            

            for _, layer in pairs(map) do
                server:SendUDPString(playerName, string.format("%s %s %s", "LAYER"))
                
                for inc, chunk in pairs(layer) do
                    local packet = chunk:ToString()

                    server:SendUDPString(playerName, string.format("%s %s %s", "CHUNK", inc, packet))
                end
            end
        end
    end)