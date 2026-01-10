extends State
class_name Cutscene

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func Enter():
	_update_animation()
	
func _update_animation():
	if player.last_facing_direction == "right":
		animation_player.play("idleR")
	else:
		animation_player.play("idleL")
	pass
	
func Physics_Update(_delta: float):
	
	player.velocity = Vector2.ZERO
	if not GameManager.player_cutscene:
		Transitioned.emit(self, "idle")
		return
	
