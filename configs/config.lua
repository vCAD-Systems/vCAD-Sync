Config = {}
--[[
    Für weitere Details steht euch auch die Dokumentation zur Verfügung.
    gehe dazu einfach auf 
]]

--[[
    Setze das auf True um die vCAD-Server Antworten in eurer Server Console zu sehen.
]]
Config.Debug = false

--[[
    Trage hier dein PrivateKey ein!
    Config.ApiKey = "PRIVATE_KEY"
]]
Config.ApiKey = ""

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
Config.Sync_HairColor = false

--[[
    Wollt Ihr das die Aktuellen Augenfarbe in der Akte eingetragen wird, wenn der Spieler auf dem Server joint?
    Deaktiviert: false
    Aktivieren: true
]]
Config.Sync_EyeColor = false

Config.Multichar = {
    --[[
        Solltet Ihr ein Multichar-System nutzen, Aktiviert diese Funktion damit keine Akten mehrmals erstellt werden.
        An = true
        Aus = false
    ]]
    Activated = false,

    Spalte = nil
}

Config.Vehicle = {
    --[[
        Solltet Ihr den Vehicle Sync nutzen wollen, schaltet diesen hier ein.
        An = true
        Aus = false
    ]]
    Activated = true,

    HU_spalte = nil
}
--[[
    Ändern Sie den Befehl nach Belieben
    Config.Command = nil | Deaktiviert
]]
Config.Command = "vCAD-Car" -- Ändern Sie den Befehl nach Belieben

--[[
    User rechte für den Command
    Trage hier die User ein die Rechte haben deine Config Fahrzeuge hinzuzufügen.
]]
Config.Admins = {
    {
        identifier = "",
        name = "",
    }
}