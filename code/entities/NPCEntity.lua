--[[
    NPC - The basic NPC, doesn't interact at all.

    ## Methods

      ### Inherited from BaseObject

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

    ## Events

      ### Inherited from BaseObject
        diedEvent(string deathReason) - Fired when the entity is killed.
]]