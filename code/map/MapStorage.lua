local maps = {}


local storage = {}


function storage.get(name)
    for i, v in pairs(maps) do
        if v["meta"]["name"] == name then
            return v
        end
    end
end


function storage.set(name, map)
    maps[name] = map
end

return storage