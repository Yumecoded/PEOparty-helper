--mainMsg.lua
local t = {}
t._callbacks = {"onCreatePost"}

function t.onCreatePost()
    t.tag = "PEOPHstatusBG"
    t.txtTag = "PEOPHstatusTxt"

    t.fontSize = 25

    t.width = getProperty("camOther.width")
    t.height = 35

    t.x, t.y = 0, moduleByName("controls").y - t.height * 2

    makeLuaSprite(t.tag, "", t.x, t.y)
    makeGraphic(t.tag, t.width, t.height, "000000")
    setObjectCamera(t.tag, "other")
    setProperty(t.tag..".alpha", 0.75)
    addLuaSprite(t.tag, true)

    makeLuaText(t.txtTag, "Server status: Fetching...", t.width, t.x, t.y)
    setTextSize(t.txtTag, t.fontSize)
    setTextFont(t.txtTag, "PermanentMarker-Regular.ttf")
    setTextAlignment(t.txtTag, "left")
    setTextBorder(t.txtTag, 0, "black")
    setObjectCamera(t.txtTag, "other")
    addLuaText(t.txtTag)
end

function t.setMsg(text)
    setTextString(t.txtTag, text)
end

return t
