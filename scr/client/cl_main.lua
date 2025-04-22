ESX = exports["es_extended"]:getSharedObject()

CreateThread(function()
    for _, npcData in pairs(Config.Jobcentre.JobNPC) do
        RequestModel(npcData.model)
        while not HasModelLoaded(npcData.model) do
            Wait(100)
        end

        local npc = CreatePed(4, npcData.model, npcData.coords.x, npcData.coords.y, npcData.coords.z, npcData.heading, false, true)

        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        FreezeEntityPosition(npc, true)

        if Config.Jobcentre.Blip.Enabled then
            local blip = AddBlipForEntity(npc)
            SetBlipSprite(blip, Config.Jobcentre.Blip.Sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.Jobcentre.Blip.Scale)
            SetBlipColour(blip, Config.Jobcentre.Blip.Colour)
            SetBlipAsShortRange(blip, Config.Jobcentre.Blip.ShortRange)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Jobcentre.Blip.Name)
            EndTextCommandSetBlipName(blip)
        end

        if Config.Jobcentre.Method == "ox_target" then
            exports["ox_target"]:addSphereZone({
                coords = npcData.coords,
                radius = 2.0,
                debug = Config.Debug,
                options = {
                    {
                        name = npcData.action,
                        icon = npcData.icon,
                        label = npcData.action,
                        canInteract = function()
                            local playerPed = PlayerPedId()
                            local playerCoords = GetEntityCoords(playerPed)
                            local distance = #(playerCoords - vector3(npcData.coords.x, npcData.coords.y, npcData.coords.z))
                            return distance <= 2.0
                        end,
                        onSelect = function()
                            OpenJobCentre()
                        end,
                    },
                }
            })
        elseif Config.Jobcentre.Method == "TextUI" then
            lib.zones.sphere({
                coords = npcData.coords,
                radius = 2.0,
                debug = Config.Debug,
                inside = function()
                    if not isSelling then
                        lib.showTextUI((TranslateCap('open_menu_textui')))
                        if IsControlJustPressed(0, Config.Jobcentre.OpenKey) then
                            -- lib.hideTextUI()
                            OpenJobCentre()
                        end
                    end
                end,
                onEnter = function()
                    lib.showTextUI((TranslateCap('open_menu_textui')))
                end,
                onExit = function()
                    lib.hideTextUI()
                end,
            })
        end
            
    end
end)

function OpenJobCentre()
    local options = {}

    -- Dynamisch opties toevoegen vanuit de configuratie
    for _, job in pairs(Config.Jobcentre.Jobs) do
        table.insert(options, {
            title = job.label,
            description = TranslateCap('select_job_description', job.label),
            icon = job.icon,
            onSelect = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local npcCoords = Config.Jobcentre.JobNPC[1].coords -- Neem de eerste NPC-coördinaten

                -- Controleer of de speler binnen 30 meter is
                if #(playerCoords - npcCoords) > 30.0 then
                    print(TranslateCap('too_far_title'))
                    return
                end

                -- Stuur verzoek naar de server
                TriggerServerEvent('gisco-jobcentre:setJob', job.name)
            end
        })
    end

    -- Contextmenu registreren
    lib.registerContext({
        id = 'banencentrum',
        title = TranslateCap('banencentrum_title'),
        options = options
    })

    -- Contextmenu openen
    lib.showContext('banencentrum')
end

if Config.Debug then
    RegisterCommand(Config.DebugCommand, function()
        OpenJobCentre()
    end, false)
end