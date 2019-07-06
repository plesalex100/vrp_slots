-- Aceasta resursa a fost facuta de plesalex100#7387
-- Va rog sa o respectati, sa nu o vinde-ti sau postati fara permisiunea mea
-- Aceasta resursa a pornit de la: https://codepen.io/AdrianSandu/pen/MyBQYz


local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_slots")

RegisterServerEvent("ples-slots:catiLeiBagi")
AddEventHandler("ples-slots:catiLeiBagi", function()
  local user_id = vRP.getUserId({source})
  if user_id then
    vRP.prompt({source, "Cati bani bagi ? ( multiplu de 50 ): ", "", function(source, amount)
      amount = parseInt(amount)
      if amount % 50 == 0 and amount >= 50 then
        if vRP.tryPayment({user_id, amount}) then
          TriggerClientEvent("ples-slots:bagXLei", source, amount)
        else
          vRPclient.notify(source, {"~r~Nu ai suficienti bani"})
        end
      else
        vRPclient.notify(source, {"Trebuie sa introduci un multiplu de 50.~n~~y~ex: 100, 350, 2500"})
      end
    end})
  end
end)

RegisterServerEvent("ples-slots:aiCastigat")
AddEventHandler("ples-slots:aiCastigat", function(amount)
  local user_id = vRP.getUserId({source})
  if user_id then
    amount = tonumber(amount)
    if amount > 0 then
      vRP.giveMoney({user_id, amount})
      TriggerClientEvent("chatMessage", source, "^1Pacanele^7: Ai iesit de la pacanele cu ^2$"..amount.."^7 nu e rau deloc!")
    else
      TriggerClientEvent("chatMessage", source, "^1Pacanele^7: Din pacate ^1ai pierdut ^7toti banii, poate data viitoare.")
    end
  end
end)
