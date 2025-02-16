extends CanvasLayer

signal start_game


func update_score(score):
	$ScoreLabel.text = str(score)
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _process(delta):
	if Input.is_action_pressed("start"):
		if($Button.visible):
			startGame()
		
func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the Creeps"
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Button.show()

func startGame():
	$Button.hide()
	emit_signal("start_game")
	
func _on_Button_pressed():
	startGame()


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
