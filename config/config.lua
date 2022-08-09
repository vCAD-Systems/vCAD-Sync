--[[
    Für weitere Details steht euch auch die Dokumentation zur Verfügung.
    gehe dazu einfach auf 
]]

Config = {}
Config.Senddata = false

--[[
    Setze das auf True um die vCAD-Server Antworten in eurer Server Console zu sehen.
]]
Config.Debug = true

--[[
    Trage hier dein PublicKey ein!
    Config.PublicKey = "PUBLIC_KEY"
]]
Config.PublicKey = "julianisgay"

--[[
    Setze die Computer ID ein um es an ein bestimmten PC zu senden.
    z.B 
    Computer = {1, 5} oder {1}
    oder
    Computer = "all"
]]
Config.Computer = 'all'

--[[
    Wollt Ihr das die Aktuellen Haare in der Akte eingetragen wird, wenn der Spieler auf dem Server joint?
    Deaktiviert: false
    Aktivieren: true
]]
Config.Sync_HairColor = true

--[[
    Wollt Ihr das die Aktuellen Haare in der Akte eingetragen wird, wenn der Spieler auf dem Server joint?
    Deaktiviert: false
    Aktivieren: true
]]
Config.Sync_EyeColor = true

--[[
    Hier müsst Ihr selber die Funktion bauen, da jedes MedicSystem
    unterschiedlich Funktioniert.

    Diese Funktion wird nur für MedicNet genutzt. Ist aber keine Pflichangabe.
]]
function GetBlood(SpielerID)
    return ""
end