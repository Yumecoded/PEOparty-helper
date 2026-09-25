function onCreate()
    setProperty("skipCountdown", true)
    setProperty("camGame.visible", false)
    setProperty("camHUD.visible", false)
end

function onUpdatePost(elapsed)
    setProperty("waitReadySpr.visible", false)
    setPropertyFromClass("flixel.FlxG", "mouse.visible", true)
    runHaxeCode("setSongTime(-10000); FlxG.sound.music.volume = 0;")
end
