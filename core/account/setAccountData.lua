local json = require("core/libraries/json")

local function set(username, data)
    local file = io.open("players.db", "r+")

    local playerDB = json.decode(file:read())

    playerDB[username] = data
    file:write(json.encode(playerDB))
    file:close()    
end

return set