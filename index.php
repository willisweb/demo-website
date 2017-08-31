<!DOCTYPE html>
<html>
<head>
	<title>CRC Demo website</title>
		<style>
			body {
				text-align: center;
				background-color: #4fbfff;
				/* blue 4fbfff green 4bae5d */
				font-family: "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif;
				color: white;
			}
			h1 {
				margin-top: 100px;
			}
		</style>
</head>
<body>
<h1>CRC Auto deploy demo</h1>
<h2><?php echo "This is PHP revision 12"; ?></h2>
<h2><?php echo date('l jS \of F Y h:i:s A'); ?></h2>
<h2><?php echo $_SERVER['SERVER_ADDR']; ?></h2>
</body>
</html>
