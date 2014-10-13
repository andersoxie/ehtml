note
	description: "[
		HTML Color Constants
		]"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_COLOR_CONSTANTS

feature -- Access

	color_hash: HASH_TABLE [TUPLE [color_name: STRING; red, green, blue: INTEGER], STRING]
			-- Hash table of HTML colors (names and RGB values by HEX-value hash key).
		note
			EIS: "name:Colors", "src=http://www.w3schools.com/cssref/css_colornames.asp", "protocol=URI"
		once
			create Result.make (color_csv.occurrences ('%N'))
			across color_csv.split ('%N') as ic_colors loop
				check attached {STRING} ic_colors.item as al_line then
					check attached {LIST [STRING]} al_line.split (',') as al_list then
						Result.force ([al_list [1], al_list [3].to_integer, al_list [4].to_integer, al_list [5].to_integer], al_list [2])
					end
				end
			end
		end

feature -- Status Report

	rgb_for_name (a_name: STRING): TUPLE [red, green, blue: INTEGER]
			-- RGB TUPLE for `a_name' in `color_hash'
		note
			intent: "[
				rgb_for_name ({HTML_COLOR_CONSTANTS}.[Color_name]) --> [R, G, B]
				]"
		do
			check has_name_and_index: attached {INTEGER} hash_index_for_name (a_name) as al_index and then al_index > 0 then
				Result := [color_hash.iteration_item (al_index).red, color_hash.iteration_item (al_index).green, color_hash.iteration_item (al_index).blue]
			end
		end

	hash_index_for_name (a_name: STRING): INTEGER
			-- `color_hash' index for `a_name'.
		require
			has_name: across color_hash as ic_colors some ic_colors.item.color_name.same_string (a_name) end
		local
			i: INTEGER
		do
			from color_hash.start
			until color_hash.after or Result > 0
			loop
				if color_hash.item_for_iteration.color_name.same_string (a_name) then
					Result := i
				end
				i := i + 1
				color_hash.forth
			end
		ensure
			has_result: Result > 0
		end

