extends State
class_name Dash

@export var dash_curve: Curve
@export var player: CharacterBody2D
@onready var dash_particles: GPUParticles2D = $"../../DashParticles"

#@onready var player = get_tree().get_first_node_in_group("Player")
@onready var collision_shape_2d: CollisionShape2D = $"../../CollisionShape2D"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var dash_start_position: Vector2 = Vector2.ZERO
var dash_direction = 0


func Enter():

	dash_particles.restart()
	dash_particles.emitting = true
	print(player.collision_mask)
	
	print(player.collision_mask)
	dash_start_position = player.global_position
	player.is_dashing = true
	player.dash_timer = player.dash_cooldown
	_update_animation()
	
func _update_animation():
	var particle_mat : ParticleProcessMaterial = null
	if player.last_facing_direction == "right":
		dash_direction = 1
		particle_mat = dash_particles.process_material
		particle_mat.gravity = Vector3(-1.0, -1.0, 0.0)
		animation_player.play("dashR")
	else:
		dash_direction = -1
		particle_mat = dash_particles.process_material
		particle_mat.gravity = Vector3(1.0, -1.0, 0.0)
		animation_player.play("dashL")
	pass
	
func Physics_Update(_delta: float):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	var dash_vector = (player.position - dash_start_position)
	var current_distance = dash_vector.length()
	
	if(current_distance >= player.dash_max_distance) or player.is_on_wall() or player.is_on_ceiling() or player.is_on_floor():
		player.is_dashing = false;
		Transitioned.emit(self, "walk")
		return
	else:
		if(current_distance == 0):
			current_distance = 1.0
			dash_vector = Vector2(dash_direction, 0.0)
			
		var x_curve_offset = current_distance / player.dash_max_distance
		player.velocity = dash_vector.normalized() * player.dash_speed * dash_curve.sample(x_curve_offset)
		AudioManager.play_sfx(preload("res://Assets/Sounds/sfx/dash.ogg"))
	player.move_and_slide()
	
	_change_state(direction_x, direction_y)
	
func _change_state(direction_x, direction_y):
	
	if player.hit:
		Transitioned.emit(self, "death")
		return
	
	if GameManager.player_cutscene:
		player.is_dashing = false
		Transitioned.emit(self, "cutscene")
		return
	
	if player.is_dashing:
		return;
	
	_update_animation()
	player.collision_mask = player.collision_mask | 2
	if direction_x < 0:
		player.last_facing_direction = "left"
	elif direction_x > 0:
		player.last_facing_direction = "right"

	if direction_x == 0 and direction_y == 0:
		Transitioned.emit(self, "idle")
		return
	
	if player.is_attacking:
		Transitioned.emit(self, "attack")
		return
		
	
