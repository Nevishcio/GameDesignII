extends CharacterBody3D

@onready var dmg_area = $DamageArea
@onready var atk_area = $AttackArea
@onready var nav_agent = $NavigationAgent3D

var SPEED = 10
var ACCEL = 20
var ATTACK = 51
var knockback = 3333


func _physics_process(_delta):
	for player in get_tree().get_nodes_in_group("Player"):
		if $AttackRange.overlaps_body(player):
			nav_agent.target_position = player.global_position
		if atk_area.overlaps_body(player):
			player.take_damage(ATTACK)
			var inert = player.global_position - self.global_position
			player.inertia = inert.normalized() * knockback
	var dir =(nav_agent.target_position - self.global_position).normalized()
	velocity = velocity.lerp(dir * SPEED, ACCEL * _delta)
	move_and_slide()
