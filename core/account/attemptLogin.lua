--[[
    Login Script Service
    
]]

-- require libs
local get = require("core/account/getAccountData")
local sha1 = require("core/libraries/encrypt")

--| bool login(string username, string password)
local function login(username, password)
    local pass = sha1(password) -- convert plaintext password into sha1-encrypted hex string
    local player = get(username)
    if player then -- check for user
                
        if player["password"] == pass then -- check if password is correct
            return true, nil
            
        end
        return false, "incorrect password"
    end
    return false, "account not found"
    

end


return login