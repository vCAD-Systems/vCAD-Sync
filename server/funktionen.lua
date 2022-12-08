function GetData(ident)
    local returnData = {}
    local xPlayer = ESX.GetPlayerFromIdentifier(ident)

    local data = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier="'..xPlayer.identifier..'"', {})
    data = data[1]

    if data.sex == "m" then
        returnData.gender = "Männlich"
    elseif data.sex == "f" then
        returnData.gender = "Weiblich"
    elseif data.sex == "d" then
        returnData.gender = "Diverse"
    else
        returnData.gender = data.sex
    end

    returnData.height = data.height
    returnData.dob = data.dateofbirth
    returnData.name = (data.firstname.." "..data.lastname)

    return returnData
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