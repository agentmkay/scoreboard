Config = {}

-- Title & position of the scoreboard menu
Config.MenuTitle    = 'Server Scoreboard'
Config.MenuPosition = 'top-right'  -- 'top-left', 'top-right', 'offcenter-left', 'offcenter-right'

-- Jobs that count as "police"
Config.PoliceJobs = {
    ['police']  = true,
    ['sheriff'] = true,
    ['state']   = true,
    -- add/remove as you need
}

-- Activities that require X cops online
-- label = what shows in the menu
-- requiredCops = how many police must be online
Config.Activities = {
    { label = 'Fleeca Bank Robbery',       requiredCops = 4 },
    { label = 'Pacific Bank Heist',        requiredCops = 6 },
    { label = 'Jewellery Store Robbery',   requiredCops = 3 },
    { label = 'Store Robbery',             requiredCops = 2 },
}
