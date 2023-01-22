CurrStorage = 120
MaxStorage = 120
Oblivion = 60
Fenrir = 2
Dragon = 5
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
--Backtrack = ReadByte(0x24795F1-0x56454E)
--MPSetter = ReadByte(0x24795F2-0x56454E)
--Reverse = ReadByte(0x24795F3-0x56454E)
local _CurrAnimPointer = ReadShort(ReadLong(0x00AD4218-0x56454E) + 0x180, true)
local animpointer=ReadLong(0x1B2512)+0x2A8
local soraGravityPointer=ReadLong(0x1B2512)+0x138
local L2 = ReadLong(0x2494573) > 500000 and ReadLong(0x2494573) < 1000000
	if ReadByte(Slot1+0x180) == 0 then
		WriteFloat(0x2530B7A, 21) -- Height
		WriteFloat(0x2530B8A, 8) -- Horizontal Distance
	elseif L2 == true and ReadByte(0x444861) ~= 13 and ReadByte(Now+0) ~= 0x0A and ReadByte(Save+0x3524) == 0 and ReadByte(Slot1+0x180) > 0 then --If L2 is pressed
		if ReadByte(0x24795F1-0x56454E) == 0 or ReadByte(0x24795F1-0x56454E) == 2 then
		CurrStorage = ReadByte(Slot1+0x180)
		MaxStorage = ReadByte(Slot1+0x184)
		WriteByte(0x24795F1-0x56454E, 1)
		end
		if ReadByte(0x24795F2-0x56454E) == 0 then
		WriteByte(Slot1+0x180, 1)
		WriteByte(0x24795F2-0x56454E, 1)
		end
		if ReadShort(Save+0x24F0) == 0x002B then
		Oblivion = Oblivion - 1
			if Oblivion <= 0 then
			WriteByte(Slot1+0x184, math.random(1, 160))
			WriteByte(Slot1+0x180, ReadByte(Slot1+0x184))
			Oblivion = 60
			end
		elseif ReadShort(Save+0x24F0) == 0x01F3 then
			Fenrir = Fenrir - 1
			if Fenrir <= 0 and ReadByte(0x24795F3-0x56454E) == 0 then
				if ReadByte(Slot1+0x180) < ReadByte(Slot1+0x184) then
				WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) + 1)
				Fenrir = 2
				end
			elseif ReadByte(Slot1+0x180) == ReadByte(Slot1+0x184) and ReadByte(0x24795F3-0x56454E) == 0 then
			WriteByte(0x24795F3-0x56454E, 1)
			elseif ReadByte(Slot1+0x180) > 1 and ReadByte(0x24795F3-0x56454E) == 1 then
			WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) - 1)
			elseif ReadByte(Slot1+0x180) == 1 and ReadByte(0x24795F3-0x56454E) == 1 then
			WriteByte(0x24795F3-0x56454E, 0)
			end
		elseif ReadShort(Save+0x24F0) == 0x01E1 then
			Dragon = Dragon - 1
			if Dragon <= 0 then
				Dragon = 5
				if ReadByte(Slot1+0x180) < ReadByte(Slot1+0x184) and ReadByte(0x24795F3-0x56454E) == 0 then
				WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) + 1)
				elseif ReadByte(Slot1+0x180) == ReadByte(Slot1+0x184) and ReadByte(0x24795F3-0x56454E) == 0 then
				WriteByte(0x24795F3-0x56454E, 1)
				elseif ReadByte(Slot1+0x180) > 1 and ReadByte(0x24795F3-0x56454E) == 1 then
				WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) - 1)
				elseif ReadByte(Slot1+0x180) == 1 and ReadByte(0x24795F3-0x56454E) == 1 then
				WriteByte(0x24795F3-0x56454E, 0)
				end
			end
		elseif ReadByte(Slot1+0x180) < ReadByte(Slot1+0x184) and ReadByte(0x24795F3-0x56454E) == 0 then
		WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) + 1)
		elseif ReadByte(Slot1+0x180) == ReadByte(Slot1+0x184) and ReadByte(0x24795F3-0x56454E) == 0 then
		WriteByte(0x24795F3-0x56454E, 1)
		elseif ReadByte(Slot1+0x180) > 1 and ReadByte(0x24795F3-0x56454E) == 1 then
		WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) - 1)
		elseif ReadByte(Slot1+0x180) == 1 and ReadByte(0x24795F3-0x56454E) == 1 then
		WriteByte(0x24795F3-0x56454E, 0)
		end
	WriteByte(Sys3+0x9E0,255) -- Fire Cost
	WriteByte(Sys3+0x15E0,255) -- Fira Cost
	WriteByte(Sys3+0x1610,255) -- Firaga Cost
	WriteByte(Sys3+0xA40,255) -- Blizzard Cost
	WriteByte(Sys3+0x1640,255) -- Blizzara Cost
	WriteByte(Sys3+0x1670,255) -- Blizzaga Cost
	WriteByte(Sys3+0xA10,255) -- Thunder Cost
	WriteByte(Sys3+0x16A0,255) -- Thundara Cost
	WriteByte(Sys3+0x16D0,255) -- Thundaga Cost
	WriteByte(Sys3+0xA70,255) -- Cure Cost
	WriteByte(Sys3+0x1700,255) -- Cura Cost
	WriteByte(Sys3+0x1730,255) -- Curaga Cost
	WriteByte(Sys3+0x1F40,255) -- Magnet Cost
	WriteByte(Sys3+0x1F70,255) -- Magnera Cost
	WriteByte(Sys3+0x1FA0,255) -- Magnega Cost
	WriteByte(Sys3+0x1FD0,255) -- Reflect Cost
	WriteByte(Sys3+0x2000,255) -- Reflera Cost
	WriteByte(Sys3+0x2030,255) -- Reflega Cost
		if ReadShort(Save+0x24F0) == 0x01E4 then 
		WriteFloat(0x2530B7A, ReadByte(Slot1+0x180) * 6) -- Height
		WriteFloat(0x2530B8A, ReadByte(Slot1+0x180)) -- Horizontal Distance
		elseif ReadShort(Save+0x24F0) == 0x01F4 then 
		WriteFloat(0x2530B7A, ReadByte(Slot1+0x180) * 1.5) -- Height
		WriteFloat(0x2530B8A, ReadByte(Slot1+0x180) * 4) -- Horizontal Distance
		else
		WriteFloat(0x2530B7A, ReadByte(Slot1+0x180) * 3) -- Height
		WriteFloat(0x2530B8A, ReadByte(Slot1+0x180) * 2) -- Horizontal Distance
		end
		if ReadShort(Save+0x24F0) == 0x01F3 then
		WriteByte(Slot1+0x184, 200)
		elseif ReadShort(Save+0x24F0) == 0x01E1 then
		WriteByte(Slot1+0x184, 20)
		elseif ReadShort(Save+0x24F0) == 0x01EC then
		WriteFloat(soraGravityPointer, 4, true)
		WriteByte(Slot1+0x184, 60)
		elseif ReadShort(Save+0x24F0) == 0x01EF then
		WriteFloat(soraGravityPointer, 64, true)
		WriteByte(Slot1+0x184, 120)
		elseif ReadShort(Save+0x24F0) == 0x02B then
		WriteFloat(soraGravityPointer, 16, true)
		else
		WriteFloat(soraGravityPointer, 16, true)
		WriteByte(Slot1+0x184, 120)
		end
		if _CurrAnimPointer == 181 then
			WriteFloat(animpointer, 3, true)
			WriteByte(Slot1+0x180, 1)
		else WriteFloat(animpointer, 1, true)
		end
	elseif L2 == false and ReadByte(0x444861) ~= 13 and ReadByte(Now+0) ~= 0x0A and ReadByte(Save+0x3524) == 0 then
		if ReadByte(0x24795F1-0x56454E) == 1 and ReadByte(Slot1+0x180) < ReadByte(Slot1+0x184) then
		WriteByte(Slot1+0x180, CurrStorage)
		WriteByte(Slot1+0x184, MaxStorage)
		WriteByte(0x24795F1-0x56454E, 2)
		end
	WriteFloat(animpointer, 1, true)
	WriteFloat(soraGravityPointer, 16, true)
	WriteByte(0x24795F2-0x56454E, 0)
	WriteByte(0x24795F1-0x56454E, 0)
	WriteByte(0x24795F3-0x56454E, 0)
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
	WriteFloat(0x2530B7A, 21) -- Height
	WriteFloat(0x2530B8A, 8) -- Horizontal Distance
	Oblivion = 60
	end
WriteFloat(0x250D342, 0)
WriteFloat(0x250D386, 0)
WriteFloat(0x250D3CA, 0)
WriteFloat(0x250D40E, 0)
WriteFloat(0x250D452, 0)
WriteFloat(Sys3+0x17CE4, 2) -- Base Speed: DS = 8
WriteFloat(Sys3+0x17CE0, 1) -- Walking Speed: DS = 2
end
