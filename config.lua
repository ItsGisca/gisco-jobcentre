Config = {}

Config.Debug = false -- Only use when in Development

Config.DiscordLogs = false -- WEBHOOK CAN BE ADDED IN THE sv_logs.lua FOR SAFETY OF YOU WEBHOOK URL

Config.DebugCommand = "jobcentredebug"

Config.Notify = "ox" -- "ox", "okok", "esx", "a-notify", "custom" (custom = add your own in cl_functions.lua)

Config.Locale = "en" -- "EN" or "NL"

Config.Jobcentre = {
    Method = "ox_target", -- "ox_target" or "TextUI"

    OpenKey = 38, -- ONLY WHEN METHOD IS ON TextUI | 38 = E
    
    Blip = {
        Enabled = true,
        Name = "JobCentre",
        Sprite = 411,
        Colour = 0,
        Scale = 0.7,
        ShortRange = true,
    },

    JobNPC = {
        {coords = vector3(-265.8987, -962.7223, 30.2231), model = "mp_m_weapexp_01", icon = "fa-solid fa-briefcase", action = "Open Job Centre", heading = 212.5984}
    },

    Jobs = {
        { name = 'unemployed', label = 'Unemployed', icon = 'fa-solid fa-check' },
        { name = 'police', label = 'Police', icon = 'fa-solid fa-shield' },
        { name = 'ambulance', label = 'Ambulance', icon = 'fa-solid fa-briefcase-medical' },
        { name = 'mechanic', label = 'Mechanic', icon = 'fa-solid fa-wrench' }
    },
}
