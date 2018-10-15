package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.dolphin = nil
local dolphin = require 'dolphin'

local MyGame = subclass(dolphin.DolphinGame)

MyGame.supportedGameVersions = {
  na = 'GSNE8P',
}

MyGame.layoutModuleNames = {'sa2b_layouts'}
MyGame.framerate = 60

function MyGame:init(options)
  dolphin.DolphinGame.init(self, options)

  self.startAddress = self:getGameStartAddress()
end


-- Pointers addresses update

function MyGame:updateAddresses()
  local pointerChar1 = self.startAddress + 0x1e7788
  local pointerChar2 = self.startAddress + 0x1e7768
  local pointerChar3 = self.startAddress + 0x1e7748
  local pointerChar4 = self.startAddress + 0x1e7728

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
end


local valuetypes = require "valuetypes"
local V = valuetypes.V
local GV = MyGame.blockValues
local MV = valuetypes.MV
local Block = valuetypes.Block
local Value = valuetypes.Value
local ShortType = valuetypes.ShortTypeBE
local FloatType = valuetypes.FloatTypeBE
local IntType = valuetypes.IntTypeBE
local ByteType = valuetypes.ByteType
local BinaryType = valuetypes.BinaryType

package.loaded.layouts = nil
local layoutsModule = require 'layouts'


-- Pointer based and static values updates

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


-- Game addresses

GV.stSpeed = MV(
  "StSpeed", 0x44, PointerBasedChar4Value, FloatType)
GV.fSpeed = MV(
  "FSpeed", 0x64, PointerBasedChar4Value, FloatType)
GV.vSpeed = MV(
  "VSpeed", 0x68, PointerBasedChar4Value, FloatType)
GV.sdSpeed = MV(
  "SideSpeed", 0x6c, PointerBasedChar4Value, FloatType)

GV.xPush = MV(
  "XPush", 0x70, PointerBasedChar4Value, FloatType)
GV.yPush = MV(
  "YPush", 0x74, PointerBasedChar4Value, FloatType)
GV.zPush = MV(
  "ZPush", 0x78, PointerBasedChar4Value, FloatType)
  
GV.xPos = MV(
  "XPos", 0x14, PointerBasedChar2Value, FloatType)
GV.yPos = MV(
  "YPos", 0x18, PointerBasedChar2Value, FloatType)
GV.zPos = MV(
  "ZPos", 0x1C, PointerBasedChar2Value, FloatType)
  
GV.xSpd = MV(
  "XSpd", 0x0, PointerBasedChar3Value, FloatType)
GV.ySpd = MV(
  "YSpd", 0x4, PointerBasedChar3Value, FloatType)
GV.zSpd = MV(
  "ZSpd", 0x8, PointerBasedChar3Value, FloatType)

GV.xfSpd = MV(
  "XForcedSpd", 0xc, PointerBasedChar3Value, FloatType)
GV.yfSpd = MV(
  "YForcedSpd", 0x10, PointerBasedChar3Value, FloatType)
GV.zfSpd = MV(
  "ZForcedSpd", 0x14, PointerBasedChar3Value, FloatType)
  
GV.xRot = MV(
  "XRot", 0xA, PointerBasedChar2Value, ShortType)
GV.yRot = MV(
  "YRot", 0xE, PointerBasedChar2Value, ShortType)
GV.zRot = MV(
  "ZRot", 0x12, PointerBasedChar2Value, ShortType)

GV.xfRot = MV(
  "XFinalRot", 0x1A, PointerBasedChar3Value, ShortType)
GV.yfRot = MV(
  "YFinalRot", 0x1E, PointerBasedChar3Value, ShortType)
GV.zfRot = MV(
  "ZFinalRot", 0x22, PointerBasedChar3Value, ShortType)
  
GV.xTilt = MV(
  "XTilt", 0x7C, PointerBasedChar4Value, FloatType)
