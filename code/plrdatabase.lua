local json = require("libs/json")

local playerDB = {}

function playerDB.getPlayer(username)
    local nigga = io.open(os.getenv("HOME").."/AesniaServer/players.db", "r") -- open the player database
    local db = json.decode(nigga:read()) -- load it to a file
    nigga:close()
    return db[username]
end

function playerDB.setPlayer(username, data)
    local nigga = io.open(os.getenv("HOME").."/AesniaServer/players.db", "r+")
    local playerDB = json.decode(nigga:read())
    playerDB[username] = data
    nigga:write(json.encode(playerDB))
    nigga:close()
end


return playerDB