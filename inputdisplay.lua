package.loaded.layouts = nil
local layouts = require "layouts"
package.loaded.utils = nil
local utils = require "utils"
local readIntBE = utils.readIntBE
local subclass = utils.subclass
local CompoundElement = layouts.CompoundElement
local SimpleElement = layouts.SimpleElement

local InputDisplay = subclass(CompoundElement)

function InputDisplay:init(window, style, abxys, dz, mainStickX, mainStickY, cStickX, cStickY, lShoulder, rShoulder, passedDisplayOptions)

  	self.style = style
	self.abxys = abxys
	self.dz = dz
	self.mainStickX = mainStickX
	self.mainStickY = mainStickY
	self.cStickX = cStickX
	self.cStickY = cStickY
	self.lShoulder = lShoulder
	self.rShoulder = rShoulder
	
	self.displayOptions = {nolabel=true}
	if passedDisplayOptions then
		utils.updateTable(self.displayOptions, passedDisplayOptions)
	end

	local skin = require ("inputs_skin/" .. self.style .. "/skin")

	local inputDirectory = RWCEMainDirectory .. '/inputs_skin/' .. self.style
	
	self.background = createPicture()
	self.background:loadFromFile(inputDirectory .. skin.backgroundFile)
	
	self.buttons = skin.buttons
	
	self.analogMarkers = skin.analogMarkers
	
	self.shoulders = skin.shoulders
	
	local uiObj = createImage(window)
	uiObj:setSize(skin.width,skin.height)
	uiObj:setStretch(false)
	
	self:addElement({0,0}, uiObj)
	
	self.empty = createPicture()

	self.buttonImages = {}
	
	for n, button in pairs(self.buttons) do
		self.buttonImages[n] = createPicture()
		self.buttonImages[n]:loadFromFile(inputDirectory .. button.File)
		
		local uiObj2 = createImage(window)
		uiObj2:setSize(button.Size[1], button.Size[2])
		uiObj2:setStretch(false)
		self:addElement(button.Pos, uiObj2)
	end
	
	self.analogImages = {}
	
	for n, analogMarker in pairs(self.analogMarkers) do
		self.analogImages[n] = createPicture()
		self.analogImages[n]:loadFromFile(inputDirectory .. analogMarker.File)
		
		local uiObj2 = createImage(window)
		uiObj2:setSize(analogMarker.Size[1], analogMarker.Size[2])
		uiObj2:setStretch(false)
		self:addElement(analogMarker.Pos, uiObj2)
	end

	-- self.shoulderImages = {}

	-- for n, shoulder in pairs(self.shoulders) do
	-- 	self.shoulderImages[n] = createPicture()
	-- 	local uiObj2 = createImage(window)
	-- 	uiObj2:setSize(shoulder.Size[1], shoulder.Size[2])
	-- 	uiObj2:setStretch(false)
	-- 	self:addElement(shoulder.Pos, uiObj2)

	-- end

end

function InputDisplay:update()
	
	local buttonPresses = {
		self.abxys:get()[8],
		self.abxys:get()[7],
		self.abxys:get()[6],
		self.abxys:get()[5],
		self.abxys:get()[4],
		self.dz:get()[2],
		self.dz:get()[3],
		self.dz:get()[4],
		self.dz:get()[5],
		self.dz:get()[6],
		self.dz:get()[7],
		self.dz:get()[8]
	}
	
	self.elements[1].uiObj.setPicture(self.background)
	
	for n, buttonImage in pairs(self.buttonImages) do
		self.elements[n+1].uiObj.setPicture(buttonImage)
		self.elements[n+1].uiObj.setVisible(buttonPresses[n] == 1)
	end
	
	local mainXPos = (self.mainStickX:get() - 128) / 128
	local mainYPos = (self.mainStickY:get() - 128) / 128
	
	local mainRadius =  math.sqrt(mainXPos * mainXPos + mainYPos * mainYPos)
	
	if mainRadius > 1 then
		mainXPos = mainXPos / mainRadius
		mainYPos = mainYPos / mainRadius
	end
	
	local cXPos = (self.cStickX:get() - 128) / 128
	local cYPos = (self.cStickY:get() - 128) / 128
	
	local cRadius =  math.sqrt(cXPos * cXPos + cYPos * cYPos)
	
	if cRadius > 1 then
		cXPos = cXPos / cRadius
		cYPos = cYPos / cRadius
	end
	
	local analogPositions = {
		{ self:getLeft() + mainXPos * self.analogMarkers[1].Range + self.analogMarkers[1].Pos[1], self:getTop() - mainYPos * self.analogMarkers[1].Range + self.analogMarkers[1].Pos[2] },
		{ self:getLeft() + cXPos * self.analogMarkers[2].Range + self.analogMarkers[2].Pos[1], self:getTop() - cYPos * self.analogMarkers[2].Range + self.analogMarkers[2].Pos[2] }
	}
	
	for n, analogImage in pairs(self.analogImages) do
		self.elements[#self.buttonImages+1+n].uiObj.setPicture(analogImage)
		self.elements[#self.buttonImages+1+n].uiObj.setPosition(analogPositions[n][1], analogPositions[n][2])
	end

	-- local shoulderWidths = {
	-- 	self.lShoulder:get() * self.shoulders[1].Size[1] / 256,
	-- 	self.rShoulder:get() * self.shoulders[2].Size[1] / 256
	-- }

	-- local shoulderXPositions = {
	-- 	self.shoulders[1].Pos[1],
	-- 	self.shoulders[1].Pos[1] + self.shoulders[2].Size[1] - shoulderWidths[2]
	-- }

	-- for n, shoulder in pairs(self.shoulders) do
	-- 	-- self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setPicture(shoulderImage)
	-- 	-- self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setPosition(shoulderXPositions[n], self.shoulders[n].Pos[2])
	-- 	-- self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setSize(shoulderWidths[n], self.shoulders[n].Size[2])
	-- 	local canvas = self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj:getCanvas()
	-- 	canvas:getBrush():setColor(self.shoulders[n].Color)
	-- 	canvas:fillRect(
	-- 		shoulderXPositions[n], shoulderXPositions[n] + shoulderWidths[n],
	-- 		self.shoulders[n].Pos[2], self.shoulders[n].Pos[2] + self.shoulders[n].Size[2])
	-- end
end

return {
  InputDisplay = InputDisplay
}