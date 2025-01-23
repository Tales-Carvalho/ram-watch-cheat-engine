local width = 765
local height = 320

local backgroundFile = '/Background.png'

local buttons = {
	{File = '/A.png', Pos = {528, 171}, Size = {108,108} },
	{File = '/B.png', Pos = {428, 233}, Size = {66,66} },
	{File = '/X.png', Pos = {673, 154}, Size = {65,117} },
	{File = '/Y.png', Pos = {498, 85}, Size = {125,63} },
	{File = '/Start.png', Pos = {341, 179}, Size = {41,41} },
	{File = '/R.png', Pos = {39, 20}, Size = {241,28} },
	{File = '/R.png', Pos = {461, 20}, Size = {241,28} },
}

local analogMarkers = {
	{File = '/Stick.png', Pos = {123, 156}, Size = {73,73}, Range = 100 },
}

local shoulders = {
	{Color = 0xffffff, Pos = {40, 23}, Size = {239,21}, Direction = 'right' },
	{Color = 0xffffff, Pos = {462, 23}, Size = {239,21}, Direction = 'left' }
}

return {
	width = width,
	height = height,
	backgroundFile = backgroundFile,
	buttons = buttons,
	analogMarkers = analogMarkers,
	shoulders = shoulders
}