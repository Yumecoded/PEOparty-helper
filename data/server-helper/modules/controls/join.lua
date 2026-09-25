--join.lua
local t = {}

function t.onCreatePost()
    t.controls = moduleByName("controls")
    t.mouseDot = moduleByName("mouseDot")

    t.tag = "PEOPHjoin"

    t.clickable = true
    t.wasHovered = false

    t.x, t.y = 0, t.controls.y

    makeLuaSprite(t.tag, "sidebar/start", t.x, t.y)
    addLuaSprite(t.tag, true)
    setObjectCamera(t.tag, "other")
    scaleObject(t.tag, 6, 6)
    setProperty(t.tag..".antialiasing", false)
end

function t.onUpdatePost()
    setProperty(t.tag..".x", t.x)

    local alreadySet = getPropertyFromClass("backend.ClientPrefs", "data.serverAddress") == "wss://peoparty.nport.link"
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
            moduleByName("tooltip").text = "Address is already set to PEOparty"
        else
            moduleByName("tooltip").text = "Join PEOparty"
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

            local address = "wss://peoparty.nport.link"
            if keyboardPressed("SHIFT") then
                address = "ws://localhost:2567"
            end

            playSound("clickText", 1, "PEOPHclick")
            setPropertyFromClass("backend.ClientPrefs", "data.serverAddress", address)
            callMethodFromClass("backend.ClientPrefs", "saveSettings")

            local msg = "Server address changed to PEOparty. Please restart the game.\nYou can come back to this menu using server-helper in freeplay to reset back to official server. Remember that PEOparty currently doesn't run 24/7."
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
