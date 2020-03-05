local width = 512
local height = 256

local backgroundFile = '/background.png'

local buttons = {
	{File = '/a.png', Pos = {302, 59}, Size = {75,75} },
	{File = '/b.png', Pos = {245, 110}, Size = {48,48} },
	{File = '/x.png', Pos = {384, 50}, Size = {44,66} },
	{File = '/y.png', Pos = {288, 12}, Size = {65,42} },
	{File = '/start.png', Pos = {298, 188}, Size = {35,35} },
	{File = '/trigger_d.png', Pos = {443, 220}, Size = {20,20} },
	{File = '/trigger_d.png', Pos = {472, 220}, Size = {20,20} },
	{File = '/z.png', Pos = {442, 17}, Size = {50,20} },
	{File = '/up.png', Pos = {231, 170}, Size = {24,35} },
	{File = '/down.png', Pos = {231, 205}, Size = {24,36} },
	{File = '/right.png', Pos = {243, 193}, Size = {35,24} },
	{File = '/left.png', Pos = {208, 193}, Size = {35,24} }
}

local analogMarkers = {
	{File = '/analog_marker.png', Pos = {96, 113}, Size = {30,30}, Range = 76 },
	{File = '/c_marker.png', Pos = {380, 197}, Size = {15,15}, Range = 22 }
}

local shoulders = {
	{File = '/trigger_a.png', Pos = {443, 51}, Size = {20,160} },
	{File = '/trigger_a.png', Pos = {472, 51}, Size = {20,160} }
}

return {
	width = width,
	height = height,
	backgroundFile = backgroundFile,
	buttons = buttons,
	analogMarkers = analogMarkers,
	shoulders = shoulders
}