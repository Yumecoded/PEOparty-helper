function module(path)
    return assert(loadstring(getTextFromFile(path)))()
end

function moduleByName(name)
    for i,moduleName in ipairs(modulesList) do
        if moduleName == name then
            return modules[i]
        end
    end
end

function split(str, sep)
    local result = {}
    local pattern = "([^" .. sep .. "]+)"
    for match in string.gmatch(str, pattern) do
        table.insert(result, match)
    end
    return result
end

function parseJson(json)
    return callMethodFromClass('tjson.TJSON', 'parse', {json})
end

function hash(str)
    h = 5381;

    for c in str:gmatch"." do
        h = math.fmod(h*32 + h + str:byte(i), 2147483648)
    end
    return h
end

function onCreatePost()
    makeLuaSprite("PEOPHbg", "menuDesat")
    addLuaSprite("PEOPHbg", true)
    setObjectCamera("PEOPHbg", "other")
    setProperty("PEOPHbg.color", FlxColor("PINK"))
    setProperty("PEOPHbg.alpha", getModSetting("bgBrightness")/100)

    playSound("breakfast", 1, "PEOPHbgMusic")

    alert = getPropertyFromClass("online.gui.Alert", "alert")
    downloadMod = getPropertyFromClass("online.mods.OnlineMods", "downloadMod")
    send = getPropertyFromClass("online.GameClient", "send")

    --mouseDot first, tooltip last
    modulesList = {"mouseDot", "address", "title", "closeButton", "controls", "status", "mainMsg", "data", "online", "tooltip"}
    modules = {}

    for i,v in ipairs(modulesList) do
        modules[i] = module("data/server-helper/modules/"..v..".lua")

        for _,callbackName in pairs(modules[i]._callbacks) do
            if not _G[callbackName] then
                _G[callbackName] = function(...)
                    callModules(modules, callbackName, ...)
                end
            end
        end

        modules[i].onCreatePost()
        print("Loaded "..v)
    end

    if online then
        send("status", "In server helper")
    end
end

function callModules(tab, callbackName, ...)
    for _, module in ipairs(tab) do
        local func = module[callbackName]

        if func then
            func(...)
        end
    end
end

function onSoundFinished(tag)
    if tag == "PEOPHbgMusic" then
        playSound("breakfast", 1, "PEOPHbgMusic")
    end
end

function onPause()
    return Function_Stop
end

function onDestroy()
    stopSound("PEOPHbgMusic")
end
