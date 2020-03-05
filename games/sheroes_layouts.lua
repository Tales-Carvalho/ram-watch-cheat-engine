package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.layouts = nil
local layoutsModule = require 'layouts'
local Layout = layoutsModule.Layout

--package.loaded.inputdisplay = nil
local inputDisplayModule = require 'inputdisplay'
local InputDisplay = inputDisplayModule.InputDisplay

local imageValueDisplayModule = require 'imagevaluedisplay'
local ImageValueDisplay = imageValueDisplayModule.ImageValueDisplay

local background = require 'background'
local HeroesBackground = background.HeroesBackground

local layouts = {}

local fixedWidthFontName = "Consolas"

local inputColor = 0x880000
local notPressed = 0xaaaaaa

layouts.improved_viewer = subclass(Layout)
function layouts.improved_viewer:init()
  
  local game = self.game

  --self.margin = 12
  --self:setUpdatesPerSecond(60)
  --self:activateAutoPositioningY()
  
  self:setBreakpointUpdateMethod()

  self.window:setSize(960, 2160)
  self.labelDefaults = {fontSize=22, fontName=fixedWidthFontName}
  --self.itemDisplayDefaults = {narrow=true}

  self:addImage(HeroesBackground, {"heroes_background", self.game.activeChar}, {x=0, y=0})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayFileTimer() end,
    8, 'Kimberley60pt'
  }, {x=604,y=86})


  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displaySonicValues().FSpd end,
    6, 'Kimberley60pt'
  }, {x=248,y=320})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displaySonicValues().VSpd end,
    6, 'Kimberley60pt'
  }, {x=248,y=392})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displaySonicValues().YRot end,
    6, 'Kimberley60pt'
  }, {x=248,y=550})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displaySonicValues().XPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=319})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displaySonicValues().YPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=391})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displaySonicValues().ZPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=463})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displaySonicValues().Action end,
    2, 'Kimberley60pt'
  }, {x=788,y=550})


  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayTailsValues().FSpd end,
    6, 'Kimberley60pt'
  }, {x=248,y=770})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayTailsValues().VSpd end,
    6, 'Kimberley60pt'
  }, {x=248,y=842})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayTailsValues().YRot end,
    6, 'Kimberley60pt'
  }, {x=248,y=1000})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayTailsValues().XPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=769})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayTailsValues().YPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=841})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayTailsValues().ZPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=913})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayTailsValues().Action end,
    2, 'Kimberley60pt'
  }, {x=788,y=1000})


  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayKnucklesValues().FSpd end,
    6, 'Kimberley60pt'
  }, {x=248,y=1220})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayKnucklesValues().VSpd end,
    6, 'Kimberley60pt'
  }, {x=248,y=1292})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayKnucklesValues().YRot end,
    6, 'Kimberley60pt'
  }, {x=248,y=1450})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayKnucklesValues().XPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=1219})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayKnucklesValues().YPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=1291})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayKnucklesValues().ZPos end,
    8, 'Kimberley60pt'
  }, {x=628,y=1363})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayKnucklesValues().Action end,
    2, 'Kimberley60pt'
  }, {x=788,y=1450})


  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayKickCounter() end,
    4, 'Kimberley60pt'
  }, {x=571,y=1607})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayRTATime() end,
    7, 'Kimberley60pt'
  }, {x=603,y=1723})

  --self:addImage(ImageValueDisplay, {function(...) return string.format("%d", self.game.activeChar:get()) end, 9, 'Kimberley60pt'}, {x=100,y=100})

  self:addImage(InputDisplay, {"TronStyleNoDpadUpscaled", self.game.ABXYS, self.game.DZ, self.game.stickX, self.game.stickY, self.game.xCStick, self.game.yCStick, self.game.lShoulder, self.game.rShoulder}, {x=0, y=1832})
  
end

