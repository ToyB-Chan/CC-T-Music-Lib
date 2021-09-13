local args = {...}

if type(args[1]) ~= "string" then
    print("Usage:")
    print(" - \'httptape <URL>\' to download a file from \'URL\' and write it to the tape. The tape will be wiped!")
    return
end

local function GetHttp(url)
    print("Downloading...")
    local handler = http.get(url, nil, true)
    return handler
end

local HttpSong = GetHttp(args[1])
local TapeDrive = peripheral.find("tape_drive")

if not HttpSong then
    print("Download Failed!")
    return
end
    
if not TapeDrive or TapeDrive.isReady() == false then
    print("No tape found!")    
    return
end

print("Clearing Tape...")
TapeDrive.seek(-99999999999)
for i = 1, (TapeDrive.getSize() / 8192) do
    TapeDrive.write(string.rep("\xAA", 8192))
end

print("Writing...")
TapeDrive.seek(-99999999999)
TapeDrive.write(HttpSong.readAll())
TapeDrive.seek(-99999999999)
print("Done!")
