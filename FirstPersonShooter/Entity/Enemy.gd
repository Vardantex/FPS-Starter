extends KinematicBody


#Stats
var health = 5 
var moveSpeed = 2.0 


#attacking 
var damage = 1 
var attackRate = 1.0
var attackDist = 2.0

var scoreToGive = 10 

#components 
onready var player = get_node("/root/MainScene/Player")
onready var timer = get_node("Timer")






func _ready() -> void:
	
	#setup timer 
	timer.set_wait_time(attackRate)
	timer.start()
	
	pass


func _on_Timer_timeout() -> void:
	
#	if translation.distance_to()
	pass
	
