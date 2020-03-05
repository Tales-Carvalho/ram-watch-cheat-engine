package.loaded.layouts = nil
local layouts = require "layouts"
package.loaded.utils = nil
local utils = require "utils"
local readIntBE = utils.readIntBE
local subclass = utils.subclass
local CompoundElement = layouts.CompoundElement
local SimpleElement = layouts.SimpleElement



-- Display a memory value using per-character images (effectively a bitmap font).
local ImageValueDisplay = subclass(CompoundElement)

function ImageValueDisplay:init(window, returnFuncOrValue, numCharacters, fontName, passedDisplayOptions)
  -- This can be any kind of MemoryValue. The only constraint is that all the possible
  -- characters that can be displayed are covered in the charImages defined below.
  self.returnFuncOrValue = returnFuncOrValue
  -- Max number of characters to show in this display. This is how many Image objects
  -- we'll maintain.
  self.numCharacters = numCharacters
  -- display options to pass into the memory value's display() method.
  self.displayOptions = {nolabel=true}

  self.fontName = fontName

  if passedDisplayOptions then
    utils.updateTable(self.displayOptions, passedDisplayOptions)
  end

  local fontDirectory = RWCEMainDirectory .. "/fonts/" .. self.fontName

  local font = require (fontDirectory .. "/font")

  self.charImageFiles = font.charImageFiles

  self.charImages = {}
  for char, charImageFilepath in pairs(self.charImageFiles) do
    self.charImages[char] = createPicture()
    self.charImages[char]:loadFromFile(fontDirectory .. charImageFilepath)
  end
  -- Empty picture to represent a space
  self.charImages[''] = createPicture()
  self.charImages[' '] = createPicture()

  local width = 41
  local height = 51
  for n=1, numCharacters do
    local uiObj = createImage(window)
    uiObj:setSize(width, height)
    -- Allow the image to stretch to fit the size
    uiObj:setStretch(false)
    local relativePosition = {width*(n-1), 0}
    self:addElement(relativePosition, uiObj)
 end

end

function ImageValueDisplay:update()
  local valueString

  if tostring(type(self.returnFuncOrValue)) == 'string' then
    valueString = self.returnFuncOrValue
  elseif tostring(type(self.returnFuncOrValue)) == 'function' then
    valueString = self.returnFuncOrValue()
  else
    valueString = self.memoryValue:display(self.displayOptions)
  end
  
  for n, element in pairs(self.elements) do
    if valueString:len() >= n then
      local char = valueString:sub(n, n)
      if self.charImages[char] == nil then
        error(
         "No image specified for '" .. char
         .. "' (full string: " .. valueString .. ")")
        --element.uiObj.setPicture(self.charImages[''])
      end
      element.uiObj.setPicture(self.charImages[char])
    else
      element.uiObj.setPicture(self.charImages[''])
    end
  end
end

return {
  ImageValueDisplay = ImageValueDisplay
}