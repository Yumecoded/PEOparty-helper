--closeButton.lua
local t = {}

function t.onCreatePost()
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHdone"
    t.wasHovered = false

    local x, y = getProperty("camOther.width") / 2 - 96 / 2, moduleByName("controls").y

    makeLuaSprite(t.tag, "check", x, y)
    addLuaSprite(t.tag, true)
    setObjectCamera(t.tag, "other")
    scaleObject(t.tag, 1.92, 1.92)
end

function t.onUpdatePost()
    local hovered = objectsOverlap(t.tag, "PEOPHmouseDot")

    if hovered then
        setProperty(t.tag..".alpha", 1)
        if not t.wasHovered then
            playSound("scrollMenu", 1, "PEOPHhover")

            t.wasHovered = true
        end

        t.mouseDot.hoverCount = t.mouseDot.hoverCount + 1
        moduleByName("tooltip").text = "Done"

        if mouseClicked("left") and (not transition) then
            playSound("cancelMenu", 1, "PEOPHclick")
            transition = true
            addHaxeLibrary('Application', 'lime.app')
            runHaxeCode('Application.current.window.close()')
        end
    else
        setProperty(t.tag..".alpha", 0.5)
        t.wasHovered = false
    end
end

return t
