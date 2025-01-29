extends CanvasLayer

signal start_game

func show_message(text):
	$Message_Label.text = text
	$Message_Label.show()
	$Message_Timer.start()
	
func show_game_over():
	show_message("GAME OVER")
	await $Message_Timer.timeout
	
	$Message_Label.text = "GOOM GAME!"
	$Message_Label.show()
	
	await get_tree().create_timer(1.0).timeout
	$Start_Button.show()
	
func update_score(score):
	$Score_Label.text = str(score)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed():
	$Start_Button.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message_Label.hide()
