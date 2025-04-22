ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('gisco-jobcentre:setJob', function(jobName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    -- Controleer of de job in de configuratie staat
    local jobExists = false
    for _, job in pairs(Config.Banencentrum.Jobs) do
        if job.name == jobName then
            jobExists = true
            break
        end
    end

    if not jobExists then
        DropPlayer(src, "Je hebt geprobeerd een ongeldige job te selecteren.")
        return
    end

    -- Controleer of de speler binnen 30 meter van de NPC is
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local npcCoords = Config.Banencentrum.JobNPC[1].coords -- Neem de eerste NPC-coördinaten

    if #(playerCoords - npcCoords) > 30.0 then
        DropPlayer(src, "Je bent te ver weg van het Banencentrum.")
        return
    end

    -- Zet de job
    xPlayer.setJob(jobName, 0)

    local playerLicense = xPlayer.identifier
    if Config.DiscordLogs then
        sendToDiscord(0, "Baan Veranderd", {
            {
                ["name"] = "> Steanname",
                ["value"] = "```\n" .. GetPlayerName(src) .. "\n```",
                ["inline"] = true
            },
            {
                ["name"] = "> LICENSE",
                ["value"] = "```\n" .. playerLicense .. "\n```",
                ["inline"] = false
            },
            {
                ["name"] = "> NEW JOB",
                ["value"] = "```\n" .. jobName .. "\n```",
                ["inline"] = false
            }
        })
    end
end)