layouts.normal = subclass(Layout)
function layouts.normal:init()
  
  local game = self.game

  -- Coordinates where the input viewer starts
  local x_coord_inputs = 71
  local y_coord_inputs = 569
  
  -- Offset coordinates for each button, relative to above variables
  local x_coord = {141, 124, 158, 141, 107, 158,  14, 141, 142, 132, 152, 142}
  local y_coord = { 47,  47,  47,  27,  67,   0,   0,   0,  97,  85,  85,  72}
  
  local buttons = {"A", "B", "X", "Y", "S", "Z", "L", "R", "↓", "←", "→", "↑"} 
  local f_sizes = { 11,  11,  11,  11,  11,  11,  11,  11,   8,   8,   8,   8}
  
  self.margin = 6
  self:setBreakpointUpdateMethod()
  --self:activateAutoPositioningY()
  
  self.window:setSize(320, 720)
  self.labelDefaults = {fontSize=11, fontName=fixedWidthFontName}
  self.itemDisplayDefaults = {narrow=true}
  
  self:addLabel()
  
  --Time
  self:addItem(function(...) return self.game:displayTime(...) end)
  
  --Speed
  self:addItem(function(...) return self.game:displaySpeed(...) end)
  
  --Position
  self:addItem(function(...) return self.game:displayPosition(...) end)
  
  --Rotation
  self:addItem(function(...) return self.game:displayRotation(...) end)
  
  --Physics
  self:addItem(function(...) return self.game:displayPhysics(...) end)
  
  --Misc
  self:addItem(function(...) return self.game:displayMisc(...) end)
  
  --Status Bitfield
  self:addItem(function(...) return self.game:displayStatus(...) end)
  
  --Inputs
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i]+x_coord_inputs, y=y_coord[i]+y_coord_inputs, fontColor=notPressed, fontSize=f_sizes[i]}
	  self:addItem(button)
  end
  
  self:addLabel{x=x_coord_inputs+141, y=y_coord_inputs+82, fontColor=notPressed}
  self:addItem("D")
  
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i]+x_coord_inputs, y=y_coord[i]+y_coord_inputs, fontColor=inputColor, fontSize=f_sizes[i]}
	  self:addItem(function(...) return self.game:buttonDisplay(button) end)
  end
  
  self:addLabel{foregroundColor=inputColor}  
  self:addImage(
    self.game.ControllerLRImage, {game}, {x=x_coord_inputs+31, y=y_coord_inputs+1, foregroundColor=inputColor, outlineColor=notPressed})
	
  self:addLabel{foregroundColor=inputColor}
  self:addImage(
    self.game.ControllerStickImage, {game}, {x=x_coord_inputs, y=y_coord_inputs+21, foregroundColor=inputColor, outlineColor=notPressed})

  self:addLabel{x=x_coord_inputs+14, y=y_coord_inputs+123, fontColor=inputColor}
  self:addItem(function(...) return self.game:displayAnalogPosition(...) end)
  
end

layouts.youtube = subclass(Layout)
function layouts.youtube:init()
  
  local game = self.game

  -- Coordinates where the input viewer starts
  local x_coord_inputs = 30
  local y_coord_inputs = 389
  
  -- Offset coordinates for each button, relative to above variables
  local x_coord = {141, 124, 158, 141, 107, 158,  14, 141, 142, 132, 152, 142}
  local y_coord = { 47,  47,  47,  27,  67,   0,   0,   0,  97,  85,  85,  72}
  
  local buttons = {"A", "B", "X", "Y", "S", "Z", "L", "R", "↓", "←", "→", "↑"} 
  local f_sizes = { 11,  11,  11,  11,  11,  11,  11,  11,   8,   8,   8,   8}
  
  self.margin = 6
  self:setBreakpointUpdateMethod()
  --self:activateAutoPositioningY()
  
  self.window:setSize(240, 540)
  self.labelDefaults = {fontSize=11, fontName=fixedWidthFontName}
  self.itemDisplayDefaults = {narrow=true}
  
  self:addLabel()
  
  --Time
  self:addItem(function(...) return self.game:displayTime(...) end)
  
  --Speed
  self:addItem(function(...) return self.game:displaySpeedSmall(...) end)
  
  --Position
  self:addItem(function(...) return self.game:displayPositionSmall(...) end)
  
  --Rotation
  self:addItem(function(...) return self.game:displayRotationSmall(...) end)
  
  --Physics
  --self:addItem(function(...) return self.game:displayPhysics(...) end)
  
  --Misc
  self:addItem(function(...) return self.game:displayMiscSmall(...) end)
  
  --Status Bitfield
  --self:addItem(function(...) return self.game:displayStatus(...) end)
  
  --Inputs
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i]+x_coord_inputs, y=y_coord[i]+y_coord_inputs, fontColor=notPressed, fontSize=f_sizes[i]}
	  self:addItem(button)
  end
  
  self:addLabel{x=x_coord_inputs+141, y=y_coord_inputs+82, fontColor=notPressed}
  self:addItem("D")
  
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i]+x_coord_inputs, y=y_coord[i]+y_coord_inputs, fontColor=inputColor, fontSize=f_sizes[i]}
	  self:addItem(function(...) return self.game:buttonDisplay(button) end)
  end
  
  self:addLabel{foregroundColor=inputColor}  
  self:addImage(
    self.game.ControllerLRImage, {game}, {x=x_coord_inputs+31, y=y_coord_inputs+1, foregroundColor=inputColor, outlineColor=notPressed})
	
  self:addLabel{foregroundColor=inputColor}
  self:addImage(
    self.game.ControllerStickImage, {game}, {x=x_coord_inputs, y=y_coord_inputs+21, foregroundColor=inputColor, outlineColor=notPressed})

  self:addLabel{x=x_coord_inputs+14, y=y_coord_inputs+123, fontColor=inputColor}
  self:addItem(function(...) return self.game:displayAnalogPosition(...) end)
  
