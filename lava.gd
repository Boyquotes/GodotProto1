extends Area2D

var SPEED = 250
var SPEED_FACTOR = 1.5
var can_move = false

@onready var timer = $Timer

func _process(delta):
	if can_move:
		position.y -= SPEED * delta


func _on_timer_timeout():
	SPEED *= SPEED_FACTOR
	SPEED = min(SPEED, 1750)
	SPEED_FACTOR = min(SPEED_FACTOR + .1, 2.5)
	
	timer.wait_time *= 1.3


func _on_area_entered(area):
	if area is Player:
		print(area)
		area.kill()
