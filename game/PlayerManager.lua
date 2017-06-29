require("core/getapi")
local Player = require("game/Player")

PlayerService = server:Singleton()

    phs.Players = {}
    phs.PlayerJoinEvent = event.initialize()
    phs.PlayerLeaveEvent = event.initialize()

    function phs:BanPlayer()

    end

    function phs:KickPlayer()

    end

    function phs:GetPlayerByUsername(name)
    
    end

     server.LoginEvent:connect(function()
        print("That nigga left!")
    end)

    server.LogoutEvent:connect(function()
        print("That nigga left!")
    end)