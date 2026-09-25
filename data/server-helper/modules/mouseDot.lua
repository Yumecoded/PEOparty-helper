--mouseDot.lua
local t = {}
t._callbacks = {"onCreatePost", "onUpdatePost"}

function t.onCreatePost()
    t.tag = "PEOPHmouseDot"

    t.hoverCount = 0

    makeLuaSprite(t.tag, "", 0, 0)
    makeGraphic(t.tag, 1, 1, "000000")
    setObjectCamera(t.tag, "other")
    setProperty(t.tag..".alpha", 0)
    addLuaSprite(t.tag)
end

function t.onUpdatePost()
    setProperty(t.tag..".x", getMouseX("other"))
    setProperty(t.tag..".y", getMouseY("other"))

    t.hoverCount = 0
end

return t
