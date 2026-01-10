extends Node

var player_hit: bool = false
var player_cutscene: bool = false


# Levels
var nolevel_completed:bool = true
var dummylevel_completed: bool = false
var level1_completed: bool = false
var level2_completed: bool = false
var all_levels_completed: bool = false
var dialogue1_completed: bool = false
var dialogue2_completed: bool = false
var dialogue3_completed: bool = false

func level_completion_check():
	if dummylevel_completed and level1_completed and level2_completed:
		all_levels_completed = true
