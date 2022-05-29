Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/trrotate', 'Rotate trailer\'s sign')
    TriggerEvent('chat:addSuggestion', '/trsign1', 'Turn on trailer\'s sign 1 (Road Work Ahead)')
    TriggerEvent('chat:addSuggestion', '/trsign2', 'Turn on trailer\'s sign 2 (<<<)')
    TriggerEvent('chat:addSuggestion', '/trsign3', 'Turn on trailer\'s sign 3 (>>>)')
    TriggerEvent('chat:addSuggestion', '/trsign4', 'Turn on trailer\'s sign 4 (Drive Safely)')
    TriggerEvent('chat:addSuggestion', '/trsign5', 'Turn on trailer\'s sign 5 (Left Lane Closed)')
    TriggerEvent('chat:addSuggestion', '/trsign6', 'Turn on trailer\'s sign 6 (Accident Ahead)')
    TriggerEvent('chat:addSuggestion', '/trsign7', 'Turn on trailer\'s sign 7 (Click It or Ticket)')
    TriggerEvent('chat:addSuggestion', '/trsign8', 'Turn on trailer\'s sign 8 (Detour Ahead)')
    TriggerEvent('chat:addSuggestion', '/trsign9', 'Turn on trailer\'s sign 9 (Slow Moving Traffic)')
    TriggerEvent('chat:addSuggestion', '/trsign10', 'Turn on trailer\'s sign 10 (Right Lane Closed)')
    TriggerEvent('chat:addSuggestion', '/trsign11', 'Turn on trailer\'s sign 11 (Keep Left)')
    TriggerEvent('chat:addSuggestion', '/trsign12', 'Turn on trailer\'s sign 12 (Keep Right)')
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

    local to = GetOffsetFromEntityInWorldCoords(fromEntity, 0.0, 30.0 * multiplier, 0)
    local rayHandle = CastRayPointToPoint(from.x, from.y, from.z, to.x, to.y, to.z, 3, GetPlayerPed(-1), 0)
    local _, _, _, _, trailer = GetRaycastResult(rayHandle)
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        return trailer
    end

    to = GetOffsetFromEntityInWorldCoords(fromEntity, 3.0, 30.0 * multiplier, 0)
    rayHandle = CastRayPointToPoint(from.x, from.y, from.z, to.x, to.y, to.z, 3, GetPlayerPed(-1), 0)
    _, _, _, _, trailer = GetRaycastResult(rayHandle)
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        return trailer
    end

    to = GetOffsetFromEntityInWorldCoords(fromEntity, -3.0, 30.0 * multiplier, 0)
    rayHandle = CastRayPointToPoint(from.x, from.y, from.z, to.x, to.y, to.z, 3, GetPlayerPed(-1), 0)
    _, _, _, _, trailer = GetRaycastResult(rayHandle)
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        return trailer
    end

    to = GetOffsetFromEntityInWorldCoords(fromEntity, 5.0, 30.0 * multiplier, 0)
    rayHandle = CastRayPointToPoint(from.x, from.y, from.z, to.x, to.y, to.z, 3, GetPlayerPed(-1), 0)
    _, _, _, _, trailer = GetRaycastResult(rayHandle)
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        return trailer
    end

    to = GetOffsetFromEntityInWorldCoords(fromEntity, -5.0, 30.0 * multiplier, 0)
    rayHandle = CastRayPointToPoint(from.x, from.y, from.z, to.x, to.y, to.z, 3, GetPlayerPed(-1), 0)
    _, _, _, _, trailer = GetRaycastResult(rayHandle)
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        return trailer
    end
end

function SetExtraOn(trailer, num)
    local openTrunk = false

    if GetVehicleDoorAngleRatio(trailer, 5) > 0 then
        openTrunk = true
    end

    SetVehicleExtra(trailer, 1, true)
    SetVehicleExtra(trailer, 2, true)
    SetVehicleExtra(trailer, 3, true)
    SetVehicleExtra(trailer, 4, true)
    SetVehicleExtra(trailer, 5, true)
    SetVehicleExtra(trailer, 6, true)
    SetVehicleExtra(trailer, 7, true)
    SetVehicleExtra(trailer, 8, true)
    SetVehicleExtra(trailer, 9, true)
    SetVehicleExtra(trailer, 10, true)
    SetVehicleExtra(trailer, 11, true)
    SetVehicleExtra(trailer, 12, true)

    SetVehicleExtra(trailer, num, false)

    if openTrunk then
        SetVehicleDoorOpen(trailer, 5, false, false)
    end
end

RegisterCommand('trrotate', function(source, args, rawCommands)
    local trailer = GetTrailer()

    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        if GetVehicleDoorAngleRatio(trailer, 5) > 0 then
            SetVehicleDoorShut(trailer, 5, false)
        else
            SetVehicleDoorOpen(trailer, 5, false, false)
        end
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign1', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 1)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign2', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 2)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign3', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 3)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign4', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 4)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign5', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 5)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign6', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 6)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign7', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 7)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign8', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 8)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign9', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 9)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign10', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 10)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign11', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 11)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsign12', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetExtraOn(trailer, 12)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsignon', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetVehicleSiren(trailer, true)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trsignoff', function(source, args, rawCommands)
    local trailer = GetTrailer()
    if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
        SetVehicleSiren(trailer, false)
    else
        Notify('~r~Trailer not found!')
    end
end)

RegisterCommand('trattach', function(source, args, rawCommands)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        local trailer = GetTrailer()
        if trailer ~= nil and trailer ~= 0 and trailer ~= 1 then
            AttachVehicleToTrailer(veh, trailer, 1.0)
        else
            Notify('~r~Trailer not found!')
        end
    end
end)