local Object = {}

Object.__index = Object

function Object:_newClass(obj)
	setmetatable(obj, {
		__call = function (cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
	})
end


Object:newClass(Object)

function Object:_init()
	Object.inheritance = {"Object"}
end

function Object:isA(str)
	for i, v in pairs(self.inheritance) do
		if v == str then
			return true
		end
	end
	return false
end

function Object:_step(dt)

end

function Object:destroy()
	self = nil
	collectgarbage()
end


return Object
