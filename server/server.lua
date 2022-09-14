ESX = nil
Users = {}
Owned_Vehicles = {}
PhoneNumber = {}
BloodGroup = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if Config.Multichar.Activated then
            MySQL.query("SELECT * FROM users", function(rs)
                if rs[1].id == nil then
                    MySQL.query("ALTER TABLE `users` ADD `id` BIGINT NOT NULL AUTO_INCREMENT FIRST, ADD UNIQUE (`id`)")
                end
            end)
        end

        if Config.Vehicle.Activated then
            MySQL.query("SELECT * FROM owned_vehicles", function(rs)
                if rs[1].id == nil then
                    MySQL.query("ALTER TABLE `owned_vehicles` ADD `id` BIGINT NOT NULL AUTO_INCREMENT FIRST, ADD UNIQUE (`id`)")
                end
            end)
        end

        if Config.Multichar.Activated or Config.Vehicle.Activated then
            Wait(5000)
            repetitions()
        end
    end
end)

function repetitions()
    print("Script Startet Wait...")
    while true do
        Users = {}
        MySQL.query("SELECT * FROM users", function(rs)
            for _, v in pairs(rs) do
                table.insert(Users, {id = v.id or nil, owner = v.identifier, firstname = v.firstname, lastname = v.lastname})
            end
        end)
        if Config.Multichar.Activated then
            csync()
        end

        if Config.Vehicle.Activated then
            Owned_Vehicles = {}
            MySQL.query("SELECT * FROM owned_vehicles", function(rs)
                if Config.Vehicle.HU_spalte ~= nil or Config.Vehicle.HU_spalte ~= 'nil' then
                    for _, v in pairs(rs) do
                        table.insert(Owned_Vehicles, {id = v.id, owner = v.owner, vehicle = v.vehicle})
                    end
                else
                    for _, v in pairs(rs) do
                        table.insert(Owned_Vehicles, {id = v.id, owner = v.owner, vehicle = v.vehicle, HU = v[Config.Vehicle.HU_spalte]})
                    end
                end
                Wait(1000)
                vsync()
            end)
        end
        Wait(3 * 60000)
    end
end

RegisterServerEvent('vCAD-Sync:InsertConfigVehicle')
AddEventHandler('vCAD-Sync:InsertConfigVehicle', function(vehhash, type, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ident = xPlayer.identifier

    for k, v in pairs(Config.Admins) do
        if v.identifier == ident then
            AddVehicleToConf(vehhash, type, name, v.owner, ident)
        end
    end
end)

function AddVehicleToConf(vehhash, type, name, owner, ident)
    local path = GetResourcePath(GetCurrentResourceName())
    local lines_config = lines_from(path.."/configs/vehicle.lua")

    for k,v in pairs(lines_config) do
        if k == #lines_config then
            DeleteString(path.."/configs/vehicle.lua", "}")
        end
    end

    local file = io.open(path.."/configs/vehicle.lua", "a") 

    file:write("\n	{")
    file:write("\n		Type = '"..type.."',")
    file:write("\n		Label = '"..name.."',")
    file:write("\n		Hash = "..vehhash..",")
    file:write("\n      },")
    file:write("\n}")
    file:close()


end