extends Node

const INTRO_SCREEN = preload("uid://drcscnouos2qo")




var scene_index: int = 0
var current_scene: PackedScene = null 

# Add all the scenes created
var scenes: Array[PackedScene] = [
]


func _ready() -> void:
	# wait for all the nodes to load
	#call_deferred("_load_scene", scene_index)
	pass
	
	
func _next_scene():
	#if the project is not played from the beginning it will load the wrong scenes
	scene_index += 1
	_load_scene()
	
	
func _load_scene() -> void:
	current_scene = scenes[scene_index]
	get_tree().change_scene_to_packed(current_scene)
