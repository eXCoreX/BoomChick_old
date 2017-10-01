extends KinematicBody2D

const maxSpeed = 300;
const verticalAcceleration = 50;
const maxGravity = 200;
const horizontalAcceleration = 100;
const jumpstartvelocity = 100;
const rotateOffset = 0.02
var isLeft = true;
var isLeftFp = true;
var acceleration = Vector2(0,0);
func _ready():
	set_process(true);
	pass

func _process(delta):
	var mpos = get_viewport().get_mouse_pos();

	#get_node("BoomStick").look_at(mpos);
	var angle = get_node("BoomStick").get_angle_to(mpos);
	#if(!isLeft):
	#	angle = -angle;
	#print(angle);
	var totalangle = (angle+get_node("BoomStick").get_global_rot())*180/PI;
	print(totalangle)
	#if(!isLeft):
	#	totalangle = -totalangle;
	
	if(!(totalangle < 20 && totalangle > -200)):
		if(isLeft):
			scale(Vector2(1.0, 1.0));
		else:
			scale(Vector2(-1.0, 1.0));
		isLeft = !isLeft;
	#if(!(totalangle < 0 && totalangle > -180)):
	#	scale(Vector2(-1.0, 1.0));
	#	isLeft = false;
	#else:
	#	scale(Vector2(1.0, 1.0));
	#	isLeft = true;
	get_node("BoomStick").rotate(angle+(0.5*PI));

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