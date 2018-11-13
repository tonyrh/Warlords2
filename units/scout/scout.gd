extends Sprite

# export(Color, RGBA) var team

onready var color_key = material.get_shader_param("u_color_key")
onready var replacement_color = material.get_shader_param("u_replacement_color")

func _ready():
#	print("color_key: " + str(color_key))
#	print("replacement_color: " + str(replacement_color)) 
#	print("team: " + str(team))
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# material.set_shader_param("u_replacement_color",team)
#	print("replacement_color: " + str(material.get_shader_param("u_replacement_color"))) 
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _change_team_color(ID):
	var color = Color(1.0,0,0,1)
	match ID:
		0:
			color = Color(1.0,0,0,1)
		1:
			color = Color(1.0,1.0,0,1)
		2:
			color = Color(1.0,1.0,1.0,1)
	material.set_shader_param("u_replacement_color",color)
	replacement_color = material.get_shader_param("u_replacement_color")
	print("replacement_color: " + str(replacement_color)) 
	pass # replace with function body
