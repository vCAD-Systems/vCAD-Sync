ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:PlayerLoaded')
AddEventHandler('esx:PlayerLoaded', function(xPlayer)
	local ped = PlayerPedId()
	local eyecolor = GetPedEyeColor(ped)
	local haircolor = GetPedHairColor(ped)

	TriggerServerEvent('vCAD-Sync:pload', eyecolor, haircolor)
end)

RegisterCommand('vCAD-Sync',function(source, args)
	local ped = PlayerPedId()
	local eyecolor = GetPedEyeColor(ped)
	local haircolor = GetPedHairColor(ped)

	TriggerServerEvent('vCAD-Sync:pload', eyecolor, haircolor)
end, false)