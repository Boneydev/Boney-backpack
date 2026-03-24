local wearingBackpack = false

local function getBackpackData()
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    if model == `mp_m_freemode_01` then
        return Config.Male
    elseif model == `mp_f_freemode_01` then
        return Config.Female
    end

    return nil
end

local function setBackpackVisual(state)
    local ped = PlayerPedId()
    local data = getBackpackData()

    if not data then
        exports.qbx_core:Notify('This ped model is not supported.', 'error', 5000)
        return
    end

    if state then
        SetPedComponentVariation(ped, Config.ComponentId, data.drawable, data.texture, 0)
        wearingBackpack = true
    else
        SetPedComponentVariation(ped, Config.ComponentId, Config.Remove.drawable, Config.Remove.texture, 0)
        wearingBackpack = false
    end
end
RegisterNetEvent('Boney-backpack:client:useItem', function()
    TriggerServerEvent('Boney-backpack:server:open')
end)

RegisterNetEvent('Boney-backpack:client:openStash', function(stashId)
    if not wearingBackpack then
        setBackpackVisual(true)
    end

    exports.ox_inventory:openInventory('stash', stashId)
end)

RegisterCommand('removebag', function()
    setBackpackVisual(false)
    exports.qbx_core:Notify('Backpack removed.', 'primary', 5000)
end, false)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    print('^2[Boney-backpack]^7 Client loaded | Author: Boney')
end)