extends Area2D


func _on_area_entered(area):
	if area is Player:
		area.health += 1
		queue_free()
