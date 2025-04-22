-- Define the webhook URL here
local webhookURL = "OWN WEBHOOK URL"

function sendToDiscord(color, title, fields, username, avatarURL)
    if not webhookURL or webhookURL == "" then
        print("^1[ERROR] Geen webhook URL opgegeven in de configuratie^7")
        return
    end

    local embed = {
        {
            ["title"] = title,
            ["color"] = color,
            ["fields"] = fields,
            ["footer"] = {
                ["text"] = "Gisco JobCentre - Logs"
            }
        }
    }

    local payload = {
        ["username"] = username or "Gisco Jobcentre", -- Default username
        ["avatar_url"] = avatarURL or "https://i.ibb.co/VcPnhp6y/G-frameworktrans.png", -- Default profile picture
        ["embeds"] = embed
    }

    PerformHttpRequest(webhookURL, function(err, text, headers)
        if err ~= 200 then
            print("^1[ERROR] Discord Webhook fout: " .. err .. "^7")
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end