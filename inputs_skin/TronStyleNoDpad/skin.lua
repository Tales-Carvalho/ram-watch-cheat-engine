local width = 351
local height = 120

local backgroundFile = '/Background.png'

local buttons = {
	{File = '/A.png', Pos = {255, 53}, Size = {43,43} },
	{File = '/b-button.png', Pos = {220, 77}, Size = {25,25} },
	{File = '/X.png', Pos = {308, 46}, Size = {25,47} },
	{File = '/Y.png', Pos = {247, 20}, Size = {48,27} },
	{File = '/Start.png', Pos = {203, 40}, Size = {20,20} },
	{File = '/R.png', Pos = {6, 7}, Size = {83,12} },
	{File = '/R.png', Pos = {110, 7}, Size = {83,12} },
	{File = '/Z.png', Pos = {300, 12}, Size = {41,20} }
}

local analogMarkers = {
	{File = '/Stick.png', Pos = {23, 41}, Size = {51,51}, Range = 22 },
	{File = '/cstick.png', Pos = {137, 51}, Size = {33,33}, Range = 20 }
}

local shoulders = {
	{File = '/R.png', Pos = {6, 7}, Size = {83,12} },
	{File = '/R.png', Pos = {110, 7}, Size = {83,12} }
}

return {
	width = width,
	height = height,
	backgroundFile = backgroundFile,
	buttons = buttons,
	analogMarkers = analogMarkers,
	shoulders = shoulders
}