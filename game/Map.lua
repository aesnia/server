require("core/getapi")


local Map = server:CreateClass()

    function Map:New()
        self.Name = "Empty Map"
        self.Size = 10
        self.Layers = {
            [1] = {},
            [2] = {},
            [3] = {},
            [4] = {},
        }
        self.Entities = {

        }

    end

    function Map:SaveToFile(filename)
        local data = {
            ["meta"] = {
                ["size"] = self.Size,
                ["name"] = self.Name,
            },
            ["tiles"] = self.Layers,
            ["objects"] = {},
        }
    end

    function Map:GetChunk(x, y, layer)

        local arrPos = y + (16 * (x - 1))
        return self.Layers[layer][arrPos]
    end

    function Map:LoadFromFile(filename)
        local data = server:LoadJSONFile("maps/"..filename)

        if data then
            self.Size = data["meta"]["size"]
            self.Name = data["meta"]["name"]
            self.Layers = data["tiles"]
            self.Entities = data["objects"]
        else
            print("ERROR: No map file "..filename)
        end
    end

    function Map:GetSize()

    end 

    function Map:SetName()

    end


return Map