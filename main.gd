extends Node

@export var mob_scenne: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass



	
func new_game():
	$Music.play()
	score = 0
	$Player.start($Start_Position.position)
	$Start_timer.start()
	$HUD.update_score(score)
	$HUD.show_message("GET READY")
	

func _on_start_timer_timeout():
	$mob_timer.start()
	$Score_timer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout():
	var mob = mob_scenne.instantiate()
	
	var mob_spawn_location = get_node("mob_path/Mob_spont_location")
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI /2;
	
	mob.position = mob_spawn_location.position;
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func game_over():
	$Music.stop()
	$Score_timer.stop()
	$mob_timer.stop()
	$HUD.show_game_over()
	$Game_over_sound.play()
