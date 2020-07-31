local width = 320
local height = 109

local backgroundFile = '/Background.png'

local buttons = {
	{File = '/A.png', Pos = {233, 47}, Size = {40,40} },
	{File = '/b-button.png', Pos = {200, 70}, Size = {24,24} },
	{File = '/X.png', Pos = {284, 42}, Size = {23,42} },
	{File = '/Y.png', Pos = {225, 16}, Size = {42,24} },
	{File = '/Start.png', Pos = {187, 36}, Size = {16,16} },
	{File = '/R.png', Pos = {6, 6}, Size = {74,13} },
	{File = '/R.png', Pos = {103, 6}, Size = {74,13} },
	{File = '/Z.png', Pos = {277, 11}, Size = {34,17} }
}

local analogMarkers = {
	{File = '/Stick.png', Pos = {21, 37}, Size = {49,49}, Range = 17 },
	{File = '/cstick.png', Pos = {126, 47}, Size = {30,30}, Range = 21 }
}

local shoulders = {
	{Color = 0xffffff, Pos = {7, 7}, Size = {73,9}, Direction = 'right' },
	{Color = 0xffffff, Pos = {104, 7}, Size = {73,9}, Direction = 'left' }
}

return {
	width = width,
	height = height,
	backgroundFile = backgroundFile,
	buttons = buttons,
	analogMarkers = analogMarkers,
	shoulders = shoulders
}