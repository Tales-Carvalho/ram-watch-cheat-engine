package.loaded.layouts = nil
local layouts = require "layouts"
package.loaded.utils = nil
local utils = require "utils"
local readIntBE = utils.readIntBE
local subclass = utils.subclass
local CompoundElement = layouts.CompoundElement
local SimpleElement = layouts.SimpleElement

local StaticBackground = subclass(SimpleElement)

function StaticBackground:init(window, bgFile, passedDisplayOptions)

	self.bgFile = bgFile

	self.displayOptions = {nolabel=true}
	if passedDisplayOptions then
		utils.updateTable(self.displayOptions, passedDisplayOptions)
	end

	local bgPath = RWCEMainDirectory .. '/' .. self.bgFile

	self.uiObj = createImage(window)
	self.uiObj:setSize(960, 2160)
	self.uiObj:setStretch(false)

	self.bgImage = createPicture()
	self.bgImage:loadFromFile(bgPath)

	self.uiObj.setPicture(self.bgImage)
	self:setVisible(true)

end

local SA2Background = subclass(CompoundElement)

function SA2Background:init(window, bgFolder, character, passedDisplayOptions)

	self.color_array = {
		'blue', -- Sonic
		'red', -- Shadow
		'orange', -- Mechless Tails
		'gray', -- Mechless Eggman
		'red', -- Knuckles
		'purple', -- Rouge
		'orange', -- Tails
		'gray', -- Eggman
		'pink', -- Amy
		'yellow', -- Super Sonic
		'yellow', -- Super Shadow
		'black', -- ?
		'blue', -- Metal Sonic
		'black', -- Chao Walker
		'black', -- Dark Chao Walker
		'pink', -- Tikal
		'blue' -- Chaos
	}

	self.text_array = {
		'sonic',
		'sonic',
		'other',
		'other',
		'hunting',
		'hunting',
		'tails',
		'tails',
		'sonic',
		'other',
		'other',
		'other',
		'sonic',
		'other',
		'other',
		'hunting',
		'hunting'
	}

	self.bgFolder = bgFolder
	self.character = character

	self.displayOptions = {nolabel=true}
	if passedDisplayOptions then
		utils.updateTable(self.displayOptions, passedDisplayOptions)
	end

	local width = self.displayOptions.width or 960
	local height = self.displayOptions.height or 2160

	self.noBgImage = self.displayOptions.noBgImage or false

	local bgDirectory = RWCEMainDirectory .. '/' .. self.bgFolder

	if not self.noBgImage then
		self.bgColors = {}

		self.bgColors['black'] = createPicture()
		self.bgColors['black']:loadFromFile(bgDirectory .. '/black.png')

		self.bgColors['blue'] = createPicture()
		self.bgColors['blue']:loadFromFile(bgDirectory .. '/blue.png')

		self.bgColors['gray'] = createPicture()
		self.bgColors['gray']:loadFromFile(bgDirectory .. '/gray.png')

		self.bgColors['orange'] = createPicture()
		self.bgColors['orange']:loadFromFile(bgDirectory .. '/orange.png')

		self.bgColors['pink'] = createPicture()
		self.bgColors['pink']:loadFromFile(bgDirectory .. '/pink.png')

		self.bgColors['purple'] = createPicture()
		self.bgColors['purple']:loadFromFile(bgDirectory .. '/purple.png')

		self.bgColors['red'] = createPicture()
		self.bgColors['red']:loadFromFile(bgDirectory .. '/red.png')

		self.bgColors['yellow'] = createPicture()
		self.bgColors['yellow']:loadFromFile(bgDirectory .. '/yellow.png')
	end

	self.bgTexts = {}

	self.bgTexts['other'] = createPicture()
	self.bgTexts['other']:loadFromFile(bgDirectory .. '/text_other.png')

	self.bgTexts['sonic'] = createPicture()
	self.bgTexts['sonic']:loadFromFile(bgDirectory .. '/text_sonic.png')

	self.bgTexts['tails'] = createPicture()
	self.bgTexts['tails']:loadFromFile(bgDirectory .. '/text_tails.png')

	self.bgTexts['hunting'] = createPicture()
	self.bgTexts['hunting']:loadFromFile(bgDirectory .. '/text_hunting.png')

	if not self.noBgImage then
		local uiObjBack = createImage(window)
		uiObjBack:setStretch(false)
		uiObjBack:setSize(width, height)

		uiObjBack.setPicture(self.bgColors['black'])

		self:addElement({0,0}, uiObjBack)
	end

	local uiObjText = createImage(window)
	uiObjText:setStretch(false)
	uiObjText:setSize(width, height)

	uiObjText.setPicture(self.bgTexts['other'])

	self:addElement({0,0}, uiObjText)

end

function SA2Background:update()
	if self.noBgImage then
		if self.character:get() > #self.color_array then
			self.elements[1].uiObj.setPicture(self.bgTexts['other'])
		else
			self.elements[1].uiObj.setPicture(self.bgTexts[self.text_array[self.character:get() + 1]])
		end
	else
		if self.character:get() > #self.color_array then
			self.elements[1].uiObj.setPicture(self.bgColors['black'])
			self.elements[2].uiObj.setPicture(self.bgTexts['other'])
		else
			self.elements[1].uiObj.setPicture(self.bgColors[self.color_array[self.character:get() + 1]])
			self.elements[2].uiObj.setPicture(self.bgTexts[self.text_array[self.character:get() + 1]])
		end
	end

