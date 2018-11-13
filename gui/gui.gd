extends CanvasLayer


#onready var menu_shown = $dim.visible

func _ready():
#	minimap.show()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	
	if event.is_action_pressed("esc"):
		if !$esc_menu.visible:
			# show menu
			$esc_menu.visible = true
			pass
		else:
			# hide menu
			$esc_menu.visible = false
			pass
		return

