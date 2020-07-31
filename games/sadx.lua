package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.dolphin = nil
local dolphin = require 'dolphin'

local MyGame = subclass(dolphin.DolphinGame)

MyGame.supportedGameVersions = {
  na = 'GXSE8P',
}

MyGame.layoutModuleNames = {'sadx_layouts'}
MyGame.framerate = 60

function MyGame:init(options)
  dolphin.DolphinGame.init(self, options)

  self.startAddress = self:getGameStartAddress()
end

function MyGame:updateAddresses()
  local pointerChar1 = self.startAddress + 0x7A82A0
  local pointerChar2 = self.startAddress + 0x7A8280
  local pointerChar3 = self.startAddress + 0x7A8260
  local pointerChar4 = self.startAddress + 0x7A8240
  local pointerCamera = self.startAddress + 0x6B44B0

  if pointerChar1 == 0 then
	self.pointerChar1Value = nil
  else
	self.pointerChar1Value = self.startAddress + utils.readIntBE(pointerChar1) - 0x80000000
  end
  
  if pointerChar2 == 0 then
	self.pointerChar2Value = nil
  else
	self.pointerChar2Value = self.startAddress + utils.readIntBE(pointerChar2) - 0x80000000
  end
  
  if pointerChar3 == 0 then
	self.pointerChar3Value = nil
  else
	self.pointerChar3Value = self.startAddress + utils.readIntBE(pointerChar3) - 0x80000000
  end
  
  if pointerChar4 == 0 then
	self.pointerChar4Value = nil
  else
	self.pointerChar4Value = self.startAddress + utils.readIntBE(pointerChar4) - 0x80000000
  end
  
  if pointerCamera == 0 then
  self.pointerCameraValue = nil
  else
  self.pointerCameraValue = self.startAddress + utils.readIntBE(pointerCamera) - 0x80000000
  end
end


local valuetypes = require "valuetypes"
local V = valuetypes.V
local GV = MyGame.blockValues
local MV = valuetypes.MV
local Block = valuetypes.Block
local Value = valuetypes.Value
local FloatType = valuetypes.FloatTypeBE
local IntType = valuetypes.IntTypeBE
local ByteType = valuetypes.ByteType
local ShortType = valuetypes.ShortTypeBE
local BinaryType = valuetypes.BinaryType

package.loaded.layouts = nil
local layoutsModule = require 'layouts'

local StaticValue = subclass(valuetypes.MemoryValue)
function StaticValue:getAddress()
  return self.game.startAddress + self.offset
end

local PointerBasedChar1Value = subclass(valuetypes.MemoryValue)
function PointerBasedChar1Value:getAddress()
  return self.game.pointerChar1Value + self.offset
end

local PointerBasedChar2Value = subclass(valuetypes.MemoryValue)
function PointerBasedChar2Value:getAddress()
  return self.game.pointerChar2Value + self.offset
end

local PointerBasedChar3Value = subclass(valuetypes.MemoryValue)
function PointerBasedChar3Value:getAddress()
  return self.game.pointerChar3Value + self.offset
end

local PointerBasedChar4Value = subclass(valuetypes.MemoryValue)
function PointerBasedChar4Value:getAddress()
  return self.game.pointerChar4Value + self.offset
end

local PointerBasedCameraValue = subclass(valuetypes.MemoryValue)
function PointerBasedCameraValue:getAddress()
  return self.game.pointerCameraValue + self.offset
end

-- Game addresses

GV.piece1 = MV("Piece 1", 0x841C5B, StaticValue, ByteType)
GV.piece2 = MV("Piece 2", 0x841C83, StaticValue, ByteType)
GV.piece3 = MV("Piece 3", 0x841CAB, StaticValue, ByteType)

GV.xPos = MV(
  "XPos", 0x20, PointerBasedChar2Value, FloatType)
GV.yPos = MV(
  "YPos", 0x24, PointerBasedChar2Value, FloatType)
GV.zPos = MV(
  "ZPos", 0x28, PointerBasedChar2Value, FloatType)

GV.xRot = MV(
  "XRot", 0x16, PointerBasedChar2Value, ShortType)
GV.yRot = MV(
  "YRot", 0x1A, PointerBasedChar2Value, ShortType)
GV.zRot = MV(
  "ZRot", 0x1E, PointerBasedChar2Value, ShortType)
  
GV.xSpd = MV(
  "XSpd", 0x4, PointerBasedChar3Value, FloatType)
GV.ySpd = MV(
  "YSpd", 0x8, PointerBasedChar3Value, FloatType)
GV.zSpd = MV(
  "ZSpd", 0xC, PointerBasedChar3Value, FloatType)
  
GV.xfRot = MV(
  "XFinalRot", 0x1E, PointerBasedChar3Value, ShortType)
