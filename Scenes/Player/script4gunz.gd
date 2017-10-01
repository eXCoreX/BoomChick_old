extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _process(delta):
	var mpos = get_viewport().get_mouse_pos()
	look.at(mpos)
	pass




func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