feature -- Access: Colors

	AliceBlue: STRING once check attached color_hash.at ("#F0F8FF") as al_result then Result := al_result.color_name end end
	AntiqueWhite: STRING once check attached color_hash.at ("#FAEBD7") as al_result then Result := al_result.color_name end end
	Aqua: STRING once check attached color_hash.at ("#00FFFF") as al_result then Result := al_result.color_name end end
	Aquamarine: STRING once check attached color_hash.at ("#7FFFD4") as al_result then Result := al_result.color_name end end
	Azure: STRING once check attached color_hash.at ("#F0FFFF") as al_result then Result := al_result.color_name end end
	Beige: STRING once check attached color_hash.at ("#F5F5DC") as al_result then Result := al_result.color_name end end
	Bisque: STRING once check attached color_hash.at ("#FFE4C4") as al_result then Result := al_result.color_name end end
	Black: STRING once check attached color_hash.at ("#000000") as al_result then Result := al_result.color_name end end
	BlanchedAlmond: STRING once check attached color_hash.at ("#FFEBCD") as al_result then Result := al_result.color_name end end
	Blue: STRING once check attached color_hash.at ("#0000FF") as al_result then Result := al_result.color_name end end
	BlueViolet: STRING once check attached color_hash.at ("#8A2BE2") as al_result then Result := al_result.color_name end end
	Brown: STRING once check attached color_hash.at ("#A52A2A") as al_result then Result := al_result.color_name end end
	BurlyWood: STRING once check attached color_hash.at ("#DEB887") as al_result then Result := al_result.color_name end end
	CadetBlue: STRING once check attached color_hash.at ("#5F9EA0") as al_result then Result := al_result.color_name end end
	Chartreuse: STRING once check attached color_hash.at ("#7FFF00") as al_result then Result := al_result.color_name end end
	Chocolate: STRING once check attached color_hash.at ("#D2691E") as al_result then Result := al_result.color_name end end
	Coral: STRING once check attached color_hash.at ("#FF7F50") as al_result then Result := al_result.color_name end end
	CornflowerBlue: STRING once check attached color_hash.at ("#6495ED") as al_result then Result := al_result.color_name end end
	Cornsilk: STRING once check attached color_hash.at ("#FFF8DC") as al_result then Result := al_result.color_name end end
	Crimson: STRING once check attached color_hash.at ("#DC143C") as al_result then Result := al_result.color_name end end
	Cyan: STRING once check attached color_hash.at ("#00FFFF") as al_result then Result := al_result.color_name end end
	DarkBlue: STRING once check attached color_hash.at ("#00008B") as al_result then Result := al_result.color_name end end
	DarkCyan: STRING once check attached color_hash.at ("#008B8B") as al_result then Result := al_result.color_name end end
	DarkGoldenRod: STRING once check attached color_hash.at ("#B8860B") as al_result then Result := al_result.color_name end end
	DarkGray: STRING once check attached color_hash.at ("#A9A9A9") as al_result then Result := al_result.color_name end end
	DarkGreen: STRING once check attached color_hash.at ("#006400") as al_result then Result := al_result.color_name end end
	DarkKhaki: STRING once check attached color_hash.at ("#BDB76B") as al_result then Result := al_result.color_name end end
	DarkMagenta: STRING once check attached color_hash.at ("#8B008B") as al_result then Result := al_result.color_name end end
	DarkOliveGreen: STRING once check attached color_hash.at ("#556B2F") as al_result then Result := al_result.color_name end end
	DarkOrange: STRING once check attached color_hash.at ("#FF8C00") as al_result then Result := al_result.color_name end end
	DarkOrchid: STRING once check attached color_hash.at ("#9932CC") as al_result then Result := al_result.color_name end end
	DarkRed: STRING once check attached color_hash.at ("#8B0000") as al_result then Result := al_result.color_name end end
	DarkSalmon: STRING once check attached color_hash.at ("#E9967A") as al_result then Result := al_result.color_name end end
	DarkSeaGreen: STRING once check attached color_hash.at ("#8FBC8F") as al_result then Result := al_result.color_name end end
	DarkSlateBlue: STRING once check attached color_hash.at ("#483D8B") as al_result then Result := al_result.color_name end end
	DarkSlateGray: STRING once check attached color_hash.at ("#2F4F4F") as al_result then Result := al_result.color_name end end
	DarkTurquoise: STRING once check attached color_hash.at ("#00CED1") as al_result then Result := al_result.color_name end end
	DarkViolet: STRING once check attached color_hash.at ("#9400D3") as al_result then Result := al_result.color_name end end
	DeepPink: STRING once check attached color_hash.at ("#FF1493") as al_result then Result := al_result.color_name end end
	DeepSkyBlue: STRING once check attached color_hash.at ("#00BFFF") as al_result then Result := al_result.color_name end end
	DimGray: STRING once check attached color_hash.at ("#696969") as al_result then Result := al_result.color_name end end
	DodgerBlue: STRING once check attached color_hash.at ("#1E90FF") as al_result then Result := al_result.color_name end end
	FireBrick: STRING once check attached color_hash.at ("#B22222") as al_result then Result := al_result.color_name end end
	FloralWhite: STRING once check attached color_hash.at ("#FFFAF0") as al_result then Result := al_result.color_name end end
	ForestGreen: STRING once check attached color_hash.at ("#228B22") as al_result then Result := al_result.color_name end end
	Fuchsia: STRING once check attached color_hash.at ("#FF00FF") as al_result then Result := al_result.color_name end end
	Gainsboro: STRING once check attached color_hash.at ("#DCDCDC") as al_result then Result := al_result.color_name end end
	GhostWhite: STRING once check attached color_hash.at ("#F8F8FF") as al_result then Result := al_result.color_name end end
	Gold: STRING once check attached color_hash.at ("#FFD700") as al_result then Result := al_result.color_name end end
	GoldenRod: STRING once check attached color_hash.at ("#DAA520") as al_result then Result := al_result.color_name end end
	Gray: STRING once check attached color_hash.at ("#808080") as al_result then Result := al_result.color_name end end
	Green: STRING once check attached color_hash.at ("#008000") as al_result then Result := al_result.color_name end end
	GreenYellow: STRING once check attached color_hash.at ("#ADFF2F") as al_result then Result := al_result.color_name end end
	HoneyDew: STRING once check attached color_hash.at ("#F0FFF0") as al_result then Result := al_result.color_name end end
	HotPink: STRING once check attached color_hash.at ("#FF69B4") as al_result then Result := al_result.color_name end end
	IndianRed : STRING once check attached color_hash.at ("#CD5C5C") as al_result then Result := al_result.color_name end end
	Indigo : STRING once check attached color_hash.at ("#4B0082") as al_result then Result := al_result.color_name end end
	Ivory: STRING once check attached color_hash.at ("#FFFFF0") as al_result then Result := al_result.color_name end end
	Khaki: STRING once check attached color_hash.at ("#F0E68C") as al_result then Result := al_result.color_name end end
	Lavender: STRING once check attached color_hash.at ("#E6E6FA") as al_result then Result := al_result.color_name end end
	LavenderBlush: STRING once check attached color_hash.at ("#FFF0F5") as al_result then Result := al_result.color_name end end
	LawnGreen: STRING once check attached color_hash.at ("#7CFC00") as al_result then Result := al_result.color_name end end
	LemonChiffon: STRING once check attached color_hash.at ("#FFFACD") as al_result then Result := al_result.color_name end end
	LightBlue: STRING once check attached color_hash.at ("#ADD8E6") as al_result then Result := al_result.color_name end end
	LightCoral: STRING once check attached color_hash.at ("#F08080") as al_result then Result := al_result.color_name end end
	LightCyan: STRING once check attached color_hash.at ("#E0FFFF") as al_result then Result := al_result.color_name end end
	LightGoldenRodYellow: STRING once check attached color_hash.at ("#FAFAD2") as al_result then Result := al_result.color_name end end
	LightGray: STRING once check attached color_hash.at ("#D3D3D3") as al_result then Result := al_result.color_name end end
	LightGreen: STRING once check attached color_hash.at ("#90EE90") as al_result then Result := al_result.color_name end end
	LightPink: STRING once check attached color_hash.at ("#FFB6C1") as al_result then Result := al_result.color_name end end
	LightSalmon: STRING once check attached color_hash.at ("#FFA07A") as al_result then Result := al_result.color_name end end
	LightSeaGreen: STRING once check attached color_hash.at ("#20B2AA") as al_result then Result := al_result.color_name end end
	LightSkyBlue: STRING once check attached color_hash.at ("#87CEFA") as al_result then Result := al_result.color_name end end
	LightSlateGray: STRING once check attached color_hash.at ("#778899") as al_result then Result := al_result.color_name end end
	LightSteelBlue: STRING once check attached color_hash.at ("#B0C4DE") as al_result then Result := al_result.color_name end end
	LightYellow: STRING once check attached color_hash.at ("#FFFFE0") as al_result then Result := al_result.color_name end end
	Lime: STRING once check attached color_hash.at ("#00FF00") as al_result then Result := al_result.color_name end end
	LimeGreen: STRING once check attached color_hash.at ("#32CD32") as al_result then Result := al_result.color_name end end
	Linen: STRING once check attached color_hash.at ("#FAF0E6") as al_result then Result := al_result.color_name end end
	Magenta: STRING once check attached color_hash.at ("#FF00FF") as al_result then Result := al_result.color_name end end
	Maroon: STRING once check attached color_hash.at ("#800000") as al_result then Result := al_result.color_name end end
	MediumAquaMarine: STRING once check attached color_hash.at ("#66CDAA") as al_result then Result := al_result.color_name end end
	MediumBlue: STRING once check attached color_hash.at ("#0000CD") as al_result then Result := al_result.color_name end end
	MediumOrchid: STRING once check attached color_hash.at ("#BA55D3") as al_result then Result := al_result.color_name end end
	MediumPurple: STRING once check attached color_hash.at ("#9370DB") as al_result then Result := al_result.color_name end end
	MediumSeaGreen: STRING once check attached color_hash.at ("#3CB371") as al_result then Result := al_result.color_name end end
	MediumSlateBlue: STRING once check attached color_hash.at ("#7B68EE") as al_result then Result := al_result.color_name end end
	MediumSpringGreen: STRING once check attached color_hash.at ("#00FA9A") as al_result then Result := al_result.color_name end end
	MediumTurquoise: STRING once check attached color_hash.at ("#48D1CC") as al_result then Result := al_result.color_name end end
	MediumVioletRed: STRING once check attached color_hash.at ("#C71585") as al_result then Result := al_result.color_name end end
	MidnightBlue: STRING once check attached color_hash.at ("#191970") as al_result then Result := al_result.color_name end end
	MintCream: STRING once check attached color_hash.at ("#F5FFFA") as al_result then Result := al_result.color_name end end
	MistyRose: STRING once check attached color_hash.at ("#FFE4E1") as al_result then Result := al_result.color_name end end
	Moccasin: STRING once check attached color_hash.at ("#FFE4B5") as al_result then Result := al_result.color_name end end
	NavajoWhite: STRING once check attached color_hash.at ("#FFDEAD") as al_result then Result := al_result.color_name end end
	Navy: STRING once check attached color_hash.at ("#000080") as al_result then Result := al_result.color_name end end
	OldLace: STRING once check attached color_hash.at ("#FDF5E6") as al_result then Result := al_result.color_name end end
	Olive: STRING once check attached color_hash.at ("#808000") as al_result then Result := al_result.color_name end end
	OliveDrab: STRING once check attached color_hash.at ("#6B8E23") as al_result then Result := al_result.color_name end end
	Orange: STRING once check attached color_hash.at ("#FFA500") as al_result then Result := al_result.color_name end end
	OrangeRed: STRING once check attached color_hash.at ("#FF4500") as al_result then Result := al_result.color_name end end
	Orchid: STRING once check attached color_hash.at ("#DA70D6") as al_result then Result := al_result.color_name end end
	PaleGoldenRod: STRING once check attached color_hash.at ("#EEE8AA") as al_result then Result := al_result.color_name end end
	PaleGreen: STRING once check attached color_hash.at ("#98FB98") as al_result then Result := al_result.color_name end end
	PaleTurquoise: STRING once check attached color_hash.at ("#AFEEEE") as al_result then Result := al_result.color_name end end
	PaleVioletRed: STRING once check attached color_hash.at ("#DB7093") as al_result then Result := al_result.color_name end end
	PapayaWhip: STRING once check attached color_hash.at ("#FFEFD5") as al_result then Result := al_result.color_name end end
	PeachPuff: STRING once check attached color_hash.at ("#FFDAB9") as al_result then Result := al_result.color_name end end
	Peru: STRING once check attached color_hash.at ("#CD853F") as al_result then Result := al_result.color_name end end
	Pink: STRING once check attached color_hash.at ("#FFC0CB") as al_result then Result := al_result.color_name end end
	Plum: STRING once check attached color_hash.at ("#DDA0DD") as al_result then Result := al_result.color_name end end
	PowderBlue: STRING once check attached color_hash.at ("#B0E0E6") as al_result then Result := al_result.color_name end end
	Purple: STRING once check attached color_hash.at ("#800080") as al_result then Result := al_result.color_name end end
	Red: STRING once check attached color_hash.at ("#FF0000") as al_result then Result := al_result.color_name end end
	RosyBrown: STRING once check attached color_hash.at ("#BC8F8F") as al_result then Result := al_result.color_name end end
	RoyalBlue: STRING once check attached color_hash.at ("#4169E1") as al_result then Result := al_result.color_name end end
	SaddleBrown: STRING once check attached color_hash.at ("#8B4513") as al_result then Result := al_result.color_name end end
	Salmon: STRING once check attached color_hash.at ("#FA8072") as al_result then Result := al_result.color_name end end
	SandyBrown: STRING once check attached color_hash.at ("#F4A460") as al_result then Result := al_result.color_name end end
	SeaGreen: STRING once check attached color_hash.at ("#2E8B57") as al_result then Result := al_result.color_name end end
	SeaShell: STRING once check attached color_hash.at ("#FFF5EE") as al_result then Result := al_result.color_name end end
	Sienna: STRING once check attached color_hash.at ("#A0522D") as al_result then Result := al_result.color_name end end
	Silver: STRING once check attached color_hash.at ("#C0C0C0") as al_result then Result := al_result.color_name end end
	SkyBlue: STRING once check attached color_hash.at ("#87CEEB") as al_result then Result := al_result.color_name end end
	SlateBlue: STRING once check attached color_hash.at ("#6A5ACD") as al_result then Result := al_result.color_name end end
	SlateGray: STRING once check attached color_hash.at ("#708090") as al_result then Result := al_result.color_name end end
	Snow: STRING once check attached color_hash.at ("#FFFAFA") as al_result then Result := al_result.color_name end end
	SpringGreen: STRING once check attached color_hash.at ("#00FF7F") as al_result then Result := al_result.color_name end end
	SteelBlue: STRING once check attached color_hash.at ("#4682B4") as al_result then Result := al_result.color_name end end
	Tan: STRING once check attached color_hash.at ("#D2B48C") as al_result then Result := al_result.color_name end end
	Teal: STRING once check attached color_hash.at ("#008080") as al_result then Result := al_result.color_name end end
	Thistle: STRING once check attached color_hash.at ("#D8BFD8") as al_result then Result := al_result.color_name end end
	Tomato: STRING once check attached color_hash.at ("#FF6347") as al_result then Result := al_result.color_name end end
	Turquoise: STRING once check attached color_hash.at ("#40E0D0") as al_result then Result := al_result.color_name end end
	Violet: STRING once check attached color_hash.at ("#EE82EE") as al_result then Result := al_result.color_name end end
	Wheat: STRING once check attached color_hash.at ("#F5DEB3") as al_result then Result := al_result.color_name end end
	White: STRING once check attached color_hash.at ("#FFFFFF") as al_result then Result := al_result.color_name end end
	WhiteSmoke: STRING once check attached color_hash.at ("#F5F5F5") as al_result then Result := al_result.color_name end end
	Yellow: STRING once check attached color_hash.at ("#FFFF00") as al_result then Result := al_result.color_name end end
	YellowGreen: STRING once check attached color_hash.at ("#9ACD32") as al_result then Result := al_result.color_name end end


	color_csv: STRING = "[
