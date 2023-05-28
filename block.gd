@tool
extends Area2D
class_name Block

const COLORS = [Color.BLACK, Color.WHITE]
var PACKS = [preload("res://health_pack.tscn")]

@export var type: BLOCK_TYPE = 0:
	set(v):
		type = v
		update_block_color()

enum BLOCK_TYPE {
	BLACK,
	WHITE
}

@onready var color_rect = $ColorRect
@onready var marker_2d = $Marker2D

func update_block_color():
	if color_rect:
		color_rect.color = COLORS[type]

func _ready():
	update_block_color()
	if randf() < .05:
		PACKS.shuffle()
		var pack = PACKS[0].instantiate()
		pack.position = marker_2d.position
		add_child(pack)

func pass_through(player, block_type: int):
	DebugControl.update_label("wrong_action", "Guess: %s Correct: %s" % [block_type, type])
	if int(block_type) == int(type):
		DebugControl.update_label("have_pass_through", "Have pass through")
		player.global_position = marker_2d.global_position
		return true
	DebugControl.update_label("have_pass_through", "Have not pass through")
	return false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
