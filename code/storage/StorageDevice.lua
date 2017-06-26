--[[
    StorageDevice - The base storage thingy idk.

    ## Methods

        

      ### Inherited from Object

        bool isA(string object) - Returns whether or not the entity is an "object", whatever that may be.


]]

local Object = require("code/oop/Object.lua")
local Event = require("code/oop/Event.lua")


local StorageDevice = {}

    Object:_newClass(StorageDevice)

    function StorageDevice:_init()
        table.insert(self.inheritance, "BaseEntity")
        self.internalName = "BaseEntity"
    end

    -- getters

return StorageDevice