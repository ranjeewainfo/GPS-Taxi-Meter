
<?php 
global $wpdb;
setcookie('disable_nav', 'true', time() + (60*60*24*30*365), "/");

?>

<!DOCTYPE html>

<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hire Share</title>
	<link rel="stylesheet" type="text/css" media="screen" href="../../gpsmeter/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="../../gpsmeter/styles.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="/style.css" />

	<style type="text/css">
	.auto-style4 {
		text-align: center;
		font-family: "Gill Sans", "Gill Sans MT", Calibri, "Trebuchet MS", sans-serif;
		font-size: xx-large;
	}
	.align-enter {
		text-align: center;
	}
	.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 10px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

.button1 {border-radius: 2px;}
.button2 {border-radius: 4px;}
.button3 {border-radius: 8px;}
.button4 {border-radius: 12px;}
.button5 {border-radius: 50%;}

	</style>

	</head>

<body>
<h1 class="auto-style4">Hire Share</h1>
<h3 class="align-enter">Get your ID to collect cash! Contact <a href="https://wa.me/c/94764321100">Whatsapp +94764321100 </a> </h3>
<h1 class="auto-style2">
<img alt="Hire Share" src="Athalanga%20Driver%20account.jpg" 
 		style="display: block; margin-left: auto; margin-right: auto; max-width: 500px; height=auto"  />

 	</h1>
 	<p class="align-enter"> 
	<button class="button button3" onclick="location.href='../operator/applink/clear.php';" value="Agent">
	Add My ID</button>
	
 	<button class="button button3" onclick="location.href='../../user/ref?';" value="Agent">
	My Earning</button>
	
	</p>
 		
<p style="text-align: center;">
		<button class="button button3" onclick="location.href='../../taxi?r=7675';" target="_blank" value="Signature">
		Taxi Booking</button>

</p>


	<div class="align-enter">
		Loading ...<br></div>
<body onload="myFunction()"> 
--> 

<script>

function myFunction() {
  setTimeout(function(){
  location.replace("../../taxi?r=-1")
						}, 9000);
}


</script>
</body>
</html>
