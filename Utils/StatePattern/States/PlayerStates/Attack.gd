extends State
class_name Attack

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func Enter():
	_update_animation()
	
func _update_animation():
	if player.last_facing_direction == "left":
		animation_player.play("idleL")
	elif player.last_facing_direction == "right":
		animation_player.play("idleR")
	pass

	
func Physics_Update(_delta: float):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	_change_state(direction_x, direction_y)
	
func _change_state(direction_x, direction_y):
	
	if player.is_attacking:
		return
		
	if player.hit:
		Transitioned.emit(self, "death")
		return
	
	if GameManager.player_cutscene:
		Transitioned.emit(self, "cutscene")
		return
		
	_update_animation()
	
	if direction_x < 0:
		player.last_facing_direction = "left"
	elif direction_x > 0:
		player.last_facing_direction = "right"
		
	if direction_x != 0 or direction_y != 0:
		Transitioned.emit(self, "walk")  
		return

	if direction_x == 0 and direction_y == 0:
		Transitioned.emit(self, "idle")
		return
	
	if Input.is_action_just_pressed("dash") and not player.is_dashing and player.dash_timer <= 0: 
		Transitioned.emit(self, "dash")
		return
	
	
		
	
