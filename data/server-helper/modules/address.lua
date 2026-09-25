local t = {}
t._callbacks = {"onCreatePost", "onUpdatePost"}

function t.onCreatePost()
    t.txtTag = "PEOPHaddress"
    local x, y = 0, 670

    makeLuaText(t.txtTag, "asdf", getProperty("camOther.width"), x, y)
    setTextSize(t.txtTag, 30)
    setTextFont(t.txtTag, "PermanentMarker-Regular.ttf")
    --setTextBorder(t.txtTag, 0, "black")
    setObjectCamera(t.txtTag, "other")
    addLuaText(t.txtTag)
end

function t.onUpdatePost(elapsed)
    local serverAddress = getPropertyFromClass("backend.ClientPrefs", "data.serverAddress")
    if serverAddress == nil then serverAddress = "wss://funkin.sniro.boo" end

    local color = "red"
    if serverAddress == "wss://peoparty.nport.link" or serverAddress == "ws://peoparty.nport.link" or serverAddress == "ws://localhost:2567" then
        color = "lime"
    elseif serverAddress == "wss://funkin.sniro.boo" or serverAddress == "ws://funkin.sniro.boo" then
        color = "yellow"
    end

    setTextString(t.txtTag, "Current address: "..serverAddress)
    setTextColor(t.txtTag, color)
end

return t
