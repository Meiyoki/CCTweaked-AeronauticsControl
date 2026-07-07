local wirelessNIC = peripheral.find("modem", function(name, modem)
    return modem.isWireless()
end)
wirelessNIC.open(2000)
local components = 
{
  ["fore"] = 0,
  ["starboard"] = 0,
  ["aft"] = 0,
  ["port"] = 0,
  ["vertical"] = 0,
}
settings.define("registrations.thrusters", {
    description = "Thruster numbers for each grouping",
    default = components,
    type = "table",
})

while true do
  eventData = os.pullEvent("modem_message")
  if eventData[3] == 2000 then
    local registration = eventData[5]
    for k,v in pairs(registration) do
      components[k] = v
    end
    settings.set("registrations.thrusters", components)
    settings.save()
  end
end
