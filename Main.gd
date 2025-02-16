extends Node

export (PackedScene) var mob_scene
var score = 0

func _ready():
	randomize()
	
func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get ready...")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	$Player.start($StartPosition.position)
	$ScoreTimer.start()
	$MobTimer.start()
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$MobTimer.wait_time = 2
	$Music.stop()
	$DeathSound.play()

func _on_Timer_timeout():
	$MobTimer.wait_time = max($MobTimer.wait_time - 0.05, 0.5)
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	var mob = mob_scene.instance()
	add_child(mob)
	mob.position = mob_spawn_location.position
	var direction =  mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
