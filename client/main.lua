ESX = nil

TriggerEvent('esx:getServerObject', function(obj) 
    ESX = obj 
end)

RegisterCommand('creartienda', function()
    print("Comando creartienda ejecutado desde el cliente") 
    TriggerServerEvent('tiendas:solicitarNombre')
end, false)

RegisterNetEvent('tiendas:recibirTiendas')
AddEventHandler('tiendas:recibirTiendas', function(tiendas)
    -- Manejar las tiendas recibidas del servidor
end)

RegisterNetEvent('tiendas:solicitarNombre')
AddEventHandler('tiendas:solicitarNombre', function()
    print("Evento tiendas:solicitarNombre recibido en el cliente") -- Verifica si el evento se está recibiendo correctamente en el cliente
    
    -- Función para mostrar el cuadro de texto y capturar el nombre de la tienda
    local nombreTienda = SolicitarNombreTienda()

    -- Si se ingresó un nombre de tienda, envíalo al servidor
    if nombreTienda then
        TriggerServerEvent('tiendas:nombreTienda', nombreTienda)
    else
        TriggerEvent('chat:addMessage', { args = { '^1ERROR:', 'Debes introducir un nombre para la tienda.' } })
    end
end)

-- Función para mostrar el cuadro de texto y capturar el nombre de la tienda
function SolicitarNombreTienda()
    local nombreTienda = nil

    -- Configurar el cuadro de texto
    AddTextEntry("FMMC_KEY_TIP1", "Introduce el nombre de la tienda:")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 30) 

    -- Esperar a que el jugador ingrese el nombre
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    -- Verificar si se ingresó un nombre y retornarlo
    if UpdateOnscreenKeyboard() ~= 2 then
        nombreTienda = GetOnscreenKeyboardResult()
        return nombreTienda ~= "" and nombreTienda or nil
    else
        return nil
    end
end

RegisterNetEvent('tiendas:crearMarker')
AddEventHandler('tiendas:crearMarker', function(x, y, z, nombre)
    local marker = AddBlipForCoord(x, y, z)
    SetBlipSprite(marker, 52)
    SetBlipColour(marker, 2)
    SetBlipScale(marker, 1.0)
    SetBlipAsShortRange(marker, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(nombre)
    EndTextCommandSetBlipName(marker)
end)
