local wiredNIC = peripheral.find("modem, function(name, modem)
    return !modem.isWireless()
)
local wirelessNIC = peripheral.find("modem, function(name, modem)
    return !modem.isWireless()
)
local relays = {peripheral.find("redstone_relay")}
local forwardSensor = relays[1]
local rightSensor = relays[2]
local backSensor = relays[3]
local leftSensor = relays[4]
local throttleSensor = relays[5]
local altimeter = peripheral.wrap("top")
local gyro = peripheral.find("gimbal_sensor")
