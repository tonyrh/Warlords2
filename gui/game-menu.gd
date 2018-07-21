extends MenuButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var popup = get_popup()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print("popup position: " + String(popup.get_position_in_parent()))
	popup.add_item("New game", 0, 1)
	popup.add_item("Load game", 0, 2)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

