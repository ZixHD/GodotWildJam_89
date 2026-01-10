extends State
class_name Walk

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func Enter():
	_update_animation()
	
func _update_animation():
	if player.last_facing_direction == "right":
		animation_player.play("walkR")
	else:
		animation_player.play("walkL")
	pass
	
func Physics_Update(_delta: float):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	_change_state(direction_x, direction_y)
	
	var norm = Vector2(direction_x, direction_y).normalized()
	
	player.velocity.x = norm.x * player.speed
	player.velocity.y = norm.y * player.speed
	
	player.move_and_slide()
	
	
func _change_state(direction_x, direction_y):
	
	if player.hit:
		Transitioned.emit(self, "death")
		return
	
	if GameManager.player_cutscene:
		Transitioned.emit(self, "cutscene")
		return
		
	if direction_x < 0:
		player.last_facing_direction = "left"
	elif direction_x > 0:
		player.last_facing_direction = "right"
	_update_animation()
	
	if direction_x == 0 and direction_y == 0:
		Transitioned.emit(self, "idle")
		return
	
	if Input.is_action_just_pressed("dash") and not player.is_dashing and player.dash_timer <= 0: 
		Transitioned.emit(self, "dash")
		return
	
	#if player.cutscene or Engine.time_scale == 0:
		#Transitioned.emit(self, "cutscene")
		#return
	if player.is_attacking:
		Transitioned.emit(self, "attack")
		return
	
	
