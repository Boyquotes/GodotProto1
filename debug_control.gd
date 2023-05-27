extends CanvasLayer

@onready var debug_control = $DebugControl

func _ready():
	if OS.is_debug_build():
		show()
	else:
		hide()
		set_process(false)
		set_process_input(false)

func update_label(label_name: String, value: String):
	var child = debug_control.get_node_or_null(label_name)
	if child and child is Label:
		child.text = value
	else:
		var label = Label.new()
		label.name = label_name
		label.text = value
		debug_control.add_child(label)
