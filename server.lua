local QBCore = exports['qb-core']:GetCoreObject()

local function GetPlayerCounts()
    local players = QBCore.Functions.GetPlayers()
    local totalPlayers = #players
    local copsOnline = 0

    for _, src in pairs(players) do
        local player = QBCore.Functions.GetPlayer(src)
        if player and player.PlayerData and player.PlayerData.job then
            local jobName = player.PlayerData.job.name
            if jobName and Config.PoliceJobs[jobName] then
                copsOnline = copsOnline + 1
            end
        end
    end

    return totalPlayers, copsOnline
end

RegisterNetEvent('ls_scoreboard:requestData', function()
    local src = source
    local totalPlayers, copsOnline = GetPlayerCounts()

    TriggerClientEvent('ls_scoreboard:open', src, {
        totalPlayers = totalPlayers,
        copsOnline   = copsOnline
    })
end)
