extends WindowDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var close_button = get_close_button()

const GAP = Vector2(12,50)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
#	close_button.texture_normal = load("res://gui/assets/close.png")
#	close_button.rect_position = Vector2(266,4)
#	close_button.rect_scale = Vector2(1.25,1.25)
#	print("close button position: " + String(close_button.rect_position))
	show()
	close_button.hide()
	_go_to_position()
	
	get_tree().get_root().connect("size_changed", self, "myfunc")
	
#	set_process(true)
	pass

func _input(event):
	_hotspot()
	pass

func _go_to_position():
	rect_position.x = get_viewport().size.x - rect_size.x + GAP.x
	rect_position.y = GAP.y
	pass

func _hotspot():
	# var tr = Vector2(get_viewport().size.x,0)
	
	if rect_position.x + rect_size.x > get_viewport().size.x :
		rect_position.x = get_viewport().size.x - rect_size.x + GAP.x
	if rect_position.x < 0:
		rect_position.x = GAP.x
	if rect_position.y < GAP.y:
		rect_position.y = GAP.y
	if rect_position.y + rect_size.y > get_viewport().size.y :
		rect_position.y = get_viewport().size.y - rect_size.y + GAP.x
##	&& \
##		rect_position.y <  theme.get("WindowDialog/constants/title_height"):
#			print("viewport size:")
#			print(get_viewport().size)
#			print("rect size:")
#			print(rect_size.x)
#			print("rect position:")
#			print(rect_position)
#			rect_position = Vector2(get_viewport().size.x - rect_size.x,theme.get("WindowDialog/constants/title_height"))

#	if (tr - (rect_position + rect_size)) < Vector2(theme.get("WindowDialog/constants/title_height"),0) :
#		var title_height = theme.get("WindowDialog/constants/title_height")
#		rect_position = Vector2(tr.x - rect_size.x,title_height) - GAP
#		# var title_height = theme.get("WindowDialog/constants/title_height")
#		# print(title_height)
#		pass
	pass

func myfunc():
	print("Resizing: ", get_viewport_rect().size)
	_go_to_position()