if not XAudio then
    return
end	

blt.xaudio.setup()

local tased_setting = LaughTrack:GetOption("tased_laugh_track")
local downed_setting = LaughTrack:GetOption("downed_laugh_track")
local cuffed_setting = LaughTrack:GetOption("cuffed_laugh_track")
local custody_setting = LaughTrack:GetOption("custody_laugh_track")

local theme_track = LaughTrack:GetOption("theme_track") and "Sound/theme.ogg" or "Sound/nothing.ogg"
local tased_track = tased_setting < 2 and "sound/LaughTrack.ogg" or tased_setting > 2 and "Sound/curb.ogg" or "Sound/cardi_b_laugh.ogg"
local downed_track = downed_setting < 2 and "Sound/LaughTrack.ogg" or downed_setting > 2 and "Sound/curb.ogg" or "Sound/cardi_b_laugh.ogg"
local cuffed_track = cuffed_setting < 2 and "Sound/LaughTrack.ogg" or cuffed_setting > 2 and "Sound/curb.ogg" or "Sound/cardi_b_laugh.ogg"
local custody_track = custody_setting < 2 and "Sound/LaughTrack.ogg" or custody_setting > 2 and "Sound/curb.ogg" or "Sound/cardi_b_laugh.ogg"

LaughTrack.nothing = XAudio.Buffer:new(ModPath .. "Sound/nothing.ogg")
LaughTrack.custody = XAudio.Buffer:new(ModPath .. custody_track)
LaughTrack.downed = XAudio.Buffer:new(ModPath .. downed_track)
LaughTrack.cuffed = XAudio.Buffer:new(ModPath .. cuffed_track)
LaughTrack.tazed = XAudio.Buffer:new(ModPath .. tased_track)
LaughTrack.theme = XAudio.Buffer:new(ModPath .. theme_track)

if RequiredScript == "lib/managers/hud/hudplayercustody" then
    local lastplayed
    local set_civilians_killed_original = HUDPlayerCustody.set_civilians_killed
    function HUDPlayerCustody:set_civilians_killed(...)
	    if LaughTrack:GetOption("custody_laugh") then
            if not lastplayed or lastplayed < Application:time() + 5 then
                lastplayed = Application:time()
                local laugh = XAudio.Source:new(LaughTrack.custody)
				local RNG = math.random(0,100)
				local theme = RNG < 5 and XAudio.Source:new(LaughTrack.theme) or XAudio.Source:new(LaughTrack.nothing)
                laugh:set_relative(true)
				theme:set_relative(true)
			    laugh:set_type(XAudio.Source.SOUND_EFFECT)
            end
		end
        return set_civilians_killed_original(self, ...)
    end

elseif RequiredScript == "lib/units/beings/player/playerdamage" then
    local lastplayed
    local on_downed_original = PlayerDamage.on_downed
    function PlayerDamage:on_downed(...)
	    if LaughTrack:GetOption("downed_laugh") then
            if not lastplayed or lastplayed < Application:time() + 5 then
                lastplayed = Application:time()
                local laugh = XAudio.Source:new(LaughTrack.downed)
				local RNG = math.random(0,100)
				local theme = RNG < 5 and XAudio.Source:new(LaughTrack.theme) or XAudio.Source:new(LaughTrack.nothing)
                laugh:set_relative(true)
				theme:set_relative(true)
				laugh:set_type(XAudio.Source.SOUND_EFFECT)
            end
            return on_downed_original(self, ...)
		end	
    end

	local on_tased_original = PlayerDamage.on_tased
    function PlayerDamage:on_tased(...)
	    if LaughTrack:GetOption("tased_laugh") then
	        if not lastplayed or lastplayed < Application:time() + 5 then
                lastplayed = Application:time()
                local laugh = XAudio.Source:new(LaughTrack.tazed)
				local RNG = math.random(0,100)
				local theme = RNG < 5 and XAudio.Source:new(LaughTrack.theme) or XAudio.Source:new(LaughTrack.nothing)
                laugh:set_relative(true)
				theme:set_relative(true)
			    laugh:set_type(XAudio.Source.SOUND_EFFECT)
            end
	        return on_tased_original(self, ...)
		end	
    end

    if LaughTrack:GetOption("cuffed_laugh") then
	    local on_arrested_original = PlayerDamage.on_arrested
	    function PlayerDamage:on_arrested(...)
            if not lastplayed or lastplayed < Application:time() + 5 then
                lastplayed = Application:time()
                local laugh = XAudio.Source:new(LaughTrack.cuffed)
				local RNG = math.random(0,100)
				local theme = RNG < 5 and XAudio.Source:new(LaughTrack.theme) or XAudio.Source:new(LaughTrack.nothing)
                laugh:set_relative(true)
				theme:set_relative(true)
			    laugh:set_type(XAudio.Source.SOUND_EFFECT)
            end
	        return on_arrested_original(self, ...)
        end
    end
end