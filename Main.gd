extends Node

export (PackedScene) var mob_scene

func _on_Timer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	var mob = mob_scene.instance()
	add_child(mob)
	mob.position = mob_spawn_location.position
	var direction =  mob_spawn_location.rotation + PI / 2
