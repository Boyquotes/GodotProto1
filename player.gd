extends Area2D
class_name Player

signal as_move

var score = 0

@onready var ray_cast_2d = $RayCast2D
@onready var label = $CanvasLayer/Control/Label

func _ready():
	update_label()

func _input(event):
	var collider = ray_cast_2d.get_collider()
	if not collider is Block:
		return
	
	var action = -1
#
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left"):
			action = 0
		elif Input.is_action_just_pressed("right"):
			action = 1
	elif event is InputEventScreenTouch and event.is_pressed():
		var pos = event.position.x
		action = int(pos / (get_viewport_rect().size.x / 2))
		DebugControl.update_label("touch_pos", "TouchPos: " + str(pos))
	
	if action < 0:
		return
	
	DebugControl.update_label("action", "Action: " + str(action))
	if collider.pass_through(self, action):
		as_move.emit()
		score += 1
		update_label()
	else:
		kill()

func update_label():
	label.text = str(score)

func kill():
	get_tree().reload_current_scene()
