function GetData(value)
    xPlayer = ESX.GetPlayerFromId(source)

    local data = xPlayer.variables

    if value == "gender" then
        if data.sex == "m" then
            return "Männlich"
        elseif data.sex == "f" then
            return "Weiblich"
        elseif data.sex == "d" then
            return "Diverse"
        else
            return data.sex
        end
    elseif value == "size" then
        return data.height
    elseif value == "DOB" then
        return data.dateofbirth
    end
end

function GetEyeColor(number)
    for k, v in pairs(Config.eye_color) do
        if v.color == number then
            return v.label
        end
    end
    return ""
end

function GetHairColor(number)
    for k, v in pairs(Config.hair_color) do
        if v.color == number then
            return v.label
        end
    end
    return ""
end

function CarType(hash)
    for _, v in pairs(Config.VehiclesList) do
        if v.Hash == hash then
            --print("[vCAD]: Type:"..v.Type.." Hash:"..hash)
            return v.Type
        end
    end
    return "Unbekannt"
end

function CarName(hash)
    for _, v in pairs(Config.VehiclesList) do
        if v.Hash == hash then
            --print("[vCAD]: Name:"..v.Type.." Hash:"..hash)
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