class_name LerpSmoothing
extends CameraControllerBase


@export var lead_speed: float = 50
@export var catchup_delay_duration: float = 0.1
@export var catchup_speed: float = 90
@export var leash_distance: float = 10
@onready var timer: Timer = Timer.new()


func _ready() -> void:
	super()
	position = target.position
	timer.wait_time = catchup_delay_duration
	timer.one_shot = true
	add_child(timer)

func _process(delta: float) -> void: #implement lerp own lerp all in this function
	# get the vector difference of the camera and target positions, normalize for direction, multiply to get the smooth follow speed
	# how far you are ahead of leash
	# (tpos - cpos ).normalize to get direction, direction * delta * followspeed
	# beyond leash distance, get distance and go in direction of player instead to correct the overcorrection
	# follow speed: if player is moving
	# catchup speed,: player is stationary (check with target.velocity which is vector3, compare to vec3 of 0,0,0), camera moves to vessel position, move global position of camera
	# timer interruption for catchup delay, if the timer isnt null and check velocity as well
	if !current:
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	
	
	var tpos = target.global_position
	var cpos = global_position
	var direction = (tpos - cpos).normalized()
	var distance = sqrt(pow(cpos.x - tpos.x, 2) + pow(cpos.z - tpos.z, 2))
	var is_camera_behind = target.velocity.dot(tpos - cpos) < 0

	
	lead_speed = target.velocity.length() * 1.2
	
	if distance > leash_distance: # break the leash
		if target.velocity != Vector3.ZERO:
			if target.is_hyper_speed:
				global_position = target.position + direction * leash_distance
				#global_position += target.velocity * delta
		else: # break leash, stationary
			direction = (tpos - cpos).normalized()
			global_position += direction * catchup_speed * delta
	else:	
		if target.velocity != Vector3.ZERO:
			# Calculate the lead offset using the normalized velocity
			var lead_offset = target.velocity.normalized() * lead_speed
			# Lead position is the target's current position plus the lead offset
			var lead_position = tpos + lead_offset
			# Move towards the lead position smoothly using lerp
			global_position = global_position.lerp(lead_position, delta)
		else:
			# If stationary, fall back to using catchup speed to approach target position
			direction = (tpos - cpos).normalized()
			global_position += direction * catchup_speed * delta
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var cross_size: float = 5
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-cross_size/2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(cross_size/2, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -cross_size/2))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, cross_size/2))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
