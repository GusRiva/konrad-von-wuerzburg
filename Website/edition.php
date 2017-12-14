<html>
	<head> 
    <title>Konrad von Würzburg - Digital Edition</title> 
    <meta charset="UTF-8"/> 
    <link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css"/> 
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.3.min.js"></script> 
    <script src="https://code.jquery.com/jquery-1.8.2.js"></script> 
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.js"></script>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
    <meta name="viewport" content="width=device-width, initial-scale=1"/> 
    <!-- My templates -->
    <script type="text/javascript">
		var maere=<?php echo json_encode($_GET["source"]); ?>;
	</script>
    <link rel="stylesheet" type="text/css" href="CSS/dropdown-submenu-fix.css"/> 
    <link rel="stylesheet" type="text/css" href="CSS/edition.css"/> 
    <script src="JS/edition.js" type="text/javascript"></script>
	</head>
	<body>
	<?php
	//Dictionary of texts
	$textDict = include 'database.php';
	$textKey = $_GET["source"]; 
	$file_name = $textDict[$textKey]['file'];

	// Load the XML source
	$xml=simplexml_load_file($file_name) or die("Error: Cannot create object");
	$xml -> registerXPathNamespace("tei", "http://www.tei-c.org/ns/1.0");
	$title = $textDict[$textKey]['title'];

	?>

	    <nav class="navbar navbar-inverse navbar-fixed-top" id="title">
	        <?php
	        include("title-navbar.html")
	        ?>
	    </nav>
	    <nav class="navbar navbar-inverse navbar-fixed-top" id="text-titles-nav">
	        <div class="container-fluid" id="text-titles-nav-div">
	        	<?php 
	        	for($i=0; $i < 12; ++$i){
	        		include("text-selector.html");
	        	}
	        	?>
	        </div>
	    </nav>
	    
	    <!--                Text Columns-->
	    <div class="container-fluid" id="text_container">
	        <div class="row" id="text-row">
	        	<?php
	        	for($i=0; $i < 12; ++$i){
	        	echo '<div class="col-md-4 edition-text">
	                    <div class="text-container scrollable"></div>
	                </div>';
	        	}
	        	?>
	        </div>
	        <div class="row" id="row_introduction">
	            <?php
	            include("instructions.html")
	            ?>
	        </div>
	    </div>
	</body>
</html>

