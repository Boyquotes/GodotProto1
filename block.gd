@tool
extends Area2D
class_name Block

const COLORS = [Color.BLACK, Color.WHITE]

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

func pass_through(player, block_type: int):
	if block_type == type:
		player.global_position = marker_2d.global_position
		return true
	return false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
