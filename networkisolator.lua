local component = component
local computer = computer

local wired, wireless

for address, ctype in component.list("modem") do
    local proxy = component.proxy(address)
    if proxy.isWireless then
        wireless = proxy
    else
        wired = proxy
    end
end

-- Ellenőrizzük a komponenseket
if not wired or not wireless then
    error("Requires: 1 wireless and 1 wired network card")
end

local PORT = 500
wireless.open(PORT)

while true do
    local e, receiverAddress, senderAddress, port, distance, ...) = computer.pullSignal()
    
    if e == "modem_message" and receiverAddress == wireless.address and port == PORT then
        wired.broadcast(PORT, ...)
    end
end
