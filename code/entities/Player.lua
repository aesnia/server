--[[
    PlayerEntity - Each player controls one of these.

    ## Methods

        string getUsername() - Returns the player's username.
        string getIPAddress() - Returns the player's IP address.
        Inventory getInventory() - Returns the player's inventory.
        number getMinutesPlayed() - Returns the time the player has played.
        int getLevel() - Returns the level of the player.
        int getExperience() - Returns the current XP of the player.
        int getHealth() - Returns the health of the player.
        int getMaxHealth() - Returns the maximum health of the player
        table<StatusEffect> getStatusEffects() - Returns a list of the player's status effects
        int getEnergy() - Return the player's energy.
        int getMaxEnergy() - Returns the maximum energy of the player.
        number getEnergyRegen() - Returns the energy regen speed of the player.
        number getHealthRegen() - Returns the health regen speed of the player.
        bool isCombatTagged() - Returns if the player has been tagged for combat
        bool isRunning() - Returns if the player is running

        setInventory(Inventory) - Sets the inventory of the player
        setMinutesPlayed(number minutes) - Sets the time the player has played.
        setLevel(int level) - Set the player's level.
        setExperience(int experience) - Set the player's experience. Will cause a level-up if the experience is set above the needed amount.
        setHealth(int health) - Sets the player's health.
        setMaxHealth(int health) - Set the player's max health. 
        setStatusEffects(table<StatusEffect> effects) - Sets the status effects of the player.
        setEnergy(int energy) - Set the player's energy.
        setMaxEnergy(int energy) - Set the player's max energy.
        setEnergyRegen(number regen) - Sets the health regen speed of the player.
        setHealthRegen(number regen) - Sets the health regen speed of the player.
        combatTag(bool tag) - Sets the player's combat tag.


      ### Inherited from BaseEntity

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

        leaveEvent(string leaveReason) - Fired when the player leaves.

        joinEvent(bool isPlayerNew) - Fired when the player joins.

      ### Inherited from BaseEntity

        diedEvent(string deathReason) - Fired when the entity is killed.
]]

local BaseEntity = require("code/entities/BaseEntity")

local Player = {}
	BaseEntity:_newClass(Player)

	function Player:_init()
		table.insert(self.inheritance, "Player")
        self.internalName = "PlayerEntity"
	end



    function Player:_step()
        self:_collisionTileCheck()
        

        self:_collisionEntityCheck()
    end
    

    function Player:getUsername() end

    function Player:getIPAddress() end

    function Player:getInventory() end

    function Player:getMinutesPlayed() end

    function Player:getLevel() end

    function Player:getExperience() end

    function Player:getHealth() end

    function Player:getEnergy() end

    function Player:getMaxEnergy() end






return player