extends KinematicBody2D

const maxSpeed = 200;
const verticalAcceleration = 300;
const maxGravity = 100;
const horizontalAcceleration = 50;
const jumpstartvelocity=100;

var acceleration = Vector2(0,0);

func _ready():
	set_process(true);
	pass

func _process(delta):
	var vel = Vector2(0,0);
	if(Input.is_action_pressed("Left")):
		#vel.x = -speed*delta;
		acceleration.x += -verticalAcceleration*delta;
		pass
	
	if(Input.is_action_pressed("Right")):
		acceleration.x += verticalAcceleration*delta;
		pass
	
	#if(Input.is_action_pressed("Up") && is_colliding()):
	#	vel.y = -jumpstartvelocity;
	#	pass
	vel.x = acceleration.x*delta;
	vel.x = clamp(vel.x, -maxSpeed, maxSpeed);
	vel.y += maxGravity*delta;
	if(is_colliding()):
		vel = vel.slide(get_collision_normal());
	
	move(vel);
	pass