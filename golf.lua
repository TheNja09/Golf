Reverse = true
function _OnFrame()
    World = ReadByte(Now + 0x00)
    Room = ReadByte(Now + 0x01)
    Place = ReadShort(Now + 0x00)
    Door = ReadShort(Now + 0x02)
    Map = ReadShort(Now + 0x04)
    Btl = ReadShort(Now + 0x06)
    Evt = ReadShort(Now + 0x08)
    Cheats()
end

function _OnInit()
    if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
        Platform = 'PS2'
        Now = 0x032BAE0 --Current Location
        Save = 0x032BB30 --Save File
        Obj0 = 0x1C94100 --00objentry.bin
        Sys3 = 0x1CCB300 --03system.bin
        Btl0 = 0x1CE5D80 --00battle.bin
        Slot1 = 0x1C6C750 --Unit Slot 1
    elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
        Platform = 'PC'
        Now = 0x0714DB8 - 0x56454E
        Save = 0x09A7070 - 0x56450E
        Obj0 = 0x2A22B90 - 0x56450E
        Sys3 = 0x2A59DB0 - 0x56450E
        Btl0 = 0x2A74840 - 0x56450E
        Slot1 = 0x2A20C58 - 0x56450E
    end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
    return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function Cheats()
	if ReadByte(0x444861) ~= 13 then
	WriteFloat(Sys3+0x17CE4, 0.0001) -- Base Speed: DS = 8
	WriteFloat(Sys3+0x17CE0, 0.0001) -- Walking Speed: DS = 2
	WriteFloat(0x250D332, 0.0001) -- Glide 1 Speed (Default: 16)
	WriteFloat(0x250D376, 0.0001) -- Glide 2 Speed (Default: 20)
	WriteFloat(0x250D3BA, 0.0001) -- Glide 3 Speed (Default: 24)
	WriteFloat(0x250D3FE, 0.0001) -- Glide MAX Speed (Default: 32)
	WriteFloat(0x250D442, 0.0001) -- Glide AX2 Speed (Default: 64)
	WriteFloat(0x250CEC6, 0.0001) -- Aerial Recovery Movement Speed
	WriteByte(Sys3+0x9E0,0) -- Fire Cost
	WriteByte(Sys3+0x15E0,0) -- Fira Cost
	WriteByte(Sys3+0x1610,0) -- Firaga Cost
	WriteByte(Sys3+0xA40,0) -- Blizzard Cost
	WriteByte(Sys3+0x1640,0) -- Blizzara Cost
	WriteByte(Sys3+0x1670,0) -- Blizzaga Cost
	WriteByte(Sys3+0xA10,0) -- Thunder Cost
	WriteByte(Sys3+0x16A0,0) -- Thundara Cost
	WriteByte(Sys3+0x16D0,0) -- Thundaga Cost
	WriteByte(Sys3+0xA70,0) -- Cure Cost
	WriteByte(Sys3+0x1700,0) -- Cura Cost
	WriteByte(Sys3+0x1730,0) -- Curaga Cost
	WriteByte(Sys3+0x1F40,0) -- Magnet Cost
	WriteByte(Sys3+0x1F70,0) -- Magnera Cost
	WriteByte(Sys3+0x1FA0,0) -- Magnega Cost
	WriteByte(Sys3+0x1FD0,0) -- Reflect Cost
	WriteByte(Sys3+0x2000,0) -- Reflera Cost
	WriteByte(Sys3+0x2030,0) -- Reflega Cost
	WriteByte(Sys3+0xE30,255) -- Twin Howl Cost
	WriteByte(Sys3+0xFB0,255) -- Bushido Cost
	WriteByte(Sys3+0x1940,255) -- Red Rocket Cost
	WriteByte(Sys3+0x3F80,255) -- Speedster Cost
	WriteByte(Sys3+0x40A0,255) -- Bluff Cost
	WriteByte(Sys3+0x4430,255) -- Wildcat Cost
	WriteByte(Sys3+0x49A0,255) -- Dance Call Cost
	WriteByte(Sys3+0x4B80,255) -- Setup Cost
	WriteByte(Sys3+0x67D0,255) -- Session Cost
	WriteByte(Sys3+0x5840,255) -- Trinity Limit Cost
	WriteByte(Sys3+0x5840+0x1830,255) -- (Solo) Trinity Limit Cost
	WriteByte(Sys3+0x2E10,255) -- Whirli-Goof Cost
	WriteByte(Sys3+0x3D40,255) -- Knocksmash Cost
	WriteByte(Sys3+0x3320,255) -- Comet Cost
	WriteByte(Sys3+0x3E60,255) -- Duck Flare Cost
	WriteByte(Sys3+0x7E50,0) -- Strike Raid Cost
	WriteByte(Sys3+0x7D30,0) -- Sonic Blade Cost
	WriteByte(Sys3+0x7C10,0) -- Ragnarok Cost
	WriteByte(Sys3+0x7DC0,0) -- Ars Arcanum Cost
	WriteFloat(0x250D322, 0) -- QR1 Speed
	WriteFloat(0x250D366, 0) -- QR2 Speed
	WriteFloat(0x250D3AA, 0) -- QR3 Speed
	WriteFloat(0x250D3EE, 0) -- QR4 Speed
	WriteFloat(0x250D432, 0) -- QRAX2 Speed
	WriteFloat(0x250D31A, 0) -- AD1 Speed
	WriteFloat(0x250D35E, 0) -- AD2 Speed
	WriteFloat(0x250D3A2, 0) -- AD3 Speed
	WriteFloat(0x250D3E6, 0) -- AD4 Speed
	WriteFloat(0x250D42A, 0) -- ADAX2 Speed
	WriteFloat(0x250D352, 0) -- Dodge Roll 1
	WriteFloat(0x250D396, 1) -- Dodge Roll 2
	WriteFloat(0x250D3DA, 2) -- Dodge Roll 3
	WriteFloat(0x250D41E, 3) -- Dodge Roll MAX
	WriteFloat(0x250D462, 4) -- Dodge Roll AX2
	WriteFloat(0x250D342, 0)
	WriteFloat(0x250D386, 0)
	WriteFloat(0x250D3CA, 0)
	WriteFloat(0x250D40E, 0)
	WriteFloat(0x250D452, 0)
	elseif ReadByte(0x444861) == 13 then
	WriteFloat(Sys3+0x17CE4, 8) -- Base Speed: DS = 8
	WriteFloat(Sys3+0x17CE0, 2) -- Walking Speed: DS = 2
	WriteFloat(0x250D332, 16) -- Glide 1 Speed (Default: 16)
	WriteFloat(0x250D376, 20) -- Glide 2 Speed (Default: 20)
	WriteFloat(0x250D3BA, 24) -- Glide 3 Speed (Default: 24)
	WriteFloat(0x250D3FE, 32) -- Glide MAX Speed (Default: 32)
	WriteFloat(0x250CEC6, 10) -- Aerial Recovery Movement Speed
	WriteFloat(0x250D322, 18) -- QR1 Speed
	WriteFloat(0x250D366, 20) -- QR2 Speed
	WriteFloat(0x250D3AA, 24) -- QR3 Speed
	WriteFloat(0x250D3EE, 28) -- QR4 Speed
	WriteFloat(0x250D352, 16) -- Dodge Roll 1
	WriteFloat(0x250D396, 20) -- Dodge Roll 2
	WriteFloat(0x250D3DA, 24) -- Dodge Roll 3
	WriteFloat(0x250D41E, 32) -- Dodge Roll MAX
	WriteFloat(0x250D31A, 20) -- AD1 Speed
	WriteFloat(0x250D35E, 20) -- AD2 Speed
	WriteFloat(0x250D3A2, 20) -- AD3 Speed
	WriteFloat(0x250D3E6, 20) -- AD4 Speed
	WriteByte(Sys3+0x9E0,12) -- Fire Cost
	WriteByte(Sys3+0x15E0,12) -- Fira Cost
	WriteByte(Sys3+0x1610,12) -- Firaga Cost
	WriteByte(Sys3+0xA40,15) -- Blizzard Cost
	WriteByte(Sys3+0x1640,15) -- Blizzara Cost
	WriteByte(Sys3+0x1670,15) -- Blizzaga Cost
	WriteByte(Sys3+0xA10,18) -- Thunder Cost
	WriteByte(Sys3+0x16A0,18) -- Thundara Cost
	WriteByte(Sys3+0x16D0,18) -- Thundaga Cost
	WriteByte(Sys3+0xA70,255) -- Cure Cost
	WriteByte(Sys3+0x1700, 255) -- Cura Cost
	WriteByte(Sys3+0x1730,255) -- Curaga Cost
	WriteByte(Sys3+0x1F40,30) -- Magnet Cost
	WriteByte(Sys3+0x1F70,30) -- Magnera Cost
	WriteByte(Sys3+0x1FA0,30) -- Magnega Cost
	WriteByte(Sys3+0x1FD0,10) -- Reflect Cost
	WriteByte(Sys3+0x2000,10) -- Reflera Cost
	WriteByte(Sys3+0x2030,10) -- Reflega Cost
	WriteByte(Sys3+0x5840+0x1830,255) -- (Solo) Trinity Limit Cost
	WriteByte(Sys3+0x7E50,65) -- Strike Raid Cost
	WriteByte(Sys3+0x7D30,60) -- Sonic Blade Cost
	WriteByte(Sys3+0x7C10,80) -- Ragnarok Cost
	WriteByte(Sys3+0x7DC0,72) -- Ars Arcanum Cost
	WriteFloat(0x250D342, 0.91)
	WriteFloat(0x250D386, 0.93)
	WriteFloat(0x250D3CA, 0.95)
	WriteFloat(0x250D40E, 0.97)
	WriteFloat(0x250D452, 0.98)
	end
	if ReadByte(Slot1+0x180) < ReadByte(Slot1+0x184) and Reverse == false and ReadShort(0x6877DA) == 0 and ReadByte(0x444861) ~= 13 and ReadByte(Now+0) ~= 0x0A then
	WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) + 1)
	elseif ReadByte(Slot1+0x180) == ReadByte(Slot1+0x184) and Reverse == false then
	Reverse = true
	elseif ReadByte(Slot1+0x180) > 0 and Reverse == true and ReadShort(0x6877DA) == 0 and ReadByte(0x444861) ~= 13 and ReadByte(Now+0) ~= 0x0A then
	WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) - 1)
	elseif ReadByte(Slot1+0x180) == 0 and Reverse == true then
	Reverse = false
	end
	WriteFloat(0x2530B8A, ReadByte(Slot1+0x180) * 1.25)
	WriteFloat(0x2530B7A, ReadByte(Slot1+0x180) * 3)
end
