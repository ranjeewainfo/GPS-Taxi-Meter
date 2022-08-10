<?php
//setcookie('disable_nav', 'true', time() + (60 * 60 * 24 * 30 * 365), "/");

?>

<!DOCTYPE html>

<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Meter</title>
	<link rel="stylesheet" type="text/css" media="screen" href="src/styles/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="src/styles/styles.css" />
	<script>
		window._izq = window._izq || [];
		window._izq.push(["init"]);
	</script>
	<script src="https://cdn.izooto.com/scripts/9536e9c775ffc7ad2d9bdf99a3e4dfd6005b121d.js"></script>
</head>

<body>

	<div class="box center">

		<span class="diatance_meter" id="diatance_meter" data-val="distance">0</span><span class="diatance_meter_km">Km</span>
		<br>
		<span id="speed" data-val="speed">0</span> <small>Km/h</small>
		<br>

		<div class="btn-group">
			<button class="btn default" id="pause">&nbsp; Drive </button>
			<button class="btn default" id="traffic">Traffic</button>
			<button class="btn default" id="idle">&nbsp; Idle&nbsp;&nbsp; </button>
		</div>

		<div class="time_meter"><span data-val="time">0</span></div>

		<div class="ticket">
			Base fee &nbsp;<small><span data-val="freekm">xx</span>Km and <span data-val="freeh">xx</span>Hr
				free</small><span class="float-right"><span data-val="fee">xx</span>/=</span>
			<br>
			Distance &nbsp;<small> Rs. <span data-val="extrakm">45</span>/Km x <span id="extra_distance">0</span>
				Km</small><span class="float-right"><span id="extrakm_price">0</span>/=</span> </span><br>
			Hours &nbsp;<small>Rs. <span data-val="extrah">100</span>/Hr x <span id="extra_time">0</span> Hr
			</small><span class="float-right"><span id="extrah_price">0</span>/=</span><br>

		</div>

		<div class="price">Rs. <span id="price">0</span> /=</div>

		<br>
		<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" id="package_edit_btn" data-target="#package_edit">Change package</button>

		&nbsp;&nbsp;&nbsp;&nbsp;

		<button onClick="start()" id="start_btn" class="btn btn-success controlbtn">Start</button>
		<button onClick="stop()" id="stop_btn" class="btn btn-danger controlbtn">Stop</button>
		<button onClick="resume()" id="resume_btn" class="btn btn-warning controlbtn">Resume</button>
		<button onClick="reset()" id="reset_btn" class="btn btn-primary controlbtn">Reset</button>

		<p> </p>


	</div>

	<div class="modal fade" id="register_info" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">

		<div class="modal-dialog" role="document">

			<div class="modal-content p-3 center box">

				<h5>GPS Taxi Meter</h5>
				<p></p>

				<a class="btn btn-warning" href="register.html">Register</a>

				<div class="modal-body box">

					<p>GPS taxi meter is highly demand service.
						<br>By register online you will get more benefits.
						<br><b> Location updates | hire notification | Make Offers for hires | Customer direct
							bookings</b>
						<br> We appreciated your
						<a href="https://www.facebook.com/athalanga.lk/reviews/?ref=page_internal" target="_blank">&#9733&#9733&#9733&#9733&#9733
							<strong>rating</strong></a>, coz we are always working on this with your support. <br>Thank
						you..!</p>

				</div>

				<div class="row">
					<div class="col">
						<a href="register.html" class="btn btn-primary btn-block">Register</a>
					</div>
					<div class="col">
						<button type="button" class="btn btn-secondary btn-block" data-dismiss="modal">Cancel</button>
					</div>
				</div>

			</div>

		</div>

	</div>

	<div class="modal fade" id="package_edit" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">

		<div class="modal-dialog" role="document">

			<div class="modal-content center box">

				<div class="box">

					<div class="center">
						<h5>Update Your Taxi package</h5>
					</div>
					<hr>

					<div class="row">

						<div class="col-6 form-group">

							<label for="fee">Base Fee</label>
							<input name="fee" id="fee" data-val="fee" class="form-control" type="number" required>

						</div>

						<div class="col-6 form-group">

							<label for="freekm">Free Km</label>
							<input name="freekm" id="freekm" data-val="freekm" class="form-control" type="number" required>

						</div>

					</div>

					<div class="row">

						<div class="col-6 form-group">

							<label for="freeh">Free Hours</label><br>
							<input name="freeh" id="freeh" data-val="freeh" class="form-control" type="number" required>

						</div>

						<div class="col-6 form-group">

							<label for="extrakm">Extra Km</label>
							<input name="extrakm" id="extrakm" data-val="extrakm" class="form-control" type="number" required>

						</div>

					</div>

					<div class="row">

						<div class="col-6 form-group">

							<label for="extrah">Extra hour</label><br>
							<input name="extrah" id="extrah" data-val="extrah" class="form-control" type="number" required>

						</div>

						<div class="col-6 form-group">

							<label for="free_limit">Traffic limit (Km/h)</label><br>
							<input name="free_limit" id="free_limit" data-val="free_limit" class="form-control" type="number" required>

						</div>

					</div>
					<hr>
					<div class="row">

						<div class="col">
							<button type="button" id="package_edit_save" class="btn btn-success btn-block" data-dismiss="modal">Update</button>
						</div>
						<div class="col">
							<button type="button" class="btn btn-dark btn-block" data-dismiss="modal">Cancel</button>
						</div>

					</div>
				</div>

			</div>

		</div>

	</div>

	<script src="src/scripts/jquery.min.js"></script>
	<script src="src/scripts/bootstrap4.min.js"></script>
	<script src="meter.js"></script>

</body>

</html>