end

local SADXBackground = subclass(CompoundElement)

function SADXBackground:init(window, bgFolder, character, passedDisplayOptions)

	self.color_array = {
		'blue', -- Sonic
		'black', -- ?
		'orange', -- Tails
		'red', -- Knuckles
		'black', -- ?
		'pink', -- Amy
		'gray', -- Gamma
		'purple' -- Big
	}

	self.text_array = {
		'sonic',
		'other',
		'tails',
		'hunting',
		'other',
		'other',
		'other',
		'other'
	}

	self.bgFolder = bgFolder
	self.character = character

	self.displayOptions = {nolabel=true}
	if passedDisplayOptions then
		utils.updateTable(self.displayOptions, passedDisplayOptions)
	end

	local bgDirectory = RWCEMainDirectory .. '/' .. self.bgFolder

	self.bgColors = {}

	self.bgColors['black'] = createPicture()
	self.bgColors['black']:loadFromFile(bgDirectory .. '/black.png')

	self.bgColors['blue'] = createPicture()
	self.bgColors['blue']:loadFromFile(bgDirectory .. '/blue.png')

	self.bgColors['gray'] = createPicture()
	self.bgColors['gray']:loadFromFile(bgDirectory .. '/gray.png')

	self.bgColors['orange'] = createPicture()
	self.bgColors['orange']:loadFromFile(bgDirectory .. '/orange.png')

	self.bgColors['pink'] = createPicture()
	self.bgColors['pink']:loadFromFile(bgDirectory .. '/pink.png')

	self.bgColors['purple'] = createPicture()
	self.bgColors['purple']:loadFromFile(bgDirectory .. '/purple.png')

	self.bgColors['red'] = createPicture()
	self.bgColors['red']:loadFromFile(bgDirectory .. '/red.png')

	self.bgColors['yellow'] = createPicture()
	self.bgColors['yellow']:loadFromFile(bgDirectory .. '/yellow.png')

	self.bgTexts = {}

	self.bgTexts['other'] = createPicture()
	self.bgTexts['other']:loadFromFile(bgDirectory .. '/text_other.png')

	self.bgTexts['sonic'] = createPicture()
	self.bgTexts['sonic']:loadFromFile(bgDirectory .. '/text_sonic.png')

	self.bgTexts['tails'] = createPicture()
	self.bgTexts['tails']:loadFromFile(bgDirectory .. '/text_tails.png')

	self.bgTexts['hunting'] = createPicture()
	self.bgTexts['hunting']:loadFromFile(bgDirectory .. '/text_hunting.png')

	local uiObjBack = createImage(window)
	uiObjBack:setSize(960, 2160)
	uiObjBack:setStretch(false)

	uiObjBack.setPicture(self.bgColors['black'])

	self:addElement({0,0}, uiObjBack)

	local uiObjText = createImage(window)
	uiObjText:setSize(960, 2160)
	uiObjText:setStretch(false)

	uiObjText.setPicture(self.bgTexts['other'])

	self:addElement({0,0}, uiObjText)

end

function SADXBackground:update()

	if self.character:get() > #self.color_array then
		self.elements[1].uiObj.setPicture(self.bgColors['black'])
		self.elements[2].uiObj.setPicture(self.bgTexts['other'])
	else
		self.elements[1].uiObj.setPicture(self.bgColors[self.color_array[self.character:get() + 1]])
		self.elements[2].uiObj.setPicture(self.bgTexts[self.text_array[self.character:get() + 1]])
	end

end

local HeroesBackground = subclass(SimpleElement)

function HeroesBackground:init(window, bgFolder, activeCharacter, passedDisplayOptions)

	self.bgFolder = bgFolder
	self.activeCharacter = activeCharacter

	self.displayOptions = {nolabel=true}
	if passedDisplayOptions then
		utils.updateTable(self.displayOptions, passedDisplayOptions)
	end

	local bgDirectory = RWCEMainDirectory .. '/' .. self.bgFolder

	self.uiObj = createImage(window)
	self.uiObj:setSize(960, 2160)
	self.uiObj:setStretch(false)

	self.bgImages = {}

	self.bgImages[1] = createPicture()
	self.bgImages[1]:loadFromFile(bgDirectory .. '/sonic.png')

	self.bgImages[2] = createPicture()
	self.bgImages[2]:loadFromFile(bgDirectory .. '/tails.png')

	self.bgImages[3] = createPicture()
	self.bgImages[3]:loadFromFile(bgDirectory .. '/knuckles.png')

end

function HeroesBackground:update()

	self.uiObj.setPicture(self.bgImages[self.activeCharacter:get() + 1])
	
end

return {
	SADXBackground = SADXBackground,
	SA2Background = SA2Background,
	StaticBackground = StaticBackground,
	HeroesBackground = HeroesBackground
}