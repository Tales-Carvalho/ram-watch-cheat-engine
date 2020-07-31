local width = 960
local height = 328

local backgroundFile = '/Background.png'

local buttons = {
	{File = '/A.png', Pos = {698, 141}, Size = {120,120} },
	{File = '/b-button.png', Pos = {598, 208}, Size = {73,73} },
	{File = '/X.png', Pos = {849, 126}, Size = {70,125} },
	{File = '/Y.png', Pos = {673, 49}, Size = {126,73} },
	{File = '/Start.png', Pos = {560, 108}, Size = {48,48} },
	{File = '/R.png', Pos = {21, 17}, Size = {220,39} },
	{File = '/R.png', Pos = {311, 17}, Size = {220,39} },
	{File = '/Z.png', Pos = {830, 34}, Size = {103,52} }
}

local analogMarkers = {
	{File = '/Stick.png', Pos = {60, 109}, Size = {147,147}, Range = 50 },
	{File = '/cstick.png', Pos = {375, 138}, Size = {90,90}, Range = 63 }
}

local shoulders = {
	{Color = 0xffffff, Pos = {21, 22}, Size = {220,28} },
	{Color = 0xffffff, Pos = {312, 22}, Size = {220,28} }
}

return {
	width = width,
	height = height,
	backgroundFile = backgroundFile,
	buttons = buttons,
	analogMarkers = analogMarkers,
	shoulders = shoulders
}