AliceBlue,#F0F8FF,240,248,255     
AntiqueWhite,#FAEBD7,250,235,215 
Aqua,#00FFFF,0,255,255  
Aquamarine,#7FFFD4,127,255,212 
Azure,#F0FFFF,240,255,255 
Beige,#F5F5DC,245,245,220 
Bisque,#FFE4C4,255,228,196 
Black,#000000,0,0,0  
BlanchedAlmond,#FFEBCD,255,235,205 
Blue,#0000FF,0,0,255  
BlueViolet,#8A2BE2,138,43,226  
Brown,#A52A2A,165,42,42  
BurlyWood,#DEB887,222,184,135 
CadetBlue,#5F9EA0,95,158,160  
Chartreuse,#7FFF00,127,255,0  
Chocolate,#D2691E,210,105,30  
Coral,#FF7F50,255,127,80  
CornflowerBlue,#6495ED,100,149,237 
Cornsilk,#FFF8DC,255,248,220 
Crimson,#DC143C,220,20,60  
Cyan,#00FFFF,0,255,255  
DarkBlue,#00008B,0,0,139  
DarkCyan,#008B8B,0,139,139  
DarkGoldenRod,#B8860B,184,134,11  
DarkGray,#A9A9A9,169,169,169 
DarkGreen,#006400,0,100,0  
DarkKhaki,#BDB76B,189,183,107 
DarkMagenta,#8B008B,139,0,139  
DarkOliveGreen,#556B2F,85,107,47  
DarkOrange,#FF8C00,255,140,0  
DarkOrchid,#9932CC,153,50,204  
DarkRed,#8B0000,139,0,0  
DarkSalmon,#E9967A,233,150,122 
DarkSeaGreen,#8FBC8F,143,188,143 
DarkSlateBlue,#483D8B,72,61,139  
DarkSlateGray,#2F4F4F,47,79,79  
DarkTurquoise,#00CED1,0,206,209  
DarkViolet,#9400D3,148,0,211  
DeepPink,#FF1493,255,20,147  
DeepSkyBlue,#00BFFF,0,191,255  
DimGray,#696969,105,105,105 
DodgerBlue,#1E90FF,30,144,255  
FireBrick,#B22222,178,34,34  
FloralWhite,#FFFAF0,255,250,240 
ForestGreen,#228B22,34,139,34  
Fuchsia,#FF00FF,255,0,255  
Gainsboro,#DCDCDC,220,220,220 
GhostWhite,#F8F8FF,248,248,255 
Gold,#FFD700,255,215,0  
GoldenRod,#DAA520,218,165,32  
Gray,#808080,128,128,128 
Green,#008000,0,128,0  
GreenYellow,#ADFF2F,173,255,47  
HoneyDew,#F0FFF0,240,255,240 
HotPink,#FF69B4,255,105,180 
IndianRed ,#CD5C5C,205,92,92  
Indigo ,#4B0082,75,0,130  
Ivory,#FFFFF0,255,255,240 
Khaki,#F0E68C,240,230,140 
Lavender,#E6E6FA,230,230,250 
LavenderBlush,#FFF0F5,255,240,245 
LawnGreen,#7CFC00,124,252,0  
LemonChiffon,#FFFACD,255,250,205 
LightBlue,#ADD8E6,173,216,230 
LightCoral,#F08080,240,128,128 
LightCyan,#E0FFFF,224,255,255 
LightGoldenRodYellow,#FAFAD2,250,250,210 
LightGray,#D3D3D3,211,211,211 
LightGreen,#90EE90,144,238,144 
LightPink,#FFB6C1,255,182,193 
LightSalmon,#FFA07A,255,160,122 
LightSeaGreen,#20B2AA,32,178,170  
LightSkyBlue,#87CEFA,135,206,250 
LightSlateGray,#778899,119,136,153 
LightSteelBlue,#B0C4DE,176,196,222 
LightYellow,#FFFFE0,255,255,224 
Lime,#00FF00,0,255,0  
LimeGreen,#32CD32,50,205,50  
Linen,#FAF0E6,250,240,230 
Magenta,#FF00FF,255,0,255  
Maroon,#800000,128,0,0  
MediumAquaMarine,#66CDAA,102,205,170 
MediumBlue,#0000CD,0,0,205  
MediumOrchid,#BA55D3,186,85,211  
MediumPurple,#9370DB,147,112,219 
MediumSeaGreen,#3CB371,60,179,113  
MediumSlateBlue,#7B68EE,123,104,238 
MediumSpringGreen,#00FA9A,0,250,154  
MediumTurquoise,#48D1CC,72,209,204  
MediumVioletRed,#C71585,199,21,133  
MidnightBlue,#191970,25,25,112  
MintCream,#F5FFFA,245,255,250 
MistyRose,#FFE4E1,255,228,225 
Moccasin,#FFE4B5,255,228,181 
NavajoWhite,#FFDEAD,255,222,173 
Navy,#000080,0,0,128  
OldLace,#FDF5E6,253,245,230 
Olive,#808000,128,128,0  
OliveDrab,#6B8E23,107,142,35  
Orange,#FFA500,255,165,0  
OrangeRed,#FF4500,255,69,0  
Orchid,#DA70D6,218,112,214 
PaleGoldenRod,#EEE8AA,238,232,170 
PaleGreen,#98FB98,152,251,152 
PaleTurquoise,#AFEEEE,175,238,238 
PaleVioletRed,#DB7093,219,112,147 
PapayaWhip,#FFEFD5,255,239,213 
PeachPuff,#FFDAB9,255,218,185 
Peru,#CD853F,205,133,63  
Pink,#FFC0CB,255,192,203 
Plum,#DDA0DD,221,160,221 
PowderBlue,#B0E0E6,176,224,230 
Purple,#800080,128,0,128  
Red,#FF0000,255,0,0  
RosyBrown,#BC8F8F,188,143,143 
RoyalBlue,#4169E1,65,105,225  
SaddleBrown,#8B4513,139,69,19  
Salmon,#FA8072,250,128,114 
SandyBrown,#F4A460,244,164,96  
SeaGreen,#2E8B57,46,139,87  
SeaShell,#FFF5EE,255,245,238 
Sienna,#A0522D,160,82,45  
Silver,#C0C0C0,192,192,192 
SkyBlue,#87CEEB,135,206,235 
SlateBlue,#6A5ACD,106,90,205  
SlateGray,#708090,112,128,144 
Snow,#FFFAFA,255,250,250 
SpringGreen,#00FF7F,0,255,127  
SteelBlue,#4682B4,70,130,180  
Tan,#D2B48C,210,180,140 
Teal,#008080,0,128,128  
Thistle,#D8BFD8,216,191,216 
Tomato,#FF6347,255,99,71  
Turquoise,#40E0D0,64,224,208  
Violet,#EE82EE,238,130,238 
Wheat,#F5DEB3,245,222,179 
White,#FFFFFF,255,255,255 
WhiteSmoke,#F5F5F5,245,245,245 
Yellow,#FFFF00,255,255,0  
YellowGreen,#9ACD32,154,205,50
]"

note
	copyright: "[
			Eiffel Forum License, version 2

			Permission is hereby granted to use, copy, modify and/or distribute
			this package, provided that: copyright notices are retained unchanged,
			any distribution of this package, whether modified or not, includes
			this license text.  Permission is hereby also granted to distribute
			binary programs which depend on this package. If the binary program
			depends on a modified version of this package, you are encouraged to
			publicly release the modified version of this package.
			***********************

			THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT WARRANTY. ANY EXPRESS OR
			IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
			WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
			DISCLAIMED. IN NO EVENT SHALL THE AUTHORS BE LIABLE TO ANY PARTY FOR
			ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
			DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THIS PACKAGE.
			***********************
		]"
end
