if not LaughTrack then
    _G.LaughTrack =
    {
        _path = ModPath,
        _data_path = SavePath .. "LaughTrack.json",
        SaveDataVer = 1,
        data = {}
    }

    function LaughTrack:Save()
        local file = io.open( self._data_path, "w+" )
        if file then
            self._data.SaveDataVer = self.SaveDataVer
            file:write( json.encode( self._data ) )
            file:close()
        end
    end

    function LaughTrack:Load()
        self:LoadDefaults()
        local file = io.open( self._data_path, "r" )
        if file then
            local data = json.decode( file:read("*all") )
            file:close()
            if data.SaveDataVer and data.SaveDataVer == self.SaveDataVer then
                for k, v in pairs(data) do
                    if self._data[k] ~= nil then
                        self._data[k] = v
                    end
                end
            end
        end
    end

    function LaughTrack:LoadDefaults()
        local default_file = io.open(LaughTrack._path .."Menu/default_values.json")
        self._data = json.decode(default_file:read("*all"))
        default_file:close()
    end

    function LaughTrack:GetOption(id)
        return self._data[id]
    end

    LaughTrack:Load()
end