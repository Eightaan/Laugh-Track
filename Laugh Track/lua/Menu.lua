Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_laughtrack", function( loc )
	    loc:load_localization_file(LaughTrack._path .. "loc/english.json")
end)


Hooks:Add( "MenuManagerInitialize", "MenuManagerInitialize_laughtrack", function( menu_manager )
	MenuCallbackHandler.callback_downed_laugh = function(self, item)
        LaughTrack._data.downed_laugh = item:value() == "on"
    end
	MenuCallbackHandler.callback_tased_laugh = function(self, item)
        LaughTrack._data.tased_laugh = item:value() == "on"
    end
	MenuCallbackHandler.callback_custody_laugh = function(self, item)
        LaughTrack._data.custody_laugh = item:value() == "on"
    end
	MenuCallbackHandler.callback_cuffed_laugh = function(self, item)
        LaughTrack._data.cuffed_laugh = item:value() == "on"
    end
    MenuCallbackHandler.LaughtrackSave = function(this, item)
        LaughTrack:Save()
    end

	MenuHelper:LoadFromJsonFile( LaughTrack._path .. "Menu/menu.json", LaughTrack, LaughTrack._data )
end)

