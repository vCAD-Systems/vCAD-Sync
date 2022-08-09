ESX = nil
PhoneNumber = nil
BloodGroup = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

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

RegisterServerEvent('vCAD-Sync:SetBloodGroup')
AddEventHandler('vCAD-Sync:SetBloodGroup', function(blood)
    local xPlayer = ESX.GetPlayerFromId(source)
    BloodGroup[xPlayer.identifier] = blood
end)

RegisterServerEvent('vCAD-Sync:SetPhoneNumber')
AddEventHandler('vCAD-Sync:SetPhoneNumber', function(number)
    local xPlayer = ESX.GetPlayerFromId(source)
    PhoneNumber[xPlayer.identifier] = number
end)

RegisterServerEvent('vCAD-Sync:pload')
AddEventHandler('vCAD-Sync:pload', function(eyecolor, haircolor)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local name, gender, size, dob = nil

    if xPlayer == nil then
        print("xPlayer ist nil...")
        return
    end

    local identifier = xPlayer.identifier
    local aliases = xPlayer.getName()

    name = xPlayer.name
    gender = GetData("gender")
    size = GetData("size")
    dob = GetData("DOB")

    local header = {}
    header["content-type"] = "application/json"
    header["apikey"] = Config.PublicKey

    if Config.Computer == 'all' then
        local senddata = {}
        senddata["computer"] = 'all'
        senddata["unique"] = identifier
        senddata["name"] = name
        senddata["aliases"] = aliases
        senddata["gender"] = gender
        senddata["size"] = tostring(size)
        senddata["dateofbirth"] = dob

        if PhoneNumber ~= nil then
            senddata["phone"] = tostring(PhoneNumber)
        end
        
        if Config.Sync_EyeColor then
            senddata["eyecolor"] = GetEyeColor(eyecolor)
        end
        if Config.Sync_HairColor then
            senddata["haircolor"] = GetHairColor(haircolor)
        end
        if Config.Sync_BloodGroup and BloodGroup ~= nil then
            senddata["blood"] = BloodGroup[identifier]
        end
        HttpRequest(senddata)
    else
        for k, v in pairs(Config.Computer) do
            local senddata = {}
        senddata["computer"] = 'all'
        senddata["unique"] = identifier
        senddata["name"] = name
        senddata["aliases"] = aliases
        senddata["gender"] = gender
        senddata["size"] = tostring(size)
        senddata["dateofbirth"] = dob

        if PhoneNumber ~= nil then
            senddata["phone"] = tostring(PhoneNumber)
        end
        
        if Config.Sync_EyeColor then
            senddata["eyecolor"] = GetEyeColor(eyecolor)
        end
        if Config.Sync_HairColor then
            senddata["haircolor"] = GetHairColor(haircolor)
        end
        if Config.Sync_BloodGroup and BloodGroup ~= nil then
            senddata["blood"] = BloodGroup[identifier]
        end
            HttpRequest(senddata)
        end
    end
end)

function HttpRequest(senddata)
    print(json.encode(senddata))
    if Config.Senddata then
        PerformHttpRequest("https://api.vcad.li/files/addfile?json_file=1", function (errorCode, resultData, resultHeaders)
            if Config.Debug then
                print(errorCode)
                print(resultData)
            end            
        end, 'POST', json.encode(senddata), header)
    end
end