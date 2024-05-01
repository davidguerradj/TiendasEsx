ESX = nil


TriggerEvent('esx:getServerObject', function(obj) 
    ESX = obj 
end)

RegisterNetEvent('tiendas:nombreTienda')
AddEventHandler('tiendas:nombreTienda', function(nombreTienda)
    local _source = source

    local x, y, z  -- Obtener la ubicación de la tienda, puede variar dependiendo de tu implementación
    local dueno = "Sin dueño"  -- Obtener el dueño de la tienda, puede variar dependiendo de tu implementación
    local fondos  = "0"  -- Obtener los fondos de la tienda, puede variar dependiendo de tu implementación

    -- Insertar los datos en la base de datos
    GuardarTienda(x, y, z, nombreTienda, dueno, fondos)
end)

function GuardarTienda(x, y, z, nombre, dueno, fondos)
    MySQL.Async.execute('INSERT INTO tiendas (ubicacion, nombre, dueno, fondos) VALUES (@ubicacion, @nombre, @dueno, @fondos)', {
        ['@ubicacion'] = json.encode({x = x, y = y, z = z}),
        ['@nombre'] = nombre,
        ['@dueno'] = dueno,
        ['@fondos'] = fondos
    }, function(rowsChanged)
        print(rowsChanged .. ' fila(s) insertada(s)')
    end)
end


RegisterCommand('creartienda', function(source, args, rawCommand)
    print("Comando creartienda ejecutado desde el servidor") 
    local player = source
    TriggerClientEvent('tiendas:solicitarNombre', player)
end, false)

RegisterNetEvent('tiendas:getTiendas')
AddEventHandler('tiendas:getTiendas', function()
    TriggerClientEvent('tiendas:recibirTiendas', -1, tiendas)
end)

RegisterNetEvent('tiendas:solicitarNombre')
AddEventHandler('tiendas:solicitarNombre', function()
    local ped = source
    print("Evento tiendas:solicitarNombre activado en el servidor") -- Agrega este print para verificar si el evento se está activando correctamente en el servidor

    -- Aquí puedes agregar la lógica para solicitar el nombre al jugador
    -- Por ejemplo, puedes enviar un mensaje al cliente para que muestre un teclado en pantalla o un menú para ingresar el nombre
    -- Puedes usar TriggerClientEvent para enviar un mensaje al cliente y que maneje la lógica correspondiente para solicitar el nombre
    -- Ejemplo:
    TriggerClientEvent('tiendas:solicitarNombre', ped)
end)


