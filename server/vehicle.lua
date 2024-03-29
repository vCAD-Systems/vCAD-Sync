function syncVehicles(Owned_Vehicles)
    print("[vCAD]: syncVehicles() Starting...")
    local header = {}
    header["content-type"] = "application/json"
    header["apikey"] = tostring(Config.ApiKey)

    for k, v in pairs(Owned_Vehicles) do
        local senddata = {}

        local dc = json.decode(v.vehicle)
        model = dc['model']
        plate = dc['plate']

        senddata['unique'] = v.id
        senddata['plate'] = plate
        senddata['cartyp'] = CarType(model)
        senddata['car'] = CarName(model)
        senddata['owner'] = PlayerName(v.owner)
        if Config.Vehicle.HU_spalte ~= nil or Config.Vehicle.HU_spalte ~= 'nil' then
            if v.HU ~= "" then
                senddata['safetodrive'] = v.HU
            end
        end
        
        Register_Vehicle_HttpRequest(senddata, header)
    end

    if Config.Debug then
        print("[vCAD]: Vehicle Sync beendet...")
    end
end

function Register_Vehicle_HttpRequest(senddata, header)
    if Config.Debug then
        print("[vCAD][Vehicle][senddata]:"..json.encode(senddata))
    end
    PerformHttpRequest("https://api.vcad.li/vehicles/addvehicle?json_file=1", function (errorCode, resultData, resultHeaders)
        if Config.Debug then
            print("errorCode:" ..errorCode)
            print("resultData:" ..resultData)
        end
        Wait(100)
        resultData2 = json.decode(resultData)
        
        if resultData2 == nil then
            print("[vCAD-Sync] Fehler bei der Decodierung der Antwort aufgetreten.")
            return
        end

        if resultData2["data"]["insteadupdate"] == true then
            Update_Vehicle_HttpRequest(senddata, header)
        end
    end, 'POST', json.encode(senddata), header)
end

function Update_Vehicle_HttpRequest(senddata, header)
    PerformHttpRequest("https://api.vcad.li/vehicles/updatevehicle?json_file=1", function (errorCode, resultData, resultHeaders)
        if Config.Debug then
            print(errorCode)
            print(resultData)
        end
    end, 'POST', json.encode(senddata), header)
end
