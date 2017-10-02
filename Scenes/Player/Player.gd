extends KinematicBody2D

const maxSpeed = 300;
const verticalAcceleration = 50;
const maxGravity = 200;
const horizontalAcceleration = 100;
const jumpstartvelocity = 100;

onready var Weapon = get_node("BoomStick");
var acceleration = Vector2(0,0);

func _ready():
	set_process(true);
	pass

func _process(delta):
	#Aiming
	var mpos = get_viewport().get_mouse_pos();#Find mouse pos
	
	
	if((get_pos()-mpos).x < 0): #Where is the mouse relative to parent 
		scale(Vector2(-1.0, 1.0)); #Right
	else:
		scale(Vector2(1.0, 1.0)); #Left
	
	Weapon.set_rot(0)
	
	var angle = Weapon.get_angle_to(mpos)+(0.5*PI); #Find rotation angle
	#angle = clamp(angle, -(PI*0.511), (PI*0.511)); #Removes odd rotations
	angle = angle*180/PI;
	print(angle)
	Weapon.set_rotd(angle); #Rotate
	
	#YEAH BITCH, SCIENCE!
	
	#Movement
	var vel = Vector2(0,0);
	
	if(Input.is_action_pressed("Left")):
		#vel.x = -speed*delta;
		acceleration.x += -horizontalAcceleration*delta;
		pass
	
	if(Input.is_action_pressed("Right")):
		acceleration.x += horizontalAcceleration*delta;
		pass
		
	
	#if(Input.is_action_pressed("Up") && is_colliding()):
	#	vel.y = -jumpstartvelocity;
	if(is_colliding()):
		#print(get_collision_normal().dot(Vector2(0, -1)));
		if(get_collision_normal().dot(Vector2(0, -1)) < 5):
			acceleration.y = 0;
		else:
			acceleration.y += verticalAcceleration*delta;
		acceleration = get_collision_normal().slide(acceleration);
	else:
		acceleration.y += verticalAcceleration*delta;
		
	vel = acceleration*delta;
	vel.x = clamp(vel.x, -maxSpeed, maxSpeed);
	vel.y = clamp(vel.y, -maxGravity, maxGravity);
	
	move(vel);
	pass