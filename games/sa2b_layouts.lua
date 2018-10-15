package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.layouts = nil
local layoutsModule = require 'layouts'
local Layout = layoutsModule.Layout

local layouts = {}

local fixedWidthFontName = "Consolas"

local inputColor = 0x880000
local notPressed = 0xaaaaaa

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
    self.game.vSpeed, "vspd_output.txt",
    {beforeDecimal=1, afterDecimal=10})
	
  self:addFileWriter(
    self.game.ySpd, "yspd_output.txt",
    {beforeDecimal=1, afterDecimal=10})

  self:addFileWriter(
    self.game.xRot, "xrot_output.txt",
    {beforeDecimal=1, afterDecimal=10})
	
  self:addFileWriter(
    self.game.zPos, "zpos_output.txt",
    {beforeDecimal=1, afterDecimal=10})
	
end

return {
  layouts = layouts,
}
