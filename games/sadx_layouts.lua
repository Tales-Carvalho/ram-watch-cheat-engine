package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.layouts = nil
local layoutsModule = require 'layouts'
local Layout = layoutsModule.Layout

local inputDisplayModule = require 'inputdisplay'
local InputDisplay = inputDisplayModule.InputDisplay

local imageValueDisplayModule = require 'imagevaluedisplay'
local ImageValueDisplay = imageValueDisplayModule.ImageValueDisplay

local background = require 'background'
local SADXBackground = background.SADXBackground

local layouts = {}

local fixedWidthFontName = "Consolas"

local inputColor = 0x880000
local notPressed = 0xaaaaaa

layouts.improved_viewer_2160p = subclass(Layout)
function layouts.improved_viewer_2160p:init()
  
  local game = self.game
  
  self:setBreakpointUpdateMethod()

  self.window:setColor(0x000000)
  self.window:setSize(960, 2160)
  self.labelDefaults = {fontSize=22, fontName=fixedWidthFontName}

  self:addImage(SADXBackground, {"sa_background_2160p", self.game.character}, {x=0, y=0})

  local variables = {
    {Name = 'Time', Characters = 16, X = 279, Y = 77},
    {Name = 'FSpd', Characters = 7, X = 173, Y = 383},
    {Name = 'VSpd', Characters = 7, X = 173, Y = 455},
    {Name = 'XSpd', Characters = 7, X = 628, Y = 347},
    {Name = 'YSpd', Characters = 7, X = 628, Y = 419},
    {Name = 'ZSpd', Characters = 7, X = 628, Y = 491},
    {Name = 'XPos', Characters = 11, X = 299, Y = 688},
    {Name = 'YPos', Characters = 11, X = 299, Y = 760},
    {Name = 'ZPos', Characters = 11, X = 299, Y = 832},
    {Name = 'XRot', Characters = 6, X = 213, Y = 1101},
    {Name = 'YRot', Characters = 6, X = 669, Y = 1137},
    {Name = 'ZRot', Characters = 6, X = 213, Y = 1173},
    {Name = 'Hover', Characters = 5, X = 301, Y = 1371},
    {Name = 'Action', Characters = 2, X = 834, Y = 1371},
    {Name = 'StSpd', Characters = 7, X = 628, Y = 1443},
    {Name = 'RNG', Characters = 10, X = 508, Y = 1443},
    {Name = 'Flight', Characters = 7, X = 628, Y = 1443}
  }

  for i, variable in ipairs(variables) do
    self:addImage(ImageValueDisplay, {
      function(...) return self.game:displayValues()[variable.Name] end,
      variable.Characters, 'Kimberley60pt'
    }, {x=variable.X,y=variable.Y})
  end

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayAnalogAngle() end,
    6, 'Kimberley60pt'
  }, {x=554,y=1650})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayValues().AnalogMagnitude end,
    6, 'Kimberley60pt'
  }, {x=554,y=1722})

  self:addImage(InputDisplay, {"TronStyleNoDpad2160p", self.game.controllerData1, self.game.controllerData2}, {x=0, y=1832})
  
end

layouts.improved_viewer_720p = subclass(Layout)
function layouts.improved_viewer_720p:init()
  
  local game = self.game
  
  self:setBreakpointUpdateMethod()

  self.window:setColor(0x000000)
  self.window:setSize(320, 720)
  self.labelDefaults = {fontSize=22, fontName=fixedWidthFontName}

  self:addImage(SADXBackground, {"sa_background_720p", self.game.character}, {x=0, y=0})

  local variables = {
    {Name = 'Time', Characters = 16, X = 103, Y = 26},
    {Name = 'FSpd', Characters = 7, X = 58, Y = 128},
    {Name = 'VSpd', Characters = 7, X = 58, Y = 152},
    {Name = 'XSpd', Characters = 7, X = 209, Y = 116},
    {Name = 'YSpd', Characters = 7, X = 209, Y = 140},
    {Name = 'ZSpd', Characters = 7, X = 209, Y = 164},
    {Name = 'XPos', Characters = 11, X = 100, Y = 229},
    {Name = 'YPos', Characters = 11, X = 100, Y = 253},
    {Name = 'ZPos', Characters = 11, X = 100, Y = 277},
    {Name = 'XRot', Characters = 6, X = 71, Y = 367},
    {Name = 'YRot', Characters = 6, X = 222, Y = 379},
    {Name = 'ZRot', Characters = 6, X = 71, Y = 391},
    {Name = 'Hover', Characters = 5, X = 100, Y = 457},
    {Name = 'Action', Characters = 2, X = 274, Y = 457},
    {Name = 'StSpd', Characters = 7, X = 209, Y = 481},
    {Name = 'RNG', Characters = 10, X = 169, Y = 481},
    {Name = 'Flight', Characters = 7, X = 209, Y = 481}
  }

  for i, variable in ipairs(variables) do
    self:addImage(ImageValueDisplay, {
      function(...) return self.game:displayValues()[variable.Name] end,
      variable.Characters, 'Kimberley20pt'
    }, {x=variable.X,y=variable.Y})
  end

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayAnalogAngle() end,
    6, 'Kimberley20pt'
  }, {x=185,y=550})

  self:addImage(ImageValueDisplay, {
    function(...) return self.game:displayValues().AnalogMagnitude end,
    6, 'Kimberley20pt'
  }, {x=185,y=574})

  self:addImage(InputDisplay, {"TronStyleNoDpad720p", self.game.controllerData1, self.game.controllerData2}, {x=0, y=611})
  
end

