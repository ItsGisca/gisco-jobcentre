ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('gisco-jobcentre:setJob', function(jobName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local jobExists = false
    for _, job in pairs(Config.Jobcentre.Jobs) do
        if job.name == jobName then
            jobExists = true
            break
        end
    end

    if not jobExists then
        DropPlayer(src, TranslateCap('job_changed_log_description'))
        return
    end

    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local npcCoords = Config.Jobcentre.JobNPC[1].coords 

    if #(playerCoords - npcCoords) > 30.0 then
        DropPlayer(src, TranslateCap('too_far_title'))
        return
    end

    xPlayer.setJob(jobName, 0)

    local playerLicense = xPlayer.identifier
    if Config.DiscordLogs then
        sendToDiscord(0, TranslateCap('job_changed_log'), {
            {
                ["name"] = "> " .. TranslateCap('steam_name'),
                ["value"] = "```\n" .. GetPlayerName(src) .. "\n```",
                ["inline"] = true
            },
            {
                ["name"] = "> " .. TranslateCap('license'),
                ["value"] = "```\n" .. playerLicense .. "\n```",
                ["inline"] = false
            },
            {
                ["name"] = "> " .. TranslateCap('new_job'),
                ["value"] = "```\n" .. jobName .. "\n```",
                ["inline"] = false
            }
        })
    end
end)