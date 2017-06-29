--[[
    ## Methods

    ## Events
]]

require("core/getapi")


local player = server:CreateClass()

    function player:New(user, addr)
        self.username = ""
        self.ipAddress = ""
    end

    function player:GetUsername()
        return self.username
    end

    function player:GetIPAddress()
        return self.ipAddress
    end

    function player:GetConnectionPort()

    end

    function player:Kick()

    end

    function player:Ban()

    end

    function player:_step()

    end


return player