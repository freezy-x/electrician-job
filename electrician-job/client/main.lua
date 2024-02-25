ESX = exports["es_extended"]:getSharedObject()

local jobs = {}

local showJobs = false

-- STATION

for k, v in ipairs(Config.Station) do
    -- SPAWNER BLIP --
    local blip = AddBlipForCoord(v.pedcoords)

    SetBlipSprite(blip, 524)
    SetBlipColour(blip, 60)
    SetBlipScale(blip, 0.95)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Electrician Job")
    EndTextCommandSetBlipName(blip)
    
    

    exports.ox_target:addSphereZone({
        coords = v.zone,
        radius = 0.7,
        debug = drawZones,
        options = {
            {
                name = 'jewel-juuttujuttu',
                icon = 'fa fa-user',
                distance = 2,
                label = "To talk",
                onSelect = function()
                    lib.registerContext({
                        id = 'select_menu',
                        title = 'Select Job',
                        onExit = function()
                        end,
                        options = {
                            {
                                title = 'Family House',
                                description = 'burnt cables in the family home',
                                icon = 'fa fa-home',
                                image = 'https://cdn.discordapp.com/attachments/1183421566449627226/1191770926677770340/image.png?ex=65a6a62a&is=6594312a&hm=01bbf4e8716a4f7386256239eba80c5b79c46ea71c863a8673c4a59780883aba&',
                                onSelect = function(args)
                                    lib.hideContext(onExit)
                                    lib.progressBar({
                                        duration = 5000,
                                        label = 'Getting work..',
                                        position = 'bottom',
                                        useWhileDead = false,
                                        canCancel = false,
                                        anim = {
                                            dict = 'misscarsteal4@actor',
                                            clip = 'actor_berating_loop'
                                        },
                                        disable = {
                                            move = true,
                                            car = false
                                        },
                                    })
                                    showJobs = true
                                    works()

                                end, 
                            },
                            {
                                title = 'Apartment Tower',
                                description = 'burnt cables in a luxury apartment building',
                                icon = 'fa fa-building',
                                image = 'https://staticg.sportskeeda.com/editor/2021/12/e91d4-16399441717700-1920.jpg',
                                onSelect = function(args)
                                    lib.hideContext(onExit)
                                    lib.progressBar({
                                        duration = 5000,
                                        label = 'Getting work..',
                                        position = 'bottom',
                                        useWhileDead = false,
                                        canCancel = false,
                                        anim = {
                                            dict = 'misscarsteal4@actor',
                                            clip = 'actor_berating_loop'
                                        },
                                        disable = {
                                            move = true,
                                            car = false
                                        },
                                    })

                                    showJobs = true
                                    works()

                                end, 
                            },
                            {
                                title = 'Restaurant',
                                description = 'Blowing fuses in a Japanese restaurant',
                                icon = 'fa fa-cutlery',
                                image = 'https://cdn.discordapp.com/attachments/1183421566449627226/1191775803130785943/image.png?ex=65a6aab5&is=659435b5&hm=724c93ee4bdd9a61011b3e426a85b9c9c6acb51f3c4e5b07f43a2af4bbe3d5fe&',
                                onSelect = function(args)
                                    lib.hideContext(onExit)
                                    lib.progressBar({
                                        duration = 5000,
                                        label = 'Getting work..',
                                        position = 'bottom',
                                        useWhileDead = false,
                                        canCancel = false,
                                        anim = {
                                            dict = 'misscarsteal4@actor',
                                            clip = 'actor_berating_loop'
                                        },
                                        disable = {
                                            move = true,
                                            car = false
                                        },
                                    })
                                    showJobs = true
                                    works3()

                                end, 
                            },
                            {
                                title = 'Burger Shop',
                                description = 'Burnt fuses in a burger shop',
                                icon = 'fa fa-burger',
                                image = 'https://cdn.discordapp.com/attachments/1180099860817530971/1192190037358563471/image.png?ex=65a82c7e&is=6595b77e&hm=12ef2a5d1c0eac61c97d3bbb7282535e52186a990dc7b2901ad45096205563e3&',
                                onSelect = function(args)
                                    lib.hideContext(onExit)
                                    lib.progressBar({
                                        duration = 5000,
                                        label = 'Getting work..',
                                        position = 'bottom',
                                        useWhileDead = false,
                                        canCancel = false,
                                        anim = {
                                            dict = 'misscarsteal4@actor',
                                            clip = 'actor_berating_loop'
                                        },
                                        disable = {
                                            move = true,
                                            car = false
                                        },
                                    })
                                    showJobs = true
                                    works3()

                                end, 
                            },
                        }
                    })
                    lib.showContext('select_menu')
                end,
            },
            {
                name = 'jewel-juuttujuttu',
                icon = 'fa fa-car',
                distance = 2,
                label = "Rent Vehicle",
                onSelect = function()
                    lib.callback('paycar')
                    ESX.Game.SpawnVehicle(v.carModel, v.spawnPoint, v.heading)
                end,
            }
        },
    })

    -- SPAWNER END --

    -- DELETER BLIP --

    local blip = AddBlipForCoord(v.deletePoint)

    SetBlipSprite(blip, 357)
    SetBlipColour(blip, 60)
    SetBlipScale(blip, 0.5)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Technician Garage")
    EndTextCommandSetBlipName(blip)

    -- DELETER BLIP END --

    -- DELETER --
    local sphere = lib.zones.sphere({
        coords = v.deletePoint,
        radius = 3,
        debug = false,
        inside = function()
            if cache.vehicle then
                if IsControlJustPressed(38, 38) and showJobs then
                    local vehicle = GetVehiclePedIsIn(cache.ped, false)
                    ESX.Game.DeleteVehicle(vehicle)
                    showJobs = false
                    for k, v in ipairs(jobs) do
                        RemoveBlip(v)
                    end
                end
            else
                lib.hideTextUI()
            end
        end,
        onEnter = function()
            if showJobs then
                lib.showTextUI('[E] - Return ')
            end
        end,
        onExit = function()
            lib.hideTextUI()
        end,
    })

    -- DELETER END --

    -- PED --

    lib.RequestModel(v.model)
    ped = CreatePed(1, v.model, v.pedcoords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    -- PED END --
end

function ShowNotification(message, notifyType)
    lib.notify({
        description = message,
        type = notifyType,
        position = 'top'
    })
end

function works2()
    if showJobs then
        for k, v in ipairs(Config.Tower) do
            exports.ox_target:addSphereZone({
                coords = v.coords,
                radius = 0.7,
                debug = drawZones,
                options = {
                    {
                        name = 'jewel-juuttujuttu',
                        icon = 'fa fa-circle',
                        distance = 2,
                        label = "Start work",
                        onSelect = function()
                            local playerPed = PlayerPedId()
                            if IsPedInAnyVehicle(playerPed, true) then return end
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            lib.progressBar({
                                label = "You open the closet",
                                position = 'bottom',
                                duration = 5000,
                                canCancel = false,
                                disable = {
                                    car = true,
                                    move = true
                                }
                            })
                            local result = nil
                            TriggerEvent('Mx::StartMinigameElectricCircuit', '50%', '50%', '1.0', '30vmin', '1.ogg', function()
                                ShowNotification('You can continue working!', 'success')
                                lib.callback('reward')
                            end)
                        end,
                    }
                },
            })
            SetNewWaypoint(v.coords)
        end
    end
end

function works3()
    if showJobs then
        for k, v in ipairs(Config.Restaurant) do
            exports.ox_target:addSphereZone({
                coords = v.coords,
                radius = 0.7,
                debug = drawZones,
                options = {
                    {
                        name = 'jewel-juuttujuttu',
                        icon = 'fa fa-circle',
                        distance = 2,
                        label = "Start work",
                        onSelect = function()
                            local playerPed = PlayerPedId()
                            if IsPedInAnyVehicle(playerPed, true) then return end
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            lib.progressBar({
                                label = "You open the closet",
                                position = 'bottom',
                                duration = 5000,
                                canCancel = false,
                                disable = {
                                    car = true,
                                    move = true
                                }
                            })
                            local result = nil
                            TriggerEvent('Mx::StartMinigameElectricCircuit', '50%', '50%', '1.0', '30vmin', '1.ogg', function()
                                ShowNotification('You can continue working!', 'success')
                                lib.callback('reward')
                            end)
                        end,
                    }
                },
            })
            SetNewWaypoint(v.coords)
        end
    end
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    works3()

end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    works3()
end)
