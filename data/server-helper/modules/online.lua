--online.lua
local t = {}
t._callbacks = {"onCreatePost", "onUpdatePost"}

function t.onCreatePost()

end

function t.onUpdatePost()
    if not online then return end

    if isRoomOwner() then
        moduleByName("controls").destroyAll()

        send("status", "Host")

        local list = ""
        local playerList = listPlayers()

        for _,sid in pairs(playerList) do
            local player = getPlayer(sid)
            list = list..player.name.." - "..player.status.."\n"
        end
        moduleByName("mainMsg").setMsg(list, true)

        if #playerList < 2 then
            endSong()
        end
    end
end

return t
