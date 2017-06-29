local Event = {}
Event.__index = Event

function Event.initialize()
	local self = setmetatable({}, Event)
	self.connections = {}
	return self
end

function Event:connect(givenFunction)
	 table.insert(self.connections, givenFunction)
end

function Event:disconnectAll()
	self.connections = {}
end

function Event:fire(...)
	for inc, f in pairs(self.connections) do
		f(...)
	end
end

return Event