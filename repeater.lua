local in1 = 454
local out = 500

local e = computer
local m = component.proxy(component.list("modem")())

m.open(in1)
m.open(out)

while true do
  local ev, _, _, port, _, data = e.pullSignal()
  if ev == "modem_message" and (port == in1 or port == in2) then
    if port == in1 then
      msg1 = tostring(data)
      m.broadcast(out, msg1)
    end
  end
end
