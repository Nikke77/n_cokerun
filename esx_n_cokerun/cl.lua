

local coords = {
    vec3(-2232.9219, -662.2013, 0.3644),
    vec3(-2299.1240, -559.8216, -0.5151),
    vec3(-2459.4104, -398.0765, -0.8015),
    vec3(-2590.9561, -382.2811, 0.1863),
    vec3(-2697.4487, -306.1260, 0.4318),
}


local options = {
    {  
        name = 'lockpick-boat',
        distance = 3,
        label = 'Tiirikoi',
        icon = 'fa-solid fa-circle',
        items  = 'copper',
        onSelect = function(data)
            exports['ps-ui']:Circle(function(success)
                if success then
                    local coordsTable = {}
                    local vehiclePlates = {}
                    for i = 1, 3 do
                        local randomCoords = math.random(1, #coords)
                        if coordsTable[randomCoords] then goto skipLoop end
                        coordsTable[randomCoords] = coords[math.random(1, #coords)]
                    
                        ::skipLoop::
                    end

                    for k,v in pairs(coordsTable) do 
                        lib.requestModel('glendale', 100)
                        
                        local veh = CreateVehicle('glendale', v, 0.0, true, true)
                        local plate = GetVehicleNumberPlateText(veh)
                        vehiclePlates[#vehiclePlates+1] = plate
                        SetPtfxAssetNextCall("core")
                        StartParticleFxLoopedAtCoord("exp_grd_flare", v, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
                    end
                    TriggerServerEvent('n_cokerun:server:', vehiclePlates)
                    SetVehicleDoorsLocked(data.entity, 1)
                    FreezeEntityPosition(data.entity, false)
                else
                    exports['ps-ui']:Notify('Epäonnistuit', 'error', 20)
                end
            end, 2, 15) 
        end
    }
}



exports.ox_target:addSphereZone({
    coords = vec3(-1200.5886, -266.2412, 37.9129),
    radius = 3,
    debug = drawZones,
    drawSprite = true,
    
    options = {
        {
            name = 'talk-npc',
            distance = 2,
            label = 'Start',
            icon = 'fa-solid fa-circle', 
            onSelect = function()
                
                ESX.TriggerServerCallback("esx_n_cokerun:server:getCooldown", function(isCooldown)
                    if isCooldown then return end
                --TriggerServerEvent('n_cokerun:server:moneycheck
                lib.requestModel('dinghy')
                
                local vehicle = CreateVehicle('dinghy', -1746.5320, -1059.2577, 0.0326, 150.6001, true, false)
                Wait(2000)
                FreezeEntityPosition(vehicle, true)
                SetVehicleDoorsLocked(vehicle, 2)
                exports.ox_target:addLocalEntity(vehicle, options)
            end)
        end
        }
    }
})
CreateThread(function()
	npcModel = GetHashKey("s_m_y_garbage")
	RequestModel(npcModel)
	while not HasModelLoaded(npcModel) do
		Wait(0)
	end
	npc = CreatePed(1, npcModel, -1200.5886, -266.2412, 36.9129, 38.1991, false, true) -- coords of the npc
	SetBlockingOfNonTemporaryEvents(npc, true)
	SetPedDiesWhenInjured(npc, false)
	SetPedCanPlayAmbientAnims(npc, true)
	SetPedCanRagdollFromPlayerImpact(npc, false)
	SetEntityInvincible(npc, true)
	FreezeEntityPosition(npc, true)
	--TaskStartScenarioInPlace(npc, "WORLD_HUMAN_AA_COFFEE", 0, true);
end)