end

layouts.angleTest = subclass(Layout)
function layouts.angleTest:init()
  
  local game = self.game

  -- Coordinates where the input viewer starts
  local x_coord_inputs = 71
  local y_coord_inputs = 569
  
  -- Offset coordinates for each button, relative to above variables
  local x_coord = {141, 124, 158, 141, 107, 158,  14, 141, 142, 132, 152, 142}
  local y_coord = { 47,  47,  47,  27,  67,   0,   0,   0,  97,  85,  85,  72}
  
  local buttons = {"A", "B", "X", "Y", "S", "Z", "L", "R", "↓", "←", "→", "↑"} 
  local f_sizes = { 11,  11,  11,  11,  11,  11,  11,  11,   8,   8,   8,   8}
  
  self.margin = 6
  self:setBreakpointUpdateMethod()
  --self:activateAutoPositioningY()
  
  self.window:setSize(320, 720)
  self.labelDefaults = {fontSize=11, fontName=fixedWidthFontName}
  self.itemDisplayDefaults = {narrow=true}
  
  self:addLabel()
  
  --Time
  self:addItem(function(...) return self.game:displayTime(...) end)
  
  --Position
  self:addItem(function(...) return self.game:displayPosition(...) end)
  
  --Rotation
  self:addItem(function(...) return self.game:displayRotation(...) end)
  
  --Camera Position
  self:addItem(function(...) return self.game:displayCameraPosition(...) end)
  
  --Camera Rotation
  self:addItem(function(...) return self.game:displayCameraRotation(...) end)
  
  --Angle Optimization
  self:addItem(function(...) return self.game:displayAngleOptimization(...) end)
  
  --Inputs
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i]+x_coord_inputs, y=y_coord[i]+y_coord_inputs, fontColor=notPressed, fontSize=f_sizes[i]}
	  self:addItem(button)
  end
  
  self:addLabel{x=x_coord_inputs+141, y=y_coord_inputs+82, fontColor=notPressed}
  self:addItem("D")
  
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i]+x_coord_inputs, y=y_coord[i]+y_coord_inputs, fontColor=inputColor, fontSize=f_sizes[i]}
	  self:addItem(function(...) return self.game:buttonDisplay(button) end)
  end
  
  self:addLabel{foregroundColor=inputColor}  
  self:addImage(
    self.game.ControllerLRImage, {game}, {x=x_coord_inputs+31, y=y_coord_inputs+1, foregroundColor=inputColor, outlineColor=notPressed})
	
  self:addLabel{foregroundColor=inputColor}
  self:addImage(
    self.game.ControllerStickImage, {game}, {x=x_coord_inputs, y=y_coord_inputs+21, foregroundColor=inputColor, outlineColor=notPressed})

  self:addLabel{x=x_coord_inputs+14, y=y_coord_inputs+123, fontColor=inputColor}
  self:addItem(function(...) return self.game:displayAnalogPosition(...) end)
  
end

layouts.recording = subclass(Layout)
function layouts.recording:init()

  local game = self.game
  self.margin = 6
  self:setBreakpointUpdateMethod()
  self:activateAutoPositioningY()
  
  self.window:setSize(240, 540)
  self.labelDefaults = {fontSize=fontSize, fontName=fixedWidthFontName}
  self.itemDisplayDefaults = {narrow=true}
  
  -- Watch XPos, FSpeed, YPos and VSpeed
  
  self:addLabel()
  
  --self:addItem(self.game.fSpeed)
  self:addItem(self.game.vSpeed)
  
  self:addItem(self.game.ySpd)
  
  --self:addItem(self.game.xPos)
  self:addItem(self.game.xRot)
  
  self:addItem(self.game.zPos)
  
  self:addFileWriter(
    self.game.xPos, "xpos_output.txt",
    {beforeDecimal=1, afterDecimal=10})
	
  self:addFileWriter(
    self.game.zPos, "zpos_output.txt",
    {beforeDecimal=1, afterDecimal=10})

  self:addFileWriter(
    self.game.yRot, "yrot_output.txt",
    {beforeDecimal=1, afterDecimal=10})
	
  self:addFileWriter(
    self.game.fSpeed, "fspd_output.txt",
    {beforeDecimal=1, afterDecimal=10})
	
end

return {
  layouts = layouts,
}