GV.yfRot = MV(
  "YFinalRot", 0x22, PointerBasedChar3Value, ShortType)
GV.zfRot = MV(
  "ZFinalRot", 0x26, PointerBasedChar3Value, ShortType)
  
GV.stSpeed = MV(
  "StSpeed", 0x0, PointerBasedChar4Value, FloatType)
GV.fSpeed = MV(
  "FSpeed", 0x38, PointerBasedChar4Value, FloatType)
GV.vSpeed = MV(
  "VSpeed", 0x3C, PointerBasedChar4Value, FloatType)
GV.sdSpeed = MV(
  "SideSpeed", 0x40, PointerBasedChar4Value, FloatType)

GV.xTilt = MV(
  "XTilt", 0x50, PointerBasedChar4Value, FloatType)
GV.yTilt = MV(
  "YTilt", 0x54, PointerBasedChar4Value, FloatType)
GV.zTilt = MV(
  "ZTilt", 0x58, PointerBasedChar4Value, FloatType)
  
GV.action = MV(
  "ActionNumber", 0x0, PointerBasedChar2Value, ByteType)
GV.hover = MV(
  "HoverTimer", 0x8, PointerBasedChar4Value, ShortType)

GV.hoverLimit = MV(
  "HoverLimit", 0x9C, PointerBasedChar4Value, IntType)

GV.character = MV(
  "CharacterID", 0x9, PointerBasedChar2Value, ByteType)

GV.flightMeter = MV(
  "FlightMeter", 0x98, PointerBasedChar4Value, FloatType)

GV.rngState = MV(
  "RNG State", 0xC3E90, StaticValue, IntType)
  
-- Camera

GV.cameraXPos = MV(
  "camera XPos", 0x20, PointerBasedCameraValue, FloatType)
GV.cameraYPos = MV(
  "camera YPos", 0x24, PointerBasedCameraValue, FloatType)
GV.cameraZPos = MV(
  "camera ZPos", 0x28, PointerBasedCameraValue, FloatType)

GV.cameraXRot = MV(
  "Camera XRot", 0x16, PointerBasedCameraValue, ShortType)
GV.cameraYRot = MV(
  "Camera YRot", 0x1A, PointerBasedCameraValue, ShortType)
GV.cameraZRot = MV(
  "Camera ZRot", 0x1E, PointerBasedCameraValue, ShortType)

-- Inputs

GV.ABXYS = MV("ABXY & Start", 0xA6CE0,
  StaticValue, BinaryType, {binarySize=8, binaryStartBit=7})
GV.DZ = MV("D-Pad & Z", 0xA6CE1,
  StaticValue, BinaryType, {binarySize=8, binaryStartBit=7})

GV.analogAngle = MV(
  "AnalogAngle", 0x74CA92, StaticValue, ShortType)
GV.analogMagnitude = MV(
  "AnalogMagnitude", 0x74CA94, StaticValue, FloatType)
  
GV.stickX =
  MV("X Stick", 0xA6CE2, StaticValue, ByteType)
GV.stickY =
  MV("Y Stick", 0xA6CE3, StaticValue, ByteType)
GV.xCStick =
  MV("X C-Stick", 0xA6CE4, StaticValue, ByteType)
GV.yCStick =
  MV("Y C-Stick", 0xA6CE5, StaticValue, ByteType)
GV.lShoulder =
  MV("L Shoulder", 0xA6CE6, StaticValue, ByteType)
GV.rShoulder =
  MV("R Shoulder", 0xA6CE7, StaticValue, ByteType)

-- Time

GV.frameCounter = 
  MV("Frames Counter", 0x74C7A0, StaticValue, IntType)
GV.centiseconds =
  MV("Centiseconds", 0x74C7AA, StaticValue, ByteType)
GV.seconds =
  MV("Seconds", 0x74C7AB, StaticValue, ByteType)
GV.minutes =
  MV("Minutes", 0x74C7AC, StaticValue, ByteType)
  

-- Screen display functions

