signs = {'Road Work Ahead', '<<<','>>>','Drive Safetly','Left Lane Closed','Accident Ahead','Click It or Ticket','Detour Ahead','Slow Moving Traffic','Right Lane Closed','Keep Left','Keep Right'}

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/trrotate', 'Rotate trailer\'s sign')

    for i = 1, #signs do
        TriggerEvent('chat:addSuggestion', '/trsign' .. i, 'Turn on trailer\'s sign ' .. i .. ' (' .. signs[i] .. ')')
    end
    
    TriggerEvent('chat:addSuggestion', '/trsignon', 'Turn on trailer\'s sign')
    TriggerEvent('chat:addSuggestion', '/trsignoff', 'Turn off trailer\'s sign')
    TriggerEvent('chat:addSuggestion', '/trattach', 'Attach vehicle to trailer')
end)

function Notify(Text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(Text)
    DrawNotification(true, true)
end

function GetTrailer()
    local fromEntity = GetPlayerPed(-1)
    local from = GetEntityCoords(fromEntity)
    from = GetOffsetFromEntityInWorldCoords(fromEntity, 0.0, 0.0, -0.5)
    local multiplier = 1.0

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        fromEntity = GetVehiclePedIsIn(PlayerPedId(), false)
        from = GetEntityCoords(fromEntity)
        multiplier = -1.0
    end

    local xCoordsToCheck = {0.0, 1.5, -1.5, 3.0, -3.0, 4.0, -4.0, 5.0, -5.0}

    for i = 1, #xCoordsToCheck do
        local to = GetOffsetFromEntityInWorldCoords(fromEntity, xCoordsToCheck[i], 10.0 * multiplier, 0)
        local rayHandle = CastRayPointToPoint(from.x, from.y, from.z, to.x, to.y, to.z, 3, GetPlayerPed(-1), 0)
        local _, _, _, _, trailer = GetRaycastResult(rayHandle)
        if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
            return trailer
        end
    end

    Notify('~h~~r~Trailer not found!~h~~n~~w~Try to reposition yourself near the trailer at a different angle.')
    return nil
end

function SetExtraOn(trailer, num)
    local openTrunkAfterExtra = false

    if GetVehicleDoorAngleRatio(trailer, 5) > 0 then
        openTrunkAfterExtra = true
    end

    for i = 1, 12 do
        SetVehicleExtra(trailer, i, true)
    end

    SetVehicleExtra(trailer, num, false)

    if openTrunkAfterExtra then
        SetVehicleDoorOpen(trailer, 5, false, false)
    end

    SetVehicleSiren(trailer, true)
end

RegisterCommand('trrotate', function(source, args, rawCommands)
    local trailer = GetTrailer()

    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        if GetVehicleDoorAngleRatio(trailer, 5) > 0 then
            SetVehicleDoorShut(trailer, 5, false)
        else
            SetVehicleDoorOpen(trailer, 5, false, false)
        end
    end
end)

RegisterCommand('trsignon', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetVehicleSiren(trailer, true)
    end
end)

RegisterCommand('trsignoff', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetVehicleSiren(trailer, false)
    end
end)

RegisterCommand('trattach', function(source, args, rawCommands)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        local trailer = GetTrailer()
        if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
            AttachVehicleToTrailer(veh, trailer, 1.0)
        end
    end
end)

for i = 1, #signs do
    RegisterCommand('trsign' .. i, function(source, args, rawCommands)
        local trailer = GetTrailer()
        if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
            SetExtraOn(trailer, i)
        end
    end)
end
