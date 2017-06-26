--[[
    BaseEntity - The basic entity, so I don't have to implement this shit into every new enemy.

    ## Methods

        Vector2D getPosition() - Returns the entity's position.
        Vector2D getPixelPosition() - Returns the actual position of the entity, counted in pixels instead of tiles.
        number getRotation() - Returns the degree rotation.
        number getRotationInRadians() - Returns the rotation of the entity in radians.
        string getInternalName() - Returns the internal name of the entity.
        int getHeightLevel() - Returns the rendering level the entity is on (0-5).
        int getAABBRadius() - Returns the radius of the entity's bounding box.

        setPosition(Vector2D pos) - Sets the entity's position.
        setRotation(number rotation) - Sets the degree rotation of the entity.
        setRotationInRadians(number rotation) - Sets the radian rotation of the entity.
        setHeightLevel(int level) - Sets the rendering level of the entity.

      ### Inherited from Object

        bool isA(string object) - Returns whether or not the entity is an "object", whatever that may be.

        _step(number dt) - Steps the object.
        destroy() - Destroys and cleans up the object.

    ## Events

        diedEvent(string deathReason) - Fired when the entity is killed.
]]

local Object = require("code/oop/Object.lua")
local Event = require("code/oop/Event.lua")


local BaseEntity = {}

    Object:_newClass(BaseEntity)

    function BaseEntity:_init()
        table.insert(self.inheritance, "BaseEntity")
        self.internalName = "BaseEntity"
    end

    function BaseEntity:_collisionTileCheck()

    end

    function BaseEntity:_collisionEntityCheck()

    end

    -- getters

    function BaseEntity:getPosition() end

    function BaseEntity:getRotation() end

    function BaseEntity:getRotationInRadians() end

    function BaseEntity:getInternalName() end

    function BaseEntity:getHeightLevel() end

    function BaseEntity:getAABBRadius() end

    -- setters

    function BaseEntity:setPosition() end

    function BaseEntity:setRotation() end

    function BaseEntity:setRotationInRadians() end

    function BaseEntity:setHeightLevel() end
 
return BaseEntity