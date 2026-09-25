--reset.lua
local t = {}

function t.onCreatePost()
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHupdate"

    t.clickable = true
    t.wasHovered = false

    t.x, t.y = 0, moduleByName("controls").y

    makeLuaSprite(t.tag, "sidebar/downloads", t.x, t.y)
    addLuaSprite(t.tag, true)
    setObjectCamera(t.tag, "other")
    scaleObject(t.tag, 6, 6)
    setProperty(t.tag..".antialiasing", false)
end

function t.onUpdatePost()
    setProperty(t.tag..".x", t.x)
    t.clickable = moduleByName("data").updateAvailable

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

        local tooltip = "Update helper"
        moduleByName("tooltip").text = tooltip

        if mouseClicked("left") and t.clickable and (not transition) then
            playSound("clickText", 1, "PEOPHclick")

            setProperty("PEOPHbg.alpha", getModSetting("bgBrightness")/2/100)
            local msg = "Updating helper..."
            moduleByName("mainMsg").setMsg(msg)
            moduleByName("controls").showUpdate()

            moduleByName("data").checkUpdateFinished = true
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