GV.yTilt = MV(
  "YTilt", 0x80, PointerBasedChar4Value, FloatType)
GV.zTilt = MV(
  "ZTilt", 0x84, PointerBasedChar4Value, FloatType)
  
GV.hover = MV(
  "HoverTimer", 0x12, PointerBasedChar4Value, ShortType)
GV.action = MV(
  "ActionNumber", 0x0, PointerBasedChar2Value, ByteType)
GV.status1 = MV(
  "StatusBitfield1", 0x4, PointerBasedChar2Value, BinaryType, {binarySize=8, binaryStartBit=7})
GV.status2 = MV(
  "StatusBitfield2", 0x5, PointerBasedChar2Value, BinaryType, {binarySize=8, binaryStartBit=7})

  
GV.character = MV(
  "CharacterID", 0x3, PointerBasedChar4Value, ByteType)

GV.kpGrSpd = MV(
  "KeepGravitySpeed", 0xF4, PointerBasedChar4Value, FloatType)
GV.vDecel = MV(
  "VerticalDeceleration", 0x118, PointerBasedChar4Value, FloatType)
GV.gravity = MV(
  "Gravity", 0x138, PointerBasedChar4Value, FloatType)
GV.speedShoes =
  MV("SpeedShoes", 0xD9E302, StaticValue, ShortType)
  
  
-- Inputs

GV.ABXYS = MV("ABXY & Start", 0x2BAB78,
  StaticValue, BinaryType, {binarySize=8, binaryStartBit=7})
GV.DZ = MV("D-Pad & Z", 0x2BAB79,
  StaticValue, BinaryType, {binarySize=8, binaryStartBit=7})
  
GV.stickX =
  MV("X Stick", 0x2BAB7A, StaticValue, ByteType)
GV.stickY =
  MV("Y Stick", 0x2BAB7B, StaticValue, ByteType)
GV.xCStick =
  MV("X C-Stick", 0x2BAB7C, StaticValue, ByteType)
GV.yCStick =
  MV("Y C-Stick", 0x2BAB7D, StaticValue, ByteType)
GV.lShoulder =
  MV("L Shoulder", 0x2BAB7E, StaticValue, ByteType)
GV.rShoulder =
  MV("R Shoulder", 0x2BAB7F, StaticValue, ByteType)

  
-- Time

GV.frameCounter = 
  MV("Frames Counter", 0x3AD858, StaticValue, IntType)
GV.centiseconds =
  MV("Centiseconds", 0x1B3DAF, StaticValue, ByteType)
GV.seconds =
  MV("Seconds", 0x1B3D6F, StaticValue, ByteType)
GV.minutes =
  MV("Minutes", 0x1B3D2F, StaticValue, ByteType)
 
 
-- Screen display functions
  
function MyGame:displaySpeed()
  local stspd = self.stSpeed:get()
  local sdspd = self.sdSpeed:get()
  local fspd = self.fSpeed:get()
  local vspd = self.vSpeed:get()
  local xspd = self.xSpd:get()
  local yspd = self.ySpd:get()
  local zspd = self.zSpd:get()
  
  return string.format("Speed\n  Fwd: %9.4f\tX: %9.4f\n  Vtc: %9.4f\tY: %9.4f\n  Std: %9.4f\tZ: %9.4f\n  Sdw: %9.4f\n", fspd, xspd, vspd, yspd, stspd, zspd, sdspd)
end

function MyGame:displayRotation()
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
  
  return string.format("Rotation\n     Current          Final\n  X: %05d  %6.2f°   %05d  %6.2f°\n  Y: %05d  %6.2f°   %05d  %6.2f°\n  Z: %05d  %6.2f°   %05d  %6.2f°\n", xrot, xrotdeg, xfrot, xfrotdeg, yrot, yrotdeg, yfrot, yfrotdeg, zrot, zrotdeg, zfrot, zfrotdeg)
end

