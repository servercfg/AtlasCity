local DISCORD_NAME = "Server Status"

function sendToDiscord(color, name, message, footer, text)
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = footer,
              },
          }
      }
  
    PerformHttpRequest('https://discordapp.com/api/webhooks/770658545401987153/AoABD3cIVh6Hb0BZInHJ1PYEOscLbZeXaZ9JDFt3embJdM0n3JVTrSBWufzeAV-ru24b', function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end

  sendToDiscord(3447003, "Serveren er på vej op!", "``connect cfx.re/join/68mkx7``", "BacksideRP")
