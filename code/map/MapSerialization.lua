local function serialize(chunk)
    local map = ""

        for inc, obj in pairs(chunk) do
            map = map .. tostring(obj) .. " "

        end

    return map
end

return serialize