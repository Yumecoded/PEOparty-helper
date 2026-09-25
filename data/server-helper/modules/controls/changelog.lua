--changelog.lua
local t = {}

function t.onCreatePost()
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHchangelog"
    t.newTag = "PEOPHchangelogNew"

    t.clickable = true
    t.wasHovered = false

    t.x, t.y = 0, moduleByName("controls").y

    makeLuaSprite(t.tag, "sidebar/server", t.x, t.y)
    addLuaSprite(t.tag, true)
    setObjectCamera(t.tag, "other")
    scaleObject(t.tag, 6, 6)
    setProperty(t.tag..".antialiasing", false)

    makeLuaSprite(t.newTag, "sidebar/notif", t.x, t.y)
    addLuaSprite(t.newTag, true)
    setObjectCamera(t.newTag, "other")
    scaleObject(t.newTag, 2, 2)
    setProperty(t.newTag..".antialiasing", false)
end

function t.onUpdatePost()
    setProperty(t.newTag..".x", t.x)
    setProperty(t.newTag..".y", t.y)
    setProperty(t.newTag..".visible", moduleByName("data").unreadChanges)

    setProperty(t.tag..".x", t.x)
    t.clickable = checkFileExists("../PEOparty changelog.txt")

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

        local tooltip = "Latest changes (use arrow keys to scroll text)"
        moduleByName("tooltip").text = tooltip

        if mouseClicked("left") and t.clickable and (not transition) then
            playSound("clickText", 1, "PEOPHclick")

            local msg = getTextFromFile("../PEOparty changelog.txt")
            moduleByName("mainMsg").setMsg(msg)

            if moduleByName("data").unreadChanges then
                setDataFromSave("PEOpartyHelper", "lastReadHash", hash(moduleByName("data").changelog))
                flushSaveData("PEOpartyHelper")
                moduleByName("data").unreadChanges = false
            end

            if online then
                send("status", "Reading changelog")
            end
        end
    else
        setProperty(t.tag..".alpha", 0.5)
        t.wasHovered = false
    end
end

function t.onDestroy()
    removeLuaSprite(t.tag)
    removeLuaSprite(t.newTag)
end

return t
