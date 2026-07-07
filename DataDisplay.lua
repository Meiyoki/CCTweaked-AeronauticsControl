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
local displays = {peripheral.find("monitor")}
table.sort(displays, function(left,right) 
  return left.getSize() < right.getSize()
)
local largeDisplay = displays[2]
local smallDisplay = displays[1]

while true do
  largeDisplay.clear()
  largeDisplay.setCursorPos(1,1)
  smallDisplay.clear()
  smallDisplay.setCursorPos(1,1)
  largeDisplay.write("Altitude Thrust: " .. throttleSensor.getAnalogueInput("back"))
  largeDisplay.write("Altitude Reverse: " .. throttleSensor.getAnalogueInput("top"))
  largeDisplay.write("Forward Thrust: " .. forward.getAnalogueInput("front"))
  largeDisplay.write("Backward Thrust: " .. backSensor.getAnalogueInput("back"))
  largeDisplay.write("Left Thrust: " .. leftSensor.getAnalogueInput("left"))
  largeDisplay.write("Right Thrust: " .. rightSensor.getAnalogueInput("right"))
  smallDisplay.write("Altitude: " .. altimeter.getHeight())
  smallDisplay.write("Angles: " .. (math.floor(gyro.getAngles()[1]*10^4)/10^4) .. ", " .. (math.floor(gyro.getAngles()[2]*10^4)/10^4))
  sleep(0.5)
end