function MyGame:displayValues()

  if utils.readIntBE(self.startAddress + 0x7A82A0) == 0 then
    return {
      ['Time'] = '',
      ['FSpd'] = '',
      ['VSpd'] = '',
      ['StSpd'] = '',
      ['XSpd'] = '',
      ['YSpd'] = '',
      ['ZSpd'] = '',
      ['XPos'] = '',
      ['YPos'] = '',
      ['ZPos'] = '',
      ['XRot'] = '',
      ['YRot'] = '',
      ['ZRot'] = '',
      ['Hover'] = '',
      ['Action'] = '',
      ['RNG'] = '',
      ['Flight'] = '',
      ['AnalogAngle'] = '',
      ['AnalogMagnitude'] = ''
    }
  end

  local frames = self.frameCounter:get()
  local centi = math.floor(self.centiseconds:get() * (100/60))
  local sec = self.seconds:get()
  local minu = self.minutes:get()

  local stspd = ''
  local rng = ''

  if self.character:get() == 0 then
    stspd = string.format("%7.4f", self.stSpeed:get())
  end

  if self.character:get() == 3 then
    rng = string.format("0x%08X", self.rngState:get())
  end

  local hover = self.hover:get()

  if hover > self.hoverLimit:get() then
    hover = self.hoverLimit:get()
  end

  local flight = ''

  if self.character:get() == 2 then
    flight = string.format("%3d/120", math.floor(self.flightMeter:get() * 120 + 0.5))
  end

  return {
    ['Time'] = string.format("%02d:%02d:%02d - %05d", minu, sec, centi, frames),
    ['FSpd'] = string.format("%7.4f", self.fSpeed:get()),
    ['VSpd'] = string.format("%7.4f", self.vSpeed:get()),
    ['XSpd'] = string.format("%7.4f", self.xSpd:get()),
    ['YSpd'] = string.format("%7.4f", self.ySpd:get()),
    ['ZSpd'] = string.format("%7.4f", self.zSpd:get()),
    ['XPos'] = string.format("%11.4f", self.xPos:get()),
    ['YPos'] = string.format("%11.4f", self.yPos:get()),
    ['ZPos'] = string.format("%11.4f", self.zPos:get()),
    ['XRot'] = string.format("%5.1fd", self.xRot:get() * 360 / 65536),
    ['YRot'] = string.format("%5.1fd", self.yRot:get() * 360 / 65536),
    ['ZRot'] = string.format("%5.1fd", self.zRot:get() * 360 / 65536),
    ['Hover'] = string.format("%2d/%2d", hover, self.hoverLimit:get()),
    ['Action'] = string.format("%2d", self.action:get()),
    ['StSpd'] = stspd,
    ['RNG'] = rng,
    ['Flight'] = flight,
    ['AnalogAngle'] = string.format("%5.1fd", self.analogAngle:get()),
    ['AnalogMagnitude'] = string.format("%6.4f", self.analogMagnitude:get())
  }

end

local prevCameraYRot = 0
local currCameraYRot = 0

function MyGame:displayAnalogAngle()

  prevCameraYRot = currCameraYRot
  currCameraYRot = self.cameraYRot:get()

  local anaAngle

  if self.analogMagnitude:get() == 0 then
    anaAngle = 0
  else
    anaAngle = ((self.analogAngle:get() + prevCameraYRot) % 65536) * 360 / 65536
  end

  return string.format("%5.1fd", anaAngle)

end

function MyGame:displaySpeed()
  local stspd = self.stSpeed:get()
  local fspd = self.fSpeed:get()
  local vspd = self.vSpeed:get()
  local xspd = self.xSpd:get()
  local yspd = self.ySpd:get()
  local zspd = self.zSpd:get()
  return string.format("Speed\n  F: %.4f\tX: %.4f\n  V: %.4f\tY: %.4f\n  S: %.4f\tZ: %.4f\n", fspd, xspd, vspd, yspd, stspd, zspd)
end

function MyGame:displayRotation()
  local xrot = self.xRot:get()
  local yrot = self.yRot:get()
  local zrot = self.zRot:get()
  local xrotdeg = xrot * 360 / 65536
  local yrotdeg = yrot * 360 / 65536
  local zrotdeg = zrot * 360 / 65536
  return string.format("Rotation\n  X: %05d | %3.2f°\n  Y: %05d | %3.2f°\n  Z: %05d | %3.2f°\n", xrot, xrotdeg, yrot, yrotdeg, zrot, zrotdeg)
end

function MyGame:displayPosition()
  local xpos = self.xPos:get()
  local ypos = self.yPos:get()
  local zpos = self.zPos:get()
  return string.format("Position\n  X: %5.4f\n  Y: %5.4f\n  Z: %5.4f\n", xpos, ypos, zpos)
end

function MyGame:displayTime()
  local centiFrames = self.centiseconds:get()
  local secs = self.seconds:get()
  local mins = self.minutes:get()
  
  local centi = math.floor(centiFrames * (100/60))
  
  return string.format("  %02d:%02d:%02d\n", mins, secs, centi)
end

function MyGame:displayMisc()
  local hvr = self.hover:get()
  local actn = self.action:get()
  return string.format("Misc\n  Hover: %d\n  Action Number: %d\n", hvr, actn)
end

