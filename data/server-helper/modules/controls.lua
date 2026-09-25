--controls.lua
local t = {}
t._callbacks = {"onCreatePost", "onUpdatePost"}

function t.destroyAll()
    callModules(t.buttons, "onDestroy")
    t.buttons = {}
end

function t.createControls(list)
    for i,v in ipairs(list) do
        t.buttons[i] = module("data/server-helper/modules/controls/"..v..".lua")

        t.buttons[i].onCreatePost()

        local gap = 40
        local totalWidth = #list * 96 + (#list-1) * gap
        t.buttons[i].x = getProperty("camOther.width") / 2 - totalWidth / 2 + (96 + gap) * (i-1)
    end
end

function t.showDone()
    t.destroyAll()
    t.createControls({"done"})

    if online then
        send("status", "Leaving")
    end
end

function t.showUpdate()
    t.destroyAll()
    t.createControls({"retry", "cancel"})

    if online then
        send("status", "Updating helper")
    end
end

function t.onCreatePost()
    t.tag = "PEOPHcontrolsBG"

    t.fontSize = 25

    t.width = getProperty("camOther.width")
    t.height = 96

    t.x, t.y = 0, getProperty("camOther.height")-50-t.height

    makeLuaSprite(t.tag, "", t.x, t.y)
    makeGraphic(t.tag, t.width, t.height, "000000")
    setObjectCamera(t.tag, "other")
    setProperty(t.tag..".alpha", 0.5)
    addLuaSprite(t.tag, true)

    t.buttons = {}

    t.defaultControls = {"join", "reset", "update", "changelog"}
    t.createControls(t.defaultControls)
end

function t.onUpdatePost(...)
    callModules(t.buttons, "onUpdatePost", ...)
end

return t
