name = "Living Artifact"
author = "K"
version = "1.2.2"
description = "version: "..version
api_version = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true
all_clients_require_mod = true

priority = -100

configuration_options =
{
   	{
		name = "lan",
		label = "Language/语言设置",
		options =	
		{
			{description = "English", data = "en"},
			{description = "中文", data = "cn"},
		},
		default = "en",
	},
	{
		name = "laserfire",
		label = "Small Laser Ignite/小激光点火",
		hover = "Small laser set fire on target?\n小激光点燃目标?",
		options =	
		{
			{description = "No/否", data = false},
			{description = "Yes/是", data = true},
		},
		default = false,
	},
	{
		name = "duration",
		label = "Armor Duration/装甲耐久",
		options = 
		{
			{description = "Original (3 min)", data = 3},
			{description = "1 day (8 min)", data = 8},
			{description = "3 days (24 min)", data = 24},
			{description = "5 days (40 min)", data = 40},
			{description = "10 days (80 min)", data = 80},
		},
		default = 3,
	},
	{
		name = "bgm",
		label = "Iron Lord BGM/穿戴时背景音乐",
		options = 
		{
			{description = "On/开", data = true},
			{description = "Off/关", data = false},
		},
		default = true,
	},
}