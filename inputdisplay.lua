package.loaded.layouts = nil
local layouts = require "layouts"
package.loaded.utils = nil
local utils = require "utils"
local readIntBE = utils.readIntBE
local subclass = utils.subclass
local CompoundElement = layouts.CompoundElement
local SimpleElement = layouts.SimpleElement

local InputDisplay = subclass(CompoundElement)

function InputDisplay:init(window, style, controllerData1, controllerData2, passedDisplayOptions)

  	self.style = style

  	self.controllerData1 = controllerData1
  	self.controllerData2 = controllerData2
	
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

	self.shoulderImages = {}

	for n, shoulder in pairs(self.shoulders) do
		self.shoulderImages[n] = createPicture()
		local uiObj2 = createImage(window)
		uiObj2:setSize(shoulder.Size[1], shoulder.Size[2])
		local canvas = uiObj2:getCanvas()
		canvas:getBrush():setColor(shoulder.Color)
		canvas:getPen():setColor(shoulder.Color)
		canvas:rect(0,0,shoulder.Size[1],shoulder.Size[2])
		self:addElement(shoulder.Pos, uiObj2)
	end

end

local controllerData1Value = 0
local controllerData2Value = 0

local buttonPresses = {}
local mainXPos = 0
local mainYPos = 0
local mainRadius = 0
local cXPos = 0
local cYPos = 0
local cRadius = 0
local analogPositions = {}
local shoulderValues = {0, 0}

function InputDisplay:update()
	
	controllerData1Value = self.controllerData1:get()
	controllerData2Value = self.controllerData2:get()

	buttonPresses = {
		controllerData1Value & 0x01000000, -- A
		controllerData1Value & 0x02000000, -- B
		controllerData1Value & 0x04000000, -- X
		controllerData1Value & 0x08000000, -- Y
		controllerData1Value & 0x10000000, -- S
		controllerData1Value & 0x00400000, -- L
		controllerData1Value & 0x00200000, -- R
		controllerData1Value & 0x00100000, -- Z
		controllerData1Value & 0x00080000, -- D-up
		controllerData1Value & 0x00040000, -- D-down
		controllerData1Value & 0x00020000, -- D-right
		controllerData1Value & 0x00010000, -- D-left
	}
	
	self.elements[1].uiObj.setPicture(self.background)
	
	for n, buttonImage in pairs(self.buttonImages) do
		self.elements[n+1].uiObj.setPicture(buttonImage)
		self.elements[n+1].uiObj.setVisible(buttonPresses[n] ~= 0)
	end
	
	mainXPos = ((controllerData1Value & 0x0000ff00) / 0x100 - 128) / 128
	mainYPos = ((controllerData1Value & 0x000000ff) - 128) / 128
	mainRadius = math.sqrt(mainXPos * mainXPos + mainYPos * mainYPos)
	
	if mainRadius > 1 then
		mainXPos = mainXPos / mainRadius
		mainYPos = mainYPos / mainRadius
	end
	
	cXPos = ((controllerData2Value & 0xff000000) / 0x1000000 - 128) / 128
	cYPos = ((controllerData2Value & 0x00ff0000) / 0x10000 - 128) / 128
	cRadius =  math.sqrt(cXPos * cXPos + cYPos * cYPos)
	
	if cRadius > 1 then
		cXPos = cXPos / cRadius
		cYPos = cYPos / cRadius
	end
	
	analogPositions = {
		{ self:getLeft() + mainXPos * self.analogMarkers[1].Range + self.analogMarkers[1].Pos[1], self:getTop() - mainYPos * self.analogMarkers[1].Range + self.analogMarkers[1].Pos[2] },
		-- { self:getLeft() + cXPos * self.analogMarkers[2].Range + self.analogMarkers[2].Pos[1], self:getTop() - cYPos * self.analogMarkers[2].Range + self.analogMarkers[2].Pos[2] }
	}
	if #self.analogMarkers == 2 then
		analogPositions[2] = { self:getLeft() + cXPos * self.analogMarkers[2].Range + self.analogMarkers[2].Pos[1], self:getTop() - cYPos * self.analogMarkers[2].Range + self.analogMarkers[2].Pos[2] }
	end
	
	for n, analogImage in pairs(self.analogImages) do
		self.elements[#self.buttonImages+1+n].uiObj.setPicture(analogImage)
		self.elements[#self.buttonImages+1+n].uiObj.setPosition(analogPositions[n][1], analogPositions[n][2])
	end

	if self.shoulders[1].Direction == 'left' or self.shoulders[1].Direction == 'right' then
		shoulderValues[1] = ((controllerData2Value & 0x0000ff00) / 0x100) * self.shoulders[1].Size[1] / 255
	else
		shoulderValues[1] = ((controllerData2Value & 0x0000ff00) / 0x100) * self.shoulders[1].Size[2] / 255
	end

	if self.shoulders[2].Direction == 'left' or self.shoulders[2].Direction == 'right' then
		shoulderValues[2] = (controllerData2Value & 0x000000ff) * self.shoulders[2].Size[1] / 255
	else
		shoulderValues[2] = (controllerData2Value & 0x000000ff) * self.shoulders[2].Size[2] / 255
	end

	for n, shoulder in pairs(self.shoulders) do
		if shoulder.Direction == 'right' then
			self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setPosition(
				self:getLeft() + shoulder.Pos[1],
				self:getTop() + shoulder.Pos[2]
			)
			self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setSize(
				shoulderValues[n],
				shoulder.Size[2]
			)
		elseif shoulder.Direction == 'left' then
			self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setPosition(
				self:getLeft() + shoulder.Pos[1] + shoulder.Size[1] - shoulderValues[n],
				self:getTop() + shoulder.Pos[2]
			)
			self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setSize(
				shoulderValues[n], 
				shoulder.Size[2]
			)
		elseif shoulder.Direction == 'down' then
			self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setPosition(
				self:getLeft() + shoulder.Pos[1],
				self:getTop() + shoulder.Pos[2]
			)
			self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setSize(
				shoulder.Size[1],
				shoulderValues[n]
			)
		elseif shoulder.Direction == 'up' then
			self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setPosition(
				self:getLeft() + shoulder.Pos[1],
				self:getTop() + shoulder.Pos[2] + shoulder.Size[2] - shoulderValues[n]
			)
			self.elements[#self.buttonImages+#self.analogImages+1+n].uiObj.setSize(
				shoulder.Size[1],
				shoulderValues[n]
			)
		end
	end
end

return {
  InputDisplay = InputDisplay
}