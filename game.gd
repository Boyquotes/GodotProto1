extends Node2D

const BLOCK = preload("res://block.tscn")

@onready var blocks = $Blocks
@onready var player = $Player
@onready var lava = $Lava

var last_block = null

func _ready():
	randomize()
	for i in range(5):
		add_block()

func _process(delta):
	if not last_block:
		return
	
	if player.global_position.y - get_viewport_rect().size.y / 2 < last_block.position.y:
		add_block()

func add_block():
	var block_id = 0
	if last_block:
		block_id = last_block.name.to_int() + 1
	
	var block: Block = BLOCK.instantiate()
	block.name = str(block_id)
	block.position.y = - (block_id + 1) * 256
	block.type = randi() % 2
	blocks.add_child(block)
	last_block = block


func _on_player_as_move():
	if not lava.can_move:
		lava.can_move = true
	
	lava.position.y = min(lava.position.y, player.position.y + get_viewport_rect().size.y / 2)
#	if not lava.on_screen:
#		lava.position.y = player.position.y + 1024
