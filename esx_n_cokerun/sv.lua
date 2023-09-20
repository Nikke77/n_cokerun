local function startCooldown(source)
    if Config.GlobalCooldown and GlobalState.isCooldown or not Config.GlobalCooldown and Player(source).state.isCooldown then return end 

    if Config.GlobalCooldown then 
        GlobalState.isCooldown = true 
    else 
        Player(source).state.isCooldown = true 
    end

    SetTimeout(Config.Cooldown * 60000, function()
        if Config.GlobalCooldown then 
            GlobalState.isCooldown = false 
        else 
            Player(source).state.isCooldown = false
        end
    end)
end

local function getCooldown(source)
    if Config.GlobalCooldown and GlobalState.isCooldown then 
        return true 
    end

    if not Config.GlobalCooldown and Player(source).state.isCooldown then 
        return true 
    end

    return false
end

ESX.RegisterServerCallback("esx_n_cokerun:server:getCooldown", function(source, cb)
    local isCooldown = getCooldown(source)
    local source = source
    if isCooldown then
        lib.notify(source, {
            title = 'Cooldown'
        }) return cb(true) end

    startCooldown(source)
    cb(false)
end)

RegisterNetEvent('n_cokerun:server:', function(vehiclePlates)
        for _, plate in pairs(vehiclePlates) do 
        exports.ox_inventory:AddItem("trunk"..plate, 'cocaine', math.random(5, 25))
    end
end)