function MyGame:displaySpeedSmall()
  if utils.readIntBE(self.startAddress + 0x7A82A0) == 0 then
	return string.format("")
  end
  
  local stspd = self.stSpeed:get()
  local sdspd = self.sdSpeed:get()
  local fspd = self.fSpeed:get()
  local vspd = self.vSpeed:get()
  local xspd = self.xSpd:get()
  local yspd = self.ySpd:get()
  local zspd = self.zSpd:get()
  
  return string.format("Speed\n  Fw:%8.3f   X: %8.3f\n  Vt:%8.3f   Y: %8.3f\n  St:%8.3f   Z: %8.3f\n  Sd:%8.3f\n", fspd, xspd, vspd, yspd, stspd, zspd, sdspd)
end

function MyGame:displayRotationSmall()
  if utils.readIntBE(self.startAddress + 0x7A82A0) == 0 then
	return string.format("")
  end
  
  local xrot = self.xRot:get()
  local yrot = self.yRot:get()
  local zrot = self.zRot:get()
  local xrotdeg = xrot * 360 / 65536
  local yrotdeg = yrot * 360 / 65536
  local zrotdeg = zrot * 360 / 65536
  
  local xfrot = self.xfRot:get()
  local yfrot = self.yfRot:get()
  local zfrot = self.zfRot:get()
  local xfrotdeg = xfrot * 360 / 65536
  local yfrotdeg = yfrot * 360 / 65536
  local zfrotdeg = zfrot * 360 / 65536
  
  return string.format("Rotation\n      Current    Final\n  X:  %6.2f°    %6.2f°\n  Y:  %6.2f°    %6.2f°\n  Z:  %6.2f°    %6.2f°\n", xrotdeg, xfrotdeg, yrotdeg, yfrotdeg, zrotdeg, zfrotdeg)
end

function MyGame:displayPositionSmall()
  if utils.readIntBE(self.startAddress + 0x7A82A0) == 0 then
	return string.format("")
  end

  local xpos = self.xPos:get()
  local ypos = self.yPos:get()
  local zpos = self.zPos:get()
  
  local xtilt = self.xTilt:get()
  local ytilt = self.yTilt:get()
  local ztilt = self.zTilt:get()
  
  return string.format("Position      Surface Tilt\n  X: %8.2f   X: %8.5f\n  Y: %8.2f   Y: %8.5f\n  Z: %8.2f   Z: %8.5f\n", xpos, xtilt, ypos, ytilt, zpos, ztilt)
end

function MyGame:displayMiscSmall()
  if utils.readIntBE(self.startAddress + 0x7A82A0) == 0 then
	return string.format("")
  end
  
  local hvr = self.hover:get()
  local actn = self.action:get()
  return string.format("Misc\n  Hover: %3d   Action: %3d\n", hvr, actn)
end

function MyGame:displayAnalogPosition()
  local xstick = self.stickX:get()
  local ystick = self.stickY:get()
  return string.format(" %3d,%d", xstick, ystick)
end  
  
function MyGame:getButton(button)
  -- Return 1 if button is pressed, 0 otherwise.
  local value = nil
  if button == "A" then value = self.ABXYS:get()[8]
  elseif button == "B" then value = self.ABXYS:get()[7]
  elseif button == "X" then value = self.ABXYS:get()[6]
  elseif button == "Y" then value = self.ABXYS:get()[5]
  elseif button == "S" then value = self.ABXYS:get()[4]
  elseif button == "Z" then value = self.DZ:get()[4]
  elseif button == "↑" then value = self.DZ:get()[5]
  elseif button == "↓" then value = self.DZ:get()[6]
  elseif button == "←" then value = self.DZ:get()[8]
  elseif button == "→" then value = self.DZ:get()[7]
  elseif button == "L" then value = self.DZ:get()[2]
  elseif button == "R" then value = self.DZ:get()[3]
  else error("Button code not recognized: " .. tostring(button))
  end

  return value
end

function MyGame:buttonDisplay(button)
  -- Return the button character ("A", "B" etc.) if the button is pressed,
  -- or a space character " " otherwise.
  local value = self:getButton(button)
  if value == 1 then
    return button
  else
    return " "
  end
end

function MyGame:displayAllButtons()
  local s = ""
  for _, button in pairs{"A", "B", "X", "Y", "S", "Z", "L", "R", "↓", "←", "→", "↑"} do
    s = s..self:buttonDisplay(button)
  end
  return s
end
  
  
MyGame.ControllerStickImage = subclass(layoutsModule.StickInputImage)
function MyGame.ControllerStickImage:init(window, game, options)
  options = options or {}
  options.max = options.max or 255
  options.min = options.min or 0
  options.square = options.square or false

  layoutsModule.StickInputImage.init(
    self, window,
    game.stickX, game.stickY, options)
end

MyGame.ControllerLRImage = subclass(layoutsModule.AnalogTriggerInputImage)
function MyGame.ControllerLRImage:init(window, game, options)
  options = options or {}
  options.max = options.max or 255

  layoutsModule.AnalogTriggerInputImage.init(
    self, window, game.lShoulder, game.rShoulder, options)
end

return MyGame