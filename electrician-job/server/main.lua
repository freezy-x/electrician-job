ESX = exports["es_extended"]:getSharedObject()

lib.callback.register('reward', function ()
    local ped = ESX.GetPlayerFromId(source)
    local reward = math.random(Config.RewardMin, Config.RewardMax)

    exports.ox_inventory:AddItem(ped.source, 'money', reward)
end)

lib.callback.register('paycar', function ()
    local ped = ESX.GetPlayerFromId(source)

    exports.ox_inventory:RemoveItem(ped.source, 'money', Config.CarPrice)
end)