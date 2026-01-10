extends State
class_name Death

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"
@onready var scythe: CharacterBody2D = $"../../../Scythe"
@onready var dash_particles: GPUParticles2D = $"../../DashParticles"
@onready var faces: Node2D = $"../../Faces"

func Enter():
	_update_animation()
	dash_particles.restart()
	dash_particles.emitting = true
	var mat := sprite_2d.material as ShaderMaterial
	mat.set_shader_parameter("intensity", 1.0)
	await get_tree().create_timer(0.1).timeout
	mat.set_shader_parameter("intensity", 0.0)
	await get_tree().create_timer(0.1).timeout
	faces.visible = false
	animation_player.play("death")
	
	await animation_player.animation_finished
	GameManager.player_hit = true
	#Mora se vratiti u prvo bitno stanje da za reload scene
	GameManager.player_hit = false
	get_tree().reload_current_scene()
	#scythe.queue_free() 
	#player.queue_free()
	pass
	
	
func _update_animation():
	pass
	
