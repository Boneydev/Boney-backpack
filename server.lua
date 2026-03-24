local function getBackpackStashId(source)
    local identifier = GetPlayerIdentifierByType(source, 'license') or ('src_' .. source)
    identifier = identifier:gsub(':', '_')
    return 'boney_backpack_' .. identifier
end

local function registerPlayerBackpack(source)
    local stashId = getBackpackStashId(source)

    exports.ox_inventory:RegisterStash(
        stashId,
        'Boney Backpack',
        Config.StashSlots,
        Config.StashWeight,
        false
    )

    return stashId
end

local function openBackpack(source)
    local stashId = registerPlayerBackpack(source)
    TriggerClientEvent('Boney-backpack:client:openStash', source, stashId)
end

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    print('^5[Boney-backpack]^7 Loaded successfully | Author: Boney')
end)
RegisterNetEvent('Boney-backpack:server:open', function()
    local src = source
    local stashId = registerPlayerBackpack(src)
    TriggerClientEvent('Boney-backpack:client:openStash', src, stashId)
end)
RegisterCommand('testbag', function(source)
    if source == 0 then return end
    openBackpack(source)
end, false)

exports(Config.ItemName, function(event, item, inventory, slot, data)
    if event ~= 'usingItem' then return end

    local src = inventory.id
    openBackpack(src)

    return false
end)