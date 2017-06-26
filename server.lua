--[[
    Aesnia Online Server

]]

-- constants
MAX_PLAYERS = 100
PORT = 8675
REVISION = 1
TIMEOUT = 10
TICKS_PER_SECOND = 20
UPDATE_INTERVAL = 60
MAP_SIZE = 32
CHUNK_SIZE = 32

local ticks = 0
local serverReportCount = 1

print("Aesnia Online - Server v"..REVISION)


print("Loading libraries..")

-- libraries
local json = require("libs/json")
local socket = require("socket")

print("Loading modules...")

-- modules
local loginAuth = require("code/loginservice/login")
local registerAuth = require("code/loginservice/register")
local serialize = require("code/map/MapSerialization")
local mapStorage = require("code/map/MapStorage")

print("Loading maps...")

do
    local map = {
        ["meta"] = {
            ["size"] = 4,
            ["name"] = "gay",
        },
        ["tiles"] = {
                    
            [1] = { -- the layer
                
                
            },
        }
    }
    for x = 1, 35 do
        map["tiles"][1][x] = {}
        for i = 1, (16*16) do
            
            if (x % 2) == 0 then
                map["tiles"][1][x][i] = math.random(1, 5)
            elseif (x % 3 == 0) then
                map["tiles"][1][x][i] = 2
            else
                map["tiles"][1][x][i] = 1
            end

        end
    end

    mapStorage.set("gay", map)
end
print("Creating network...")

local entities = {}

--local Player = require("code/entities/PlayerEntity")


-- Setting up networking
local udp = socket.udp()
udp:settimeout(0)
udp:setsockname('*', PORT)


print("Ready! Awaiting connections...")
local connectedUsers = {}

local running = true


-- main server loop
while running do

    -- check for a connection
    local data, msg_or_ip, port_or_nil = udp:receivefrom()


    -- if we have a message we will read it
    if data then
        for inc, obj in pairs(connectedUsers) do
            if obj["ip"] == msg_or_ip then
                obj["lastmsg"] = 0
                --print("Packet from "..obj["username"]..": ")
            end
        end
        print(msg_or_ip.." : "..data)

        -- turn the data into a command and extra
        cmd, extra = data:match("^(%S*) (.*)")


        if cmd == "GETREV" then
            udp:sendto(string.format("%s ", tostring(REVISION)))
        end

        if cmd == "LOGIN" then

            print("Login attempt from " .. msg_or_ip .. " with credintials [".. extra.."]")

            local user, pass = extra:match("^(%S*) (%S*)")
            local result, msg = loginAuth(user, pass)

            if result then
                udp:sendto(string.format("%s ", "LOGINSUCCESS"), msg_or_ip, port_or_nil)

                local usr = {
                    ["username"] = user,
                    ["ip"] = msg_or_ip,
                    ["port"] = port_or_nil,
                    ["lastmsg"] = 0,
                }
                 
                table.insert(connectedUsers, usr)

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
            else
                udp:sendto(string.format("%s %s", "LOGINFAIL", msg), msg_or_ip, port_or_nil)
            end
        end

        if cmd == "REGISTER" then
        
            local email, user, pass = extra:match("^(%S*) (%S*) (%S*)")
            

            local result, msg = registerAuth(email, user, pass)    
            if result then
                udp:sendto(string.format("%s ", "REGISTERSUCCESS"), msg_or_ip, port_or_nil)
            else
                udp:sendto(string.format("%s %s", "REGISTERFAIL", msg), msg_or_ip, port_or_nil)
            end
        elseif msg_or_ip ~= "timeout" then
            print("Unknown network error: " ..tostring(msg))
        end
        

    end

    for inc, usr in pairs(connectedUsers) do


        --udp:sendto(string.format("%s ", "ENTITY"), usr["ip"], usr["port"])
        
        
        usr["lastmsg"] = usr["lastmsg"] + 1
        if usr["lastmsg"] > TIMEOUT*TICKS_PER_SECOND then
            print(usr["username"].." has timed out.")
            connectedUsers[inc] = nil
        end 
    end

    for i, entity in pairs(entities) do
        entity:step()
    end

    ticks = ticks + 1

    if (ticks % (TICKS_PER_SECOND*UPDATE_INTERVAL) == 0) then
        print("___")
        print("Server Report "..serverReportCount)
        print("\tuptime: "..ticks.."t, "..ticks/TICKS_PER_SECOND/60 .. " min")
        print("\tusage: "..(collectgarbage("count")/1000 .."mb"))
        print("\tplayers: 0 connected")

        serverReportCount = serverReportCount + 1
    end

    socket.sleep(1/TICKS_PER_SECOND)
    
end