extends KinematicBody2D

const speed = 200;
const gravity = 20;

func _ready():
	set_process(true);
	pass

func _process(delta):
	var vel = Vector2(0,0);
	if(Input.is_action_pressed("Left")):
		vel.x = -speed*delta;
		pass
	
	if(Input.is_action_pressed("Right")):
		vel.x = speed*delta;
		pass
	
	vel.y = gravity*delta;
	if(is_colliding()):
		vel = vel.slide(get_collision_normal());
	
	move(vel);
	pass