--tooltip.lua
local t = {}
t._callbacks = {"onCreatePost", "onUpdatePost"}

function t.onCreatePost()
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHtooltipBG"
    t.txtTag = "PEOPHtooltipTxt"

    t.visible = false

    t.fontSize = 25

    t.width = 100
    t.height = t.fontSize + 5

    t.text = ""
end

function t.onUpdatePost(elapsed)
    makeLuaSprite(t.tag, "", 0, 0)
    makeGraphic(t.tag, t.width, t.height, "000000")
    setObjectCamera(t.tag, "other")
    setProperty(t.tag..".alpha", 0.5)
    addLuaSprite(t.tag, true)

    makeLuaText(t.txtTag, t.text, 0, x, y)
    setTextSize(t.txtTag, t.fontSize)
    setTextFont(t.txtTag, "PermanentMarker-Regular.ttf")
    setTextBorder(t.txtTag, 0, "black")
    setObjectCamera(t.txtTag, "other")
    addLuaText(t.txtTag, true)

    t.visible = t.mouseDot.hoverCount > 0
    setProperty(t.tag..".visible", t.visible)
    setProperty(t.txtTag..".visible", t.visible)

    t.width = getProperty(t.txtTag..".fieldWidth")

    setGraphicSize(t.tag, t.width, t.height)

    local x = getMouseX("other")
    local y = getMouseY("other")+t.height

    if x+t.width > getProperty("camOther.width") then
        x = getProperty("camOther.width") - t.width
    elseif x+t.width < t.width then
        x = 0
    end

    if y+t.height > getProperty("camOther.height") then
        y = getMouseY("other")-t.height
    end

    setProperty(t.tag..".x", x)
    setProperty(t.tag..".y", y)

    setProperty(t.txtTag..".x", getProperty(t.tag..".x"))
    setProperty(t.txtTag..".y", getProperty(t.tag..".y")-5)
end

return t
