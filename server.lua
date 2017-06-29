--[[
    Aesnia Online Server

]]


-- This script is the server-side of Aesnia Online

-- constants
require("core/getapi")




print("Aesnia Online Server: Starting...")
 
MAX_PLAYERS = 100
PORT = 8675
REVISION = 1
TIMEOUT = 10
TICKS_PER_SECOND = 20
UPDATE_INTERVAL = 60
MAP_SIZE = 32
CHUNK_SIZE = 16

local ticks = 0
local delta = 1
local serverReportCount = 1


print("Loading server code..")

-- libraries
local json = require("core/libraries/json")
local socket = require("socket")
local login = require("core/account/attemptLogin")
local register = require("core/account/attemptRegister")

print("Loading game modules...")

require("game/PlayerHandlerService")
require("game/ChatService")
require("game/MapService")


print("Creating network...")


-- Setting up networking
local udp = socket.udp()
udp:settimeout(0)
udp:setsockname('*', PORT)


print("Ready! Awaiting connections...")
local connections = {}

local running = true


-- main server loop
while running do

    -- check for a connection
    local data, msg_or_ip, port_or_nil = udp:receivefrom()


    -- if we have a message we will read it
    if data then
        

        -- otherwise these commands are for logging in a player, registering, etc.
        print(msg_or_ip.." : "..data)

        -- turn the data into a command and extra
        cmd, extra = data:match("^(%S*) (.*)")


        if cmd == "GETREV" then
            udp:sendto(string.format("%s ", tostring(REVISION)))

        elseif cmd == "LOGIN" then

            print("Login attempt from " .. msg_or_ip .. " with credintials [".. extra.."]")

            local user, pass = extra:match("^(%S*) (%S*)")
            local result, msg = login(user, pass)

            if result then
                udp:sendto(string.format("%s ", "LOGINSUCCESS"), msg_or_ip, port_or_nil)

                server.LoginEvent:fire()
                
                local usr = {
                    ["username"] = user,
                    ["ip"] = msg_or_ip,
                    ["port"] = port_or_nil,
                    ["lastmsg"] = 0,
                }
                 
                table.insert(connections, usr)
                --[[
                local map = mapStorage.get("gay")
                do
                    local name = map["meta"]["name"]
                    local size = map["meta"]["size"]

                    udp:sendto(string.format("%s %s %s", "DOWNLOADMAP", size, name), msg_or_ip, port_or_nil)
                end

                udp:sendto(string.format("%s %s", "LAYER", 1), msg_or_ip, port_or_nil)

                for i, v in pairs(map["tiles"][1]) do
                    local packet = serialize(v)
                    print(packet)
                    udp:sendto(string.format("%s %s %s", "CHUNK", i, packet), msg_or_ip, port_or_nil)
                end
                ]]
            else
                udp:sendto(string.format("%s %s", "LOGINFAIL", msg), msg_or_ip, port_or_nil)
            end
        elseif cmd == "REGISTER" then
        
            local email, user, pass = extra:match("^(%S*) (%S*) (%S*)")
            

            local result, msg = register(email, user, pass)    
            if result then
                udp:sendto(string.format("%s ", "REGISTERSUCCESS"), msg_or_ip, port_or_nil)
            else
                udp:sendto(string.format("%s %s", "REGISTERFAIL", msg), msg_or_ip, port_or_nil)
            end
        elseif cmd == "GOODBYE" then
            server.LogoutEvent:fire()
        elseif msg_or_ip ~= "timeout" then
            print("Unknown network error: " ..tostring(msg))
        else
            for inc, obj in pairs(connections) do

                -- We now know that we have a connection
                if obj["ip"] == msg_or_ip then
                    obj["lastmsg"] = 0
                    print("Packet from "..obj["username"]..": ")
                    server.UDPStringRecieveEvent:fire(server:GetPlayerByIP(obj["ip"]), data)
                end
            end
        end
        

    end

    -- update time out for connected users
    for inc, usr in pairs(connections) do


        udp:sendto(string.format("%s ", "SERVERCHECK"), usr["ip"], usr["port"])
        
        
        usr["lastmsg"] = usr["lastmsg"] + 1
        if usr["lastmsg"] > TIMEOUT*TICKS_PER_SECOND then
            print(usr["username"].." has timed out.")
            server.LogoutEvent:fire()
            connections[inc] = nil
        end 
    end


    -- tick update info I guess...
    ticks = ticks + 1
    delta = delta + 1
    if delta > TICKS_PER_SECOND then delta = 1 end 

    if (ticks % (TICKS_PER_SECOND*UPDATE_INTERVAL) == 0) then
        print("___")
        print("Server Report "..serverReportCount)
        print("\tuptime: "..ticks.."t, "..ticks/TICKS_PER_SECOND/60 .. " min")
        print("\tusage: "..(collectgarbage("count")/1000 .."mb"))
        print("\tplayers: 0 connected")

        serverReportCount = serverReportCount + 1
    end

    server.ServerRunEvent:fire(delta)

    -- sleep for a TPS cycle
    socket.sleep(1/TICKS_PER_SECOND)
    
end