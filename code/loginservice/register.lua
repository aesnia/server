local sha1 = require("libs/encrypt")
local playerDB = require("code/plrdatabase")

local function register(email, username, password)
    if playerDB.getPlayer(username) then
        
        --udp:sendto(string.format("%s %s", "REGISTERFAIL", "This username is already taken."), msg_or_ip, port_or_nil)
        return false, "username taken"
    else
        local pass = sha1(password)
        data = {
            ["password"] = pass,
            ["email"] = email,
        }

        playerDB.setPlayer(username, data)
        return true, nil
    end
    return false, "unknown error"
end

return register