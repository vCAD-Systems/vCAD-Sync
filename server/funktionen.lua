function GetData(xPlayerVariables, value)
    if value == "gender" then
        if xPlayerVariables.sex == "m" then
            return "Männlich"
        elseif xPlayerVariables.sex == "f" then
            return "Weiblich"
        elseif xPlayerVariables.sex == "d" then
            return "Diverse"
        else
            return xPlayerVariables.sex
        end
    elseif value == "size" then
        return xPlayerVariables.height
    elseif value == "DOB" then
        return xPlayerVariables.dateofbirth
    end

    return ""
end

function GetAliases(ident)
    for _, v in pairs(Users) do
        if v.owner == ident then
            return v.aliases
        end
    end

    return ""
end

function GetPhoneNumber(ident)
    for _, v in pairs(Users) do
        if v.owner == ident then
            return v.phone
        end
    end

    return ""
end

function GetEyeColor(ident, number)
    for _, v in pairs(Users) do
        if ident == v.owner then
            local data = json.decode(v.skin)

            for k, c in pairs(Config.eye_color) do
                if data["eye_color"] == c.color then
                    return c.label
                end
            end
        end
    end

    return ""
end

function GetHairColor(ident, number)
    for _, v in pairs(Users) do
        if ident == v.owner then
            local data = json.decode(v.skin)

            for k, c in pairs(Config.hair_color) do
                if data["hair_color_1"] == c.color then
                    return c.label
                end
            end
        end
    end

    return ""
end

function CarType(hash)
    for _, v in pairs(Config.VehiclesList) do
        if v.Hash == hash then
            return v.Type
        end
    end

    return "Unbekannt"
end

function CarName(hash)
    for _, v in pairs(Config.VehiclesList) do
        if v.Hash == hash then
            return v.Label
        end
    end

    return "Unbekannt"
end

function PlayerName(owner)
    for _, v in pairs(Users) do
        if owner == v.owner then
            local fullname = v.firstname.." "..v.lastname
            return fullname
        end
    end
end

function DeleteString(path, before)
    local inf = assert(io.open(path, "r+"), "[vCAD-Sync] Fehler beim Öffnen der Datei.")
    local lines = ""
    
    while true do
        local line = inf:read("*line")
		if not line then break end
		
		if line ~= before then lines = lines .. line .. "\n" end
    end

    inf:close()
    file = io.open(path, "w")
    file:write(lines)
    file:close()
end

function lines_from(file)
    lines = {}
    
    for line in io.lines(file) do 
        lines[#lines + 1] = line
    end

    return lines
end