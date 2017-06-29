--[[

    The Aesnia Online server API (for programming all game objects)


    ## Methods:
        Class Class()
        Singleton Singleton()
        variant LoadJSONFile(string filename) - Will load a JSON file into a variable
        string LoadTextFile(string filename)
        void SaveJSONFile(string filename, variant object)
        void SaveTextFile(string filename, string text)
        void SendUDPString(string playerName, string data)
        void SendUDPStringToAllConnections(string data)

    ## Events
        LoginEvent() 
        LogoutEvent()
        UDPStringRecieveEvent()
        ServerRunEvent()

]]
local json = require("core/libraries/json")
local oop = require("core/oop/Object")
event = require("core/oop/Event")

server = oop:newClass(oop)
server.__index = server

    function server:Class()
        local class = oop:newClass(oop)
        return class
    end

    function server:Singleton()
        return {}
    end

    function server:SendUDPString(playerName, data)
        local plr = connections[playerName]

        udp:sendto(data, plr["ip"], plr["port"])
    end

    function server:SendUDPStringToAllConnections(data)
        for _, plr in pairs(connections) do 
            udp:sendto(data, plr["ip"], plr["port"])
        end
    end

    function server:LoadJSONFile(filename)
        local file = io.open(filename, "r")
        local data = json.decode(file:read())
        file:close()
        return data
    end

    function server:LoadTextFile(filename)
        local file = io.open(filename, "r")
        local data = file:read()
        file:close()
        return data
    end

    function server:SaveJSONFile(filename, data)
        local file = io.open(filename, "w")
        local data = file:write(json.encode(data))
        file:close()
    end


    function server:SaveTextFile()
        local file = io.open(filename, "w")
        local data = file:write(data)
        file:close()
    end

    server.LoginEvent = event.initialize()
    server.LogoutEvent = event.initialize()
    server.UDPStringRecieveEvent = event.initialize()
    server.ServerRunEvent = event.initialize()