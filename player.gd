extends Area2D
class_name Player

signal as_move

var score = 0
var health = 3: set = set_health

@onready var ray_cast_2d = $RayCast2D
@onready var label = $CanvasLayer/Control/Label
@onready var health_container = $CanvasLayer/Control/HealthContainer

func _ready():
	update_label()
	set_health(3)

func _input(event):
	var collider = ray_cast_2d.get_collider()
	if not collider is Block:
		return
	
	var action = -1
	
	if event is InputEventScreenTouch and event.is_pressed():
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
		take_damage(1)
#		kill()
		pass

func update_label():
	label.text = str(score)

func take_damage(damage: int):
	set_health(health - 1)

func set_health(h):
	health = h
	for child in health_container.get_children():
		child.queue_free()
	for i in range(health):
		var color_rect = ColorRect.new()
		color_rect.custom_minimum_size = Vector2(96, 96)
		color_rect.color = Color.RED
		health_container.add_child(color_rect)
	
	if health <= 0:
		kill()

func kill():
	get_tree().reload_current_scene()
