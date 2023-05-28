extends Area2D

var SPEED = 250
var MAX_SPEED = 1250
var SPEED_FACTOR = 1.2
var TIMER_FACTOR = 1.75

var can_move = false

@onready var timer = $Timer

func _process(delta):
	if can_move:
		position.y -= SPEED * delta


func _on_timer_timeout():
	SPEED *= SPEED_FACTOR
	SPEED = min(SPEED, MAX_SPEED)
	SPEED_FACTOR = min(SPEED_FACTOR + .1, 2.5)
	
	timer.wait_time *= TIMER_FACTOR


func _on_area_entered(area):
	if area is Player:
		area.kill()
