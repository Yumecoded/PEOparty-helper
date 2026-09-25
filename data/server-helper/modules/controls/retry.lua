--reset.lua
local t = {}

function t.onCreatePost()
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHretry"

    t.clickable = true
    t.wasHovered = false

    t.x, t.y = 0, moduleByName("controls").y

    makeLuaSprite(t.tag, "sidebar/update", t.x, t.y)
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

        moduleByName("tooltip").text = "Retry download"

        if mouseClicked("left") and t.clickable and (not transition) then
            playSound("clickText", 1, "PEOPHclick")

            local url = moduleByName("data").latestDownloadURL
            downloadMod(url, true)
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
