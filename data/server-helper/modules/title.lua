local t = {}
t._callbacks = {"onCreatePost"}

function t.onCreatePost()
    t.txtTag = "PEOPHtitle"
    local x, y = 0, 0

    makeLuaText(t.txtTag, "PEOparty helper", getProperty("camOther.width"), x, y)
    setTextSize(t.txtTag, 30)
    setTextFont(t.txtTag, "PermanentMarker-Regular.ttf")
    setObjectCamera(t.txtTag, "other")
    setTextAlignment(t.txtTag, "left")
    addLuaText(t.txtTag)
end

return t
