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

function syncPlayer()
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local ident = xPlayer.identifier

        local aliases, name, gender, size, dob = nil

        if xPlayer ~= nil then
            if Config.CharSync.Aliases ~= nil or Config.CharSync.Aliases ~= 'nil' then
                aliases = GetAliases(ident)
            end

            name = xPlayer.name
            gender = GetData(xPlayer.variables, "gender")
            size = GetData(xPlayer.variables, "size")
            dob = GetData(xPlayer.variables, "DOB")

            local header = {}
            header["content-type"] = "application/json"
            header["apikey"] = tostring(Config.ApiKey)

            if Config.Computer == 'all' then
                local senddata = {}
                senddata["computer"] = 'all'
                if Config.CharSync.Multichar then
                    for k, v in pairs(Users) do
                        if v.identifier == ident then
                            senddata["unique"] = v.id
                        end
                    end
                else
                    senddata["unique"] = ident
                end
                senddata["name"] = name
                senddata["aliases"] = aliases or ""
                senddata["gender"] = gender
                senddata["size"] = tostring(size)
                senddata["dateofbirth"] = dob

                if Config.CharSync.Phone_Number ~= nil or Config.CharSync.Phone_Number ~= 'nil' then
                    senddata["phone"] = GetPhoneNumber(ident)
                end
                
                if Config.CharSync.EyeColor then
                    senddata["eyecolor"] = GetEyeColor(ident, eyecolor)
                end
                if Config.CharSync.HairColor then
                    senddata["haircolor"] = GetHairColor(ident, haircolor)
                end
                if BloodGroup[ident] ~= nil then
                    --senddata["blood"] = BloodGroup[ident]
                end
                Register_HttpRequest(senddata, header)
            else
                for k, v in pairs(Config.Computer) do
                    local senddata = {}
                    senddata["computer"] = v
                    if Config.CharSync.Multichar then
                        for _, y in pairs(Users) do
                            if y.identifier == ident then
                                senddata["unique"] = y.id
                            end
                        end
                    else
                        senddata["unique"] = ident
                    end
                    senddata["name"] = name
                    senddata["aliases"] = aliases or ""
                    senddata["gender"] = gender
                    senddata["size"] = tostring(size)
                    senddata["dateofbirth"] = dob
        
                    if Config.CharSync.Phone_Number ~= nil or Config.CharSync.Phone_Number ~= 'nil' then
                        senddata["phone"] = GetPhoneNumber(ident)
                    end
                    
                    if Config.CharSync.EyeColor then
                        senddata["eyecolor"] = GetEyeColor(ident, eyecolor)
                    end
                    if Config.CharSync.HairColor then
                        senddata["haircolor"] = GetHairColor(ident, haircolor)
                    end
                    if BloodGroup ~= nil or BloodGroup[ident] ~= nil then
                        --senddata["blood"] = BloodGroup[ident]
                    end
                    Register_HttpRequest(senddata, header)
                end
            end

            if Config.Debug then
                print("[vCAD]: Player Sync beendet...")
            end
        else
            if Config.Debug then
                print("[vCAD][CharSync] xPlayer Error!")
            end
        end
    end
end

function Register_HttpRequest(senddata, header)
    if Config.Debug then
        print("[vCAD][CharSync][senddata]:"..json.encode(senddata))
    end
    PerformHttpRequest("https://api.vcad.li/files/addfile?json_file=1", function (errorCode, resultData, resultHeaders)
        if Config.Debug then
            print("errorCode:" ..errorCode)
            print("resultData:" ..resultData)
        end
        Wait(100)
        resultData2 = json.decode(resultData)
        

        if resultData2["data"]["insteadupdate"] == true then
            Update_HttpRequest(senddata, header)
        end
    end, 'POST', json.encode(senddata), header)
end

function Update_HttpRequest(senddata, header)
    PerformHttpRequest("https://api.vcad.li/files/updatefile?json_file=1", function (errorCode, resultData, resultHeaders)
        if Config.Debug then
            print(errorCode)
            print(resultData)
        end
    end, 'POST', json.encode(senddata), header)
end