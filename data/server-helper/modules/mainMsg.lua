--mainMsg.lua
local t = {}
t._callbacks = {"onCreatePost", "onUpdatePost"}

function t.setMsg(text, skipReset)
    if not skipReset then
        setProperty(t.txtTag..".y", t.y)
    end
    setTextString(t.txtTag, text)
end

function t.onCreatePost()
    t.tag = "PEOPHmainMsgBG"
    t.txtTag = "PEOPHmainMsgTxt"
    t.msg = "PEOparty is a custom modded server with tons of new features and improvements, including:\n- 1v1 by default\n- adjustable lobby size (can be more than 6)\n- custom gamemode (Online VS!)\n- spectator mode\n- over 20 new useful commands\n- more\nPlayable without installing a different client.\nClick the buttons below to join, reset to official server and more."

    t.fontSize = 25

    t.x, t.y = 0, 50

    t.width = getProperty("camOther.width")
    t.height = getProperty("camOther.height")-t.y-50-moduleByName("controls").height-20-moduleByName("status").height-20

    makeLuaSprite(t.tag, "", t.x, t.y)
    makeGraphic(t.tag, t.width, t.height, "000000")
    setObjectCamera(t.tag, "other")
    setProperty(t.tag..".alpha", 0.75)
    addLuaSprite(t.tag, true)

    makeLuaText(t.txtTag, t.msg, t.width, t.x, t.y)
    setTextSize(t.txtTag, t.fontSize)
    setTextFont(t.txtTag, "PermanentMarker-Regular.ttf")
    setTextAlignment(t.txtTag, "left")
    setTextBorder(t.txtTag, 0, "black")
    setObjectCamera(t.txtTag, "other")
    addLuaText(t.txtTag)

    initLuaShader('clipRect')
    setSpriteShader(t.txtTag, 'clipRect')
    setShaderFloatArray(t.txtTag, 'uClipSize', {t.width, t.height})

    if not getPropertyFromClass("backend.ClientPrefs", "data.shaders") then
        alert("Shaders are disabled. Expect graphical issues.")
    end
end

function t.onUpdatePost()
    if keyboardJustPressed("UP") then
        setProperty(t.txtTag..".y", getProperty(t.txtTag..".y")+20)
    end
    if keyboardJustPressed("DOWN") then
        setProperty(t.txtTag..".y", getProperty(t.txtTag..".y")-20)
    end

    if getProperty(t.txtTag..".y") > t.y then
        setProperty(t.txtTag..".y", t.y)
    end
    if getProperty(t.txtTag..".y") < t.y - getProperty(t.txtTag..".height") then
        setProperty(t.txtTag..".y", t.y - getProperty(t.txtTag..".height"))
    end

    local bgX = getProperty(t.tag..".x")
    local bgY = getProperty(t.tag..".y")
    local bgW = getProperty(t.tag..".width")
    local bgH = getProperty(t.tag..".height")
    local txtX = getProperty(t.txtTag..".x")
    local txtY = getProperty(t.txtTag..".y")
    local txtW = getProperty(t.txtTag..".width")
    local txtH = getProperty(t.txtTag..".height")

    local left = math.max(0, bgX - txtX)
    local top = math.max(0, bgY - txtY)
    local right = math.min(txtW, bgX + bgW - txtX)
    local bottom = math.min(txtH, bgY + bgH - txtY)

    setShaderFloatArray(t.txtTag, 'uClipRect', {left, top, right, bottom})
end

return t
