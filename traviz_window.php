<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>Apparatus criticus</title>
    <script type="text/javascript" src="apparatus.json"></script>
    <script src="TRAVIZ/traviz-min.js"></script>
    <link rel="stylesheet" type="text/css" href="TRAVIZ/traviz.css"></link>
  </head>  
  <body>
  	<!-- The php gets the line number from the click event in parent window js.
		Then it gets the relevant information from the TEI files and sends it to JS
  	 -->
  	<?php 
  		$line_number = $_GET['line']; 
  	?>
    <div>
      <?php 
      echo "<p>Verso: $line_number</p>";
      ?>
    </div>
    <div id="containerDiv"></div>
    <script type="text/javascript">
    var line_number = "<?php echo $line_number ?>";
		// parses the json file (it was uploaded in the <head>)
		var mydata = JSON.parse(data);
    mydata = mydata[0]; //Now it is a list with a dictionary for each line. The key is the schröder number
    vers_to_collate = mydata[line_number];
    

		var traviz = new TRAViz("containerDiv",{
		lineBreaks: false,
    font: 'junicode',
		normalize: true,
		editDistance: 0,
		startAndEnd: false
	});
	traviz.align(vers_to_collate);
	traviz.visualize();
    </script>
  </body>
</html>
