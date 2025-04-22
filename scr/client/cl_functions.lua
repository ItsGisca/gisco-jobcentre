ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('gisco-jobcentre:client:notify') -- DONT CHANGE THE EVENT NAME
AddEventHandler('gisco-jobcentre:client:notify', function(type, title, description, duration) -- DONT CHANGE THE EVENT NAME
    if Config.Notify == 'ox' then -- For the ox notification
        TriggerEvent("ox_lib:notify", {
            type = type or 'info',
            title = title or 'Gisco-jobcentre',
            description = description,
            duration = duration or 5000
        })
    elseif Config.Notify == 'okok' then -- For the okokNotification
        exports['okokNotify']:Alert(title or 'Gisco jobcentre', description, duration or 5000, type or 'info')
    elseif Config.Notify == 'esx' then -- For the ESX notification
        ESX.ShowNotification(description or "Translations Not Right")
    elseif Config.Notify == 'a-notify' then -- For the A notify
        exports['Aymina-Notify']:SendNotification({
            type = type,
            title = title or 'Gisco-jobcentre',
            description = description,
        })
    elseif Config.Notify == 'custom' then
        -- Add your own notify!
    end
end)

-- TriggerEvent('gisco-jobcentre:client:notify', 'type', 'title', 'description', duration)