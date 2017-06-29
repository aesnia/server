local json = require("core/libraries/json")

local function get(username)
    local file = io.open("players.db", "r")
    if not file then return nil end
    local db = json.decode(file:read())
    file:close()
    return db[username]
end


return get