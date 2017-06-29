require("core/getapi")

chatService = server:CreateNewService("ChatService")
    chatService.buffer = {}

server.UDPStringRecieveEvent:connect(function(player, data)
    local command, extra = data:match("^(%S*) (.*)")
    if command == "CHAT" then
        local currT = os.date("*t")

        buffString = "["..currT.hour..":"..currT.minute..":"..currT.second.."] "..player:GetUsername().." : "..extra
        table.insert(chatService.buffer, buffString)
    end
end)