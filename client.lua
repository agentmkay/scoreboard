-- Open & build the scoreboard when the server sends data
RegisterNetEvent('ls_scoreboard:open', function(data)
    local totalPlayers = data.totalPlayers or 0
    local copsOnline   = data.copsOnline   or 0

    local options = {}

    -- Basic info rows
    table.insert(options, {
        title    = ('Players Online: **%d**'):format(totalPlayers),
        icon     = 'fas fa-users',
        readOnly = true,
        metadata = {
            { label = 'Total Players', value = totalPlayers }
        }
    })

    table.insert(options, {
        title    = ('Police Online: **%d**'):format(copsOnline),
        icon     = 'fas fa-user-shield',
        readOnly = true,
        metadata = {
            { label = 'Police Online', value = copsOnline }
        }
    })

    -- Activities from Config.Activities
    for _, activity in ipairs(Config.Activities) do
        local required = activity.requiredCops or 0
        local enough   = copsOnline >= required
        local status   = enough and '**Available**' or '**Locked**'

        local progress = 0
        if required > 0 then
            progress = math.floor(math.min((copsOnline / required) * 100, 100))
        end

        table.insert(options, {
            title       = activity.label,
            description = ('Requires **%d** police (currently %d)\nStatus: %s'):format(
                required,
                copsOnline,
                status
            ),
            icon        = 'fas fa-briefcase',
            readOnly    = true,
            progress    = progress,
            -- Green if enough cops, red if not
            progressColor = enough and '#16A34A' or '#DC2626',
            metadata = {
                { label = 'Required Cops', value = required },
                { label = 'Online Cops',   value = copsOnline },
                { label = 'Status',        value = enough and 'Available' or 'Locked' }
            }
        })
    end

    -- Register (or overwrite) the scoreboard menu
    exports.lation_ui:registerMenu({
        id       = 'ls_scoreboard',
        title    = Config.MenuTitle or 'Server Scoreboard',
        subtitle = ('Players: %d  •  Police: %d'):format(totalPlayers, copsOnline),
        position = Config.MenuPosition or 'offcenter-right',
        options  = options
    })

    -- Show it
    exports.lation_ui:showMenu('ls_scoreboard')
end)

-- Command that asks the server for fresh data
RegisterCommand('openScoreboard', function()
    TriggerServerEvent('ls_scoreboard:requestData')
end, false)

-- Keybind: HOME -> /openScoreboard
RegisterKeyMapping('openScoreboard', 'Open Scoreboard', 'keyboard', 'HOME')
