local args = {...}
local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

if type(args[1]) ~= "string" then
    print("Usage:")
    print(" - \'speakerplay <URL>\' to play a file from \'URL\'")
    return
end

if not http.checkUrl(args[1]) then
	print("URL is not valid!")
	return
end

local decoder = dfpwm.make_decoder()
local respone = http.get(args[1], nil, true)
local data = respone.readAll()
speaker.playAudio(data)
