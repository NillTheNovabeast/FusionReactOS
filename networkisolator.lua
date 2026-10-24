local component = component
local computer = computer

local modems = {}
for address, ctype in component.list("modem") do
    table.insert(modems, component.proxy(address))
end

if #modems < 2 then
    error("This program requires 2 modems!")
end

local modem1 = modems[1]
local modem2 = modems[2]

local PORT = 500
modem1.open(PORT)
modem2.open(PORT)

while true do
    local e, receiverAddress, senderAddress, port, distance, ...) = computer.pullSignal()
    
    if e == "modem_message" and port == PORT then
        if receiverAddress == modem1.address then
            modem2.broadcast(PORT, ...)
        elseif receiverAddress == modem2.address then
            modem1.broadcast(PORT, ...)
        end
    end
end