function MyGame:displayPosition()
  local xpos = self.xPos:get()
  local ypos = self.yPos:get()
  local zpos = self.zPos:get()
  
  local xpush = self.xPush:get()
  local ypush = self.yPush:get()
  local zpush = self.zPush:get()
  
  return string.format("Position              External Push\n  X: %10.4f         X: %9.4f\n  Y: %10.4f         Y: %9.4f\n  Z: %10.4f         Z: %9.4f\n", xpos, xpush, ypos, ypush, zpos, zpush)
end

function MyGame:displayTime()
  local frames = self.frameCounter:get()
  local centi = self.centiseconds:get()
  local sec = self.seconds:get()
  local minu = self.minutes:get()
  
  local chr = self.character:get()
  local chr_array = {"Sonic", "Shadow", "Mechless Tails", "Mechless Eggman", "Knuckles", "Rouge", "Tails", "Eggman", "Amy", "Super Sonic", "Super Shadow", "", "Metal Sonic", "Chao Walker", "Dark Chao Walker", "Tikal", "Chaos"}
  
  return string.format("  %02d:%02d:%02d | %5d | %s\n", minu, sec, centi, frames, chr_array[chr+1])
end  

function MyGame:displayMisc()
  local hvr = self.hover:get()
  local spdsh = self.speedShoes:get()
  local actn = self.action:get()
  -- TODO: fix speed shoes
  return string.format("Misc\n  Hover:  %3d         Action: %3d\n", hvr, actn)
end

function MyGame:displayStatus()
  local stts1 = self.status1:get()
  local stts2 = self.status2:get()
  local status_arr = {"Ball Form", "Light Dash", "B Enabled", "Holding Object", "Setting Variables", "Automated Section", "Disable Control", "Invincible", "On Ground", "On Ground (Object)", "Hurt", "Object Interact", "Object Ceiling", "On Object", "Unknown", "Unknown"}
  
  local s = ""
  for i = 0,7 do
    if stts1[i+1] == 1 then
	  if s == "" then
	    s = s .. status_arr[8-i]
	  else
	    s = s .. ", " .. status_arr[8-i]
	  end
	end
  end
  
  for i = 0,7 do
    if stts2[i+1] == 1 then
	  if s == "" then
	    s = s .. status_arr[16-i]
	  else
	    s = s .. ", " .. status_arr[16-i]
	  end
	end
  end
  
  return string.format("Status: %s\n", s)
end

function MyGame:displayPhysics()
  local vspd = self.vSpeed:get()
  local xrot = self.xRot:get()
  local zrot = self.zRot:get()
  
  local keepgravity = self.kpGrSpd:get()
  local vdecel = self.vDecel:get()
  local grav = self.gravity:get()
  
  local tv = grav / vdecel
  local gravangle = math.acos(math.cos(math.rad(xrot * 360 / 65536)) * math.cos(math.rad(zrot * 360 / 65536)))
  local angledtv = tv * math.cos(gravangle)
  
  local reqfspd_attv = 0.0
  if math.abs(angledtv) < math.abs(keepgravity) then
    reqfspd_attv = math.sqrt( keepgravity * keepgravity - angledtv * angledtv )
  end
  
  local reqfspd_curr = 0.0
  if math.abs(vspd) < math.abs(keepgravity) then
    reqfspd_curr = math.sqrt( keepgravity * keepgravity - vspd * vspd )
  end
  
  return string.format("Physics\n  GravityAngle = %3.2f°\n  GlobalTermVel = %3.4f\n  AngledTermVel = %3.4f\n  ReqFspdGravity = %3.4f\n  ReqFspdTermVel = %3.4f\n", math.deg(gravangle), tv, angledtv, reqfspd_curr, reqfspd_attv)
end

function MyGame:displayAnalogPosition()
  local xstick = self.stickX:get()
  local ystick = self.stickY:get()
  return string.format(" %3d,%d", xstick, ystick)
end  
  
  
-- Input viewer functions
  
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
