package.loaded.layouts = nil
local layouts = require "layouts"
package.loaded.utils = nil
local utils = require "utils"
local readIntBE = utils.readIntBE
local subclass = utils.subclass
local SimpleElement = layouts.SimpleElement

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

	local activeCharacterValue = self.activeCharacter:get()

	-- local img = createPicture()
	-- img:loadFromFile(RWCEMainDirectory .. '/' .. self.bgFolder .. '/sonic.png')

	self.uiObj.setPicture(self.bgImages[activeCharacterValue + 1])
	self:setVisible(true)
end

return {
	HeroesBackground = HeroesBackground
}