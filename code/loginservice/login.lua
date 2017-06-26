--[[
    Login Script Service
    
]]

-- require libs
local playerDB = require("code/plrdatabase")
local sha1 = require("libs/encrypt")

--| bool login(string username, string password)
local function login(username, password)
    local pass = sha1(password) -- convert plaintext password into sha1-encrypted hex string

    if playerDB.getPlayer(username) then -- check for user
                
        if playerDB.getPlayer(username)["password"] == pass then -- check if password is correct
            return true, nil
            
        end
        return false, "incorrect password"
    end
    return false, "account not found"
    

end


return login