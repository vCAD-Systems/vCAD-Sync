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
        print("vCAD: xPlayer ist nil...")
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
    header["apikey"] = tostring(Config.ApiKey)

    if Config.Computer == 'all' then
        local senddata = {}
        senddata["computer"] = 'all'
        if Config.Multichar then
            for k, v in pairs(Multichar) do
                if v.identifier == identifier then
                    senddata["unique"] = v.id
                end
            end
        else
            senddata["unique"] = identifier
        end
        senddata["name"] = name
        senddata["aliases"] = aliases
        senddata["gender"] = gender
        senddata["size"] = tostring(size)
        senddata["dateofbirth"] = dob

        if PhoneNumber[identifier] ~= nil then
            senddata["phone"] = tostring(PhoneNumber[identifier])
        end
        
        if Config.Sync_EyeColor then
            senddata["eyecolor"] = GetEyeColor(eyecolor)
        end
        if Config.Sync_HairColor then
            senddata["haircolor"] = GetHairColor(haircolor)
        end
        if BloodGroup[identifier] ~= nil then
            senddata["blood"] = BloodGroup[identifier]
        end
        Register_HttpRequest(senddata, header)
    else
        for k, v in pairs(Config.Computer) do
            local senddata = {}
            senddata["computer"] = v
            if Config.Multichar then
                for _, y in pairs(Multichar) do
                    if y.identifier == identifier then
                        senddata["unique"] = y.id
                    end
                end
            else
                senddata["unique"] = identifier
            end
            senddata["name"] = name
            senddata["aliases"] = aliases
            senddata["gender"] = gender
            senddata["size"] = tostring(size)
            senddata["dateofbirth"] = dob

            if PhoneNumber ~= nil or PhoneNumber[identifier] ~= nil then
                senddata["phone"] = tostring(PhoneNumber)
            end
            
            if Config.Sync_EyeColor then
                senddata["eyecolor"] = GetEyeColor(eyecolor)
            end
            if Config.Sync_HairColor then
                senddata["haircolor"] = GetHairColor(haircolor)
            end
            if BloodGroup ~= nil or BloodGroup[identifier] ~= nil then
                senddata["blood"] = BloodGroup[identifier]
            end
            Register_HttpRequest(senddata, header)
        end
    end
end)

function Register_HttpRequest(senddata, header)
    if Config.Debug then
        print(json.encode(senddata))
    end
    PerformHttpRequest("https://api.vcad.li/files/addfile?json_file=1", function (errorCode, resultData, resultHeaders)
        if Config.Debug then
            print("errorCode:" ..errorCode)
            print("resultData:" ..resultData)
        end
        Wait(100)
        resultData2 = json.decode(resultData)
        print(resultData2["data"]["insteadupdate"])
        

        if resultData2["data"]["insteadupdate"] == true then
            Update_HttpRequest(senddata, header)
        end
    end, 'POST', json.encode(senddata), header)
end

function Update_HttpRequest(senddata, header)
    if Config.Debug then
        print(json.encode(senddata))
    end
    PerformHttpRequest("https://api.vcad.li/files/updatefile?json_file=1", function (errorCode, resultData, resultHeaders)
        if Config.Debug then
            print(errorCode)
            print(resultData)
        end
    end, 'POST', json.encode(senddata), header)
end