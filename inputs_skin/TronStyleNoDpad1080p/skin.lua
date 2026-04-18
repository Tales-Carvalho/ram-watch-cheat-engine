local width = 480
local height = 164

local backgroundFile = '/Background.png'

local buttons = {
	{File = '/A.png', Pos = {349, 70}, Size = {60,60} },
	{File = '/b-button.png', Pos = {299, 104}, Size = {37,37} },
	{File = '/X.png', Pos = {424, 63}, Size = {35,63} },
	{File = '/Y.png', Pos = {336, 24}, Size = {63,37} },
	{File = '/Start.png', Pos = {280, 54}, Size = {24,24} },
	{File = '/R.png', Pos = {10, 8}, Size = {110,20} },
	{File = '/R.png', Pos = {155, 8}, Size = {110,20} },
	{File = '/Z.png', Pos = {415, 17}, Size = {52,26} }
}

local analogMarkers = {
	{File = '/Stick.png', Pos = {30, 54}, Size = {74,74}, Range = 25 },
	{File = '/cstick.png', Pos = {187, 69}, Size = {45,45}, Range = 31 }
}

local shoulders = {
	{Color = 0xffffff, Pos = {10, 11}, Size = {110,14}, Direction = 'right' },
	{Color = 0xffffff, Pos = {156, 11}, Size = {110,14}, Direction = 'left' }
}

return {
	width = width,
	height = height,
	backgroundFile = backgroundFile,
	buttons = buttons,
	analogMarkers = analogMarkers,
	shoulders = shoulders
}