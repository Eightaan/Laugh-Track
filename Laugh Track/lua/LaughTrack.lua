if not XAudio then
    return
end	

blt.xaudio.setup()
LaughTrack.buffer = XAudio.Buffer:new(ModPath .. "Sound/LaughTrack.ogg")

if RequiredScript == "lib/managers/hud/hudplayercustody" then
    local lastplayed
    local set_civilians_killed_original = HUDPlayerCustody.set_civilians_killed
    function HUDPlayerCustody:set_civilians_killed(...)
	    if LaughTrack:GetOption("custody_laugh") then
            if not lastplayed or lastplayed < Application:time() + 5 then
                lastplayed = Application:time()
                local laugh = XAudio.Source:new(LaughTrack.buffer)
                laugh:set_relative(true)
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
                local laugh = XAudio.Source:new(LaughTrack.buffer)
                laugh:set_relative(true)
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
                local laugh = XAudio.Source:new(LaughTrack.buffer)
                laugh:set_relative(true)
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
                local laugh = XAudio.Source:new(LaughTrack.buffer)
                laugh:set_relative(true)
			    laugh:set_type(XAudio.Source.SOUND_EFFECT)
            end
	        return on_arrested_original(self, ...)
        end
    end
end