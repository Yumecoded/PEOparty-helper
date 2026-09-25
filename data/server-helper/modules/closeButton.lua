--closeButton.lua
local t = {}
t._callbacks = {"onCreatePost", "onUpdatePost"}

function t.onCreatePost()
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHclose"

    t.active = true
    t.wasHovered = false

    local x, y = 1230, 0

    makeLuaSprite(t.tag, "sidebar/cancel", x, y)
    addLuaSprite(t.tag, true)
    setObjectCamera(t.tag, "other")
    scaleObject(t.tag, 3, 3)
    setProperty(t.tag..".antialiasing", false)
end

function t.onUpdatePost()
    local hovered = objectsOverlap(t.tag, "PEOPHmouseDot")
--     print(hovered)

    if hovered and t.active then
        if not t.wasHovered then
            playSound("scrollMenu", 1, "PEOPHhover")

            t.wasHovered = true
        end

        t.mouseDot.hoverCount = t.mouseDot.hoverCount + 1
        moduleByName("tooltip").text = "Exit"

        if mouseClicked("left") and (not transition) then
            playSound("cancelMenu", 1, "PEOPHclick")
            transition = true
            exitSong()
        end
    else
        t.wasHovered = false
    end
end

return t
