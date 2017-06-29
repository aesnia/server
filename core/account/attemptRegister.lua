local sha1 = require("core/libraries/encrypt")
local set = require("core/account/setAccountData")
local get = require("core/account/getAccountData")

local function register(email, username, password)
    if get(username) then

        return false, "username taken"
    else
        local pass = sha1(password)
        
        local data = {
            ["password"] = pass,
            ["email"] = email,
        }

        set(username, data)
        return true, nil
    end
    return false, "unknown error"
end

return register