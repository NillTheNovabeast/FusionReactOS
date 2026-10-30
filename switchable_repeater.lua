local in1 = 1
local out = 2

local e = computer
local m = component.proxy(component.list("modem")())
local r = component.proxy(component.list("redstone")())

m.open(in1)
m.open(out)

while true do
  local ev, _, _, port, _, data = e.pullSignal()
  if ev == "modem_message" and (port == in1 or port == in2) then
    if port == in1 then
      msg1 = tostring(data)
      if r.getInput(4) > 0 then
        m.broadcast(out, msg1)
      end
    end
  end
end
