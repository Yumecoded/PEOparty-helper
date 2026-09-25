--data.lua
local t = {}
t._callbacks = {'onCreatePost',"onUpdatePost"}

t.version = "0.0.7.4"
t.versionURL = "https://raw.githubusercontent.com/Yumecoded/PEOparty-helper/refs/heads/download/version.txt"
t.latestDownloadURL = "https://raw.githubusercontent.com/Yumecoded/PEOparty-helper/refs/heads/download/latest.zip"
t.changelogURL = "https://raw.githubusercontent.com/Yumecoded/PEOparty-helper/refs/heads/download/server%20changelog.txt"
t.updateAvailable = false
t.checkUpdateFinished = false
t.unreadChanges = false

function t.fetch(url)
    local ok, result = pcall(function()
        return runHaxeCode([[
            var h = new sys.Http("]] .. url .. [[");
            var out:String = null;
            h.onData = function(d) out = Std.string(d);
            h.request(false);
            return out;
        ]])
    end)
    if ok then
        return result
    end
end

function t.isVersionNewer(ver1, ver2)
    local ver1Split = split(ver1:gsub("\n", ""):gsub("-", "."), ".")
    local ver2Split = split(ver2:gsub("\n", ""):gsub("-", "."), ".")

    for i=1, math.max(#ver1Split, #ver2Split) do
        local a = tonumber(ver1Split[i])
        local b = tonumber(ver2Split[i])

        if not a then a = 0 end
        if not b then b = 0 end

        if a ~= b then
            return a > b
        end
    end

    return false
end

function t.onCreatePost()
    t.latestVersion = t.fetch(t.versionURL)
    t.changelog = t.fetch(t.changelogURL)
    t.front = t.fetch("https://peoparty.nport.link/api/front")

    if not t.latestVersion or t.latestVersion == "" then
        alert("Failed to check for updates.")
        return
    end

    t.updateAvailable = t.isVersionNewer(t.latestVersion, t.version)

    if t.updateAvailable then
        local tag = moduleByName("title").txtTag
        local orig = getTextString(tag)
        setTextString(tag, orig.." (update available!)")
    end

    if not t.changelog or t.changelog == "" then
        alert("Failed to fetch latest changes.")
        return
    else
        saveFile("PEOparty changelog.txt", t.changelog)

        initSaveData("PEOpartyHelper")
        if hash(t.changelog) ~= getDataFromSave("PEOpartyHelper", "lastReadHash", -1) then
            t.unreadChanges = true
        end
    end

    if not t.front or t.front == "" then
        local tag = moduleByName("status").txtTag
        setTextString(tag, "Server status: Failed to reach server.")
    else
        local json = parseJson(t.front)

        local tag = moduleByName("status").txtTag
        setTextString(tag, "Server status: "..json.online.." players online. "..json.rooms.." public rooms.")
    end

    deleteFile("data/trigger")
end

function t.onUpdatePost()
    if checkFileExists("data/trigger") and t.checkUpdateFinished then
        deleteFile("data/trigger")
        loadSong("server helper")
    end
end

return t
