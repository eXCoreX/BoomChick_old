extends KinematicBody2D

const maxSpeed = 300;
const verticalAcceleration = 50;
const maxGravity = 200;
const horizontalAcceleration = 100;
const jumpstartvelocity = 100;
const shootingDelay = 0.25

var timer = null
var canShoot = true
onready var SPlayer = get_node("SamplePlayer")
onready var Weapon = get_node("BoomStick");

var acceleration = Vector2(0,0);

func _ready():
	set_process(true);
	timer = Timer.new()
	timer.set_wait_time(shootingDelay)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "timer_complete")
	add_child(timer) 
	pass

func timer_complete():
	canShoot = true

func _process(delta):

	#Aiming
	var mpos = get_viewport().get_mouse_pos();#Find mouse pos
	
	if((get_pos()-mpos).x < 0): #Where is the mouse relative to parent 
		scale(Vector2(-1.0, 1.0)); #Right
	else:
		scale(Vector2(1.0, 1.0)); #Left
		
	var angle = get_angle_to(mpos)+(0.5*PI); #Find rotation angle
	angle = clamp(angle, -PI/2, PI/2); #Removes odd rotations
	Weapon.set_rot(angle); #Rotate
	
	#YEAH BITCH, SCIENCE!
	
	#Shooting
	if(canShoot && Input.is_mouse_button_pressed(1)):
		var id = SPlayer.play("dbsShot")
		SPlayer.set_volume(id, 0.8)
		canShoot = false
		timer.start()
	
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