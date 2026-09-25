--reset.lua
local t = {}

function t.onCreatePost()
    t.controls = moduleByName("controls")
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHreset"

    t.clickable = true
    t.wasHovered = false

    t.x, t.y = 0, t.controls.y

    makeLuaSprite(t.tag, "sidebar/update", t.x, t.y)
    addLuaSprite(t.tag, true)
    setObjectCamera(t.tag, "other")
    scaleObject(t.tag, 6, 6)
    setProperty(t.tag..".antialiasing", false)
end

function t.onUpdatePost()
    setProperty(t.tag..".x", t.x)

    local alreadySet = getPropertyFromClass("backend.ClientPrefs", "data.serverAddress") == nil
    t.clickable = not alreadySet

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

        if alreadySet then
            moduleByName("tooltip").text = "Address is already set to official server"
        else
            moduleByName("tooltip").text = "Reset address"
        end

        if mouseClicked("left") and t.clickable and (not transition) then
            local serverSwitcher = false
            for _,v in pairs(directoryFileList("mods/")) do
                if v == "Server switcher V2" then
                    serverSwitcher = true
                    break
                end
            end

            if serverSwitcher then
                playSound("badnoise"..getRandomInt(1, 3), 1, "PEOPHclick")
                alert("Old server switcher mod is installed. It's no longer supported and will cause issues, delete it to continue.")
                return
            end

            if getPropertyFromClass("backend.ClientPrefs", "data.serverAddress") == nil then
                alert("Address is already set to official server.")
                playSound("badnoise"..getRandomInt(1, 3), 1, "PEOPHclick")
                return
            end

            playSound("clickText", 1, "PEOPHclick")
            setPropertyFromClass("backend.ClientPrefs", "data.serverAddress", nil)
            callMethodFromClass("backend.ClientPrefs", "saveSettings")

            local msg = "Server address changed to official server. Please restart the game."
            moduleByName("mainMsg").setMsg(msg)
            moduleByName("controls").showDone()
            moduleByName("closeButton").active = false
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
