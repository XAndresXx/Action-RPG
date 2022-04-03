extends Node2D

func create_grass_effect():
	var grassEffect=load("res://Scenes/GrassEffect.tscn")
	var effect=grassEffect.instance()
	var world=get_tree().current_scene
	world.add_child(effect)
	effect.global_position=global_position


func _on_HurtBox_area_entered(area):
	create_grass_effect()
	queue_free()
