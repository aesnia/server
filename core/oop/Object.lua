local Object = {}

Object.__index = Object

function Object:newClass(type)
	return setmetatable(type, {
		__call = function (cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
	})
end

function Object:_init()
	Object.__inheritance = {"Object"}
end

function Object:isA(str)
	for i, v in pairs(self.__inheritance) do
		if v == str then
			return true
		end
	end
	return false
end

return Object
