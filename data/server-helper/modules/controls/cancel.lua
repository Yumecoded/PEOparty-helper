--reset.lua
local t = {}

function t.onCreatePost()
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHcancel"

    t.clickable = true
    t.wasHovered = false

    t.x, t.y = 0, moduleByName("controls").y

    makeLuaSprite(t.tag, "sidebar/cancel", t.x, t.y)
    addLuaSprite(t.tag, true)
    setObjectCamera(t.tag, "other")
    scaleObject(t.tag, 6, 6)
    setProperty(t.tag..".antialiasing", false)
end

function t.onUpdatePost()
    setProperty(t.tag..".x", t.x)

    local hovered = objectsOverlap(t.tag, "PEOPHmouseDot")

    if hovered then
        if t.clickable then
            setProperty(t.tag..".alpha", 1)
            if not t.wasHovered then
                playSound("scrollMenu", 1, "PEOPHhover")

                t.wasHovered = true
            end
        end

        t.mouseDot.hoverCount = t.mouseDot.hoverCount + 1

        moduleByName("tooltip").text = "Cancel"

        if mouseClicked("left") and t.clickable and (not transition) then
            playSound("clickText", 1, "PEOPHclick")

            setProperty("PEOPHbg.alpha", getModSetting("bgBrightness")/100)
            moduleByName("controls").destroyAll()
            local list = moduleByName("controls").defaultControls
            moduleByName("controls").createControls(list)
            setTextString(moduleByName("mainMsg").txtTag, moduleByName("mainMsg").msg)
            moduleByName("data").checkUpdateFinished = false

            if online then
                send("status", "In server helper")
            end
        end
    else
        setProperty(t.tag..".alpha", 0.5)
        t.wasHovered = false
    end
end

function t.onDestroy()
    removeLuaSprite(t.tag)
end

return t