layouts.mainAddresses = subclass(Layout)
function layouts.mainAddresses:init()

  self:setBreakpointUpdateMethod()
  
  self.window:setSize(400, 300)

  self:addLabel{x=6, y=6}
  self:addItem(self.game.fSpeed)
  self:addItem(self.game.vSpeed)
  self:addItem(self.game.facingAngle)
  self:addItem(self.game.piece1)
  self:addItem(self.game.piece2)
  self:addItem(self.game.piece3)
  self:addItem(function() return utils.intToHexStr(self.game.fSpeed:getAddress()) end)
  
end

layouts.cameraViewer = subclass(Layout)
function layouts.cameraViewer:init()

  self:setBreakpointUpdateMethod()
  
  self.window:setSize(640, 480)
  self.window:setColor(0x00ff00)

  local camera = {
    XPos = self.game.cameraXPos,
    YPos = self.game.cameraYPos,
    ZPos = self.game.cameraZPos,
    XRot = self.game.cameraXRot,
    YRot = self.game.cameraYRot
  }

  local object = {
    XPos = self.game.xPos,
    YPos = self.game.yPos,
    ZPos = self.game.zPos
  }

  self:addImage(CameraViewer, {'sonic_icon.png', camera, object, 640, 480}, {x=0, y=0})

end


layouts.normal = subclass(Layout)
function layouts.normal:init()
  
  local game = self.game
  
  local x_coord = {171, 154, 188, 171, 137, 188, 44, 171, 172, 162, 182, 172}
  local y_coord = {436, 436, 436, 416, 456, 389, 389, 389, 486, 474, 474, 461}
  local buttons = {"A", "B", "X", "Y", "S", "Z", "L", "R", "↓", "←", "→", "↑"} 
  local f_sizes = {11,  11,  11,  11,  11,  11,  11,  11,  8,   8,   8,   8}
  
  self.margin = 6
  self:setBreakpointUpdateMethod()
  
  self.window:setSize(240, 540)
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
  
  --Misc
  self:addItem(function(...) return self.game:displayMisc(...) end)
  
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i], y=y_coord[i], fontColor=notPressed, fontSize=f_sizes[i]}
	  self:addItem(button)
  end
  
  self:addLabel{x=171, y=471, fontColor=notPressed}
  self:addItem("D")
  
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i], y=y_coord[i], fontColor=inputColor, fontSize=f_sizes[i]}
	  self:addItem(function(...) return self.game:buttonDisplay(button) end)
  end
  
  self:addLabel{foregroundColor=inputColor}  
  self:addImage(
    self.game.ControllerLRImage, {game}, {x=61, y=390, foregroundColor=inputColor, outlineColor=notPressed})
	
  self:addLabel{foregroundColor=inputColor}
  self:addImage(
    self.game.ControllerStickImage, {game}, {x=30, y=410, foregroundColor=inputColor, outlineColor=notPressed})

  self:addLabel{x=44, y=512, fontColor=inputColor}
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
  self:setUpdatesPerSecond(60)
  
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
  
  --Misc
  self:addItem(function(...) return self.game:displayMiscSmall(...) end)
  
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

layouts.big_youtube = subclass(Layout)
function layouts.big_youtube:init()
  
  local game = self.game

  -- Coordinates where the input viewer starts
  local x_coord_inputs = 73
  local y_coord_inputs = 100 --778
  
  -- Offset coordinates for each button, relative to above variables
  local x_coord = {282, 248, 316, 282, 214, 316,  28, 282, 284, 264, 304, 284}
  local y_coord = { 94,  94,  94,  54, 134,   0,   0,   0, 194, 170, 170, 144}
  
  local buttons = {"A", "B", "X", "Y", "S", "Z", "L", "R", "↓", "←", "→", "↑"} 
  local f_sizes = { 22,  22,  22,  22,  22,  22,  22,  22,  16,  16,  16,  16}
  
  self.margin = 12
  self:setBreakpointUpdateMethod()
  
  self.window:setSize(480, 1080)
  self.labelDefaults = {fontSize=22, fontName=fixedWidthFontName}
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
  
  --Misc
  self:addItem(function(...) return self.game:displayMiscSmall(...) end)
  
  --Inputs
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i]+x_coord_inputs, y=y_coord[i]+y_coord_inputs, fontColor=notPressed, fontSize=f_sizes[i]}
	  self:addItem(button)
  end
  
  self:addLabel{x=x_coord_inputs+282, y=y_coord_inputs+164, fontColor=notPressed}
  self:addItem("D")
  
  for i, button in pairs(buttons) do
	  self:addLabel{x=x_coord[i]+x_coord_inputs, y=y_coord[i]+y_coord_inputs, fontColor=inputColor, fontSize=f_sizes[i]}
	  self:addItem(function(...) return self.game:buttonDisplay(button) end)
  end
  
  self:addLabel{foregroundColor=inputColor}  
  self:addImage(
    self.game.ControllerLRImage, {game}, {x=x_coord_inputs+62, y=y_coord_inputs+2, foregroundColor=inputColor, outlineColor=notPressed, width=200, height=30, lineThickness=4})
	
  self:addLabel{foregroundColor=inputColor}
  self:addImage(
    self.game.ControllerStickImage, {game}, {x=x_coord_inputs, y=y_coord_inputs+42, foregroundColor=inputColor, outlineColor=notPressed, size=200, lineThickness=4})

  self:addLabel{x=x_coord_inputs+28, y=y_coord_inputs+246, fontColor=inputColor}
  self:addItem(function(...) return self.game:displayAnalogPosition(...) end)
  
end

return {
  layouts = layouts,
}