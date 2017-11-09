<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>Apparatus criticus</title>
    <script type="text/javascript" src="apparatus_reg.js"></script>
    <script type="text/javascript" src="apparatus_orig.js"></script>
    <!-- jquery -->
    <link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css"/> 
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.3.min.js"></script> 
    <script src="https://code.jquery.com/jquery-1.8.2.js"></script> 
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.js"></script>
    <!-- traviz -->
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
      echo "Verso: <span id='line_number'>$line_number</span> / <button id='prev_verse'>Anterior</button> <button id='next_verse'>Siguiente</button>
      <form><input name='regularizate' type='radio' value='reg' checked='checked'>Regularizado</input><input name='regularizate' type='radio' value='orig'>Sin regularizar</input><form>
      <br/>Testimonios que carecen de este verso:<span id='missing-verses'></div></p>";
      ?>
    </div>
    <div id="containerDiv"></div>


    <script type="text/javascript">
    var line_number = "<?php echo $line_number ?>";
		// parses the json file (it was uploaded in the <head>)
		var mydata_reg = JSON.parse(data_reg);
    var mydata_orig = JSON.parse(data_orig);
    mydata = mydata_reg[0]; //Now it is a list with a dictionary for each line. The key is the line number
    var vers_to_collate = mydata[line_number];
    regular = true;

    
// TRAVIZ
  function doTraviz(div,line){
    var traviz = new TRAViz(div,{
    lineBreaks: false,
    font: 'junicode',
    normalize: true,
    editDistance: 0,
    startAndEnd: false
  });
  traviz.align(line);
  traviz.visualize();
  
  // In which testimonies is this verse missing.
  missing_verses = ''
  for (var i = 0; i < line.length; i++){
    if (line[i]['text'] == ''){
        missing_verses += ' ' + line[i]['edition'].substring(1) + ',';
      }
    };
  $("#missing-verses").text(missing_verses);

  };

// Activate on open
  doTraviz("containerDiv", vers_to_collate);

// activate on click
  document.getElementById("prev_verse").onclick = function() {
    line_number = Number(line_number) - 1;
    document.getElementById("line_number").textContent = line_number;
    if (regular == true){
      vers_to_collate = mydata_reg[0][line_number];
    }else{
      vers_to_collate = mydata_orig[0][line_number];
    }
    doTraviz("containerDiv", vers_to_collate);
  };

  document.getElementById("next_verse").onclick = function() {
    line_number = Number(line_number) + 1;
    document.getElementById("line_number").textContent = line_number;
    vers_to_collate = mydata[line_number];
    doTraviz("containerDiv", vers_to_collate);
  };

  // Regularize / Paleographic
  $('input[name=regularizate]').change(function(){
    value = $(this).attr('value');
    if (value == 'reg'){
      regular = true;
      vers_to_collate = mydata_reg[0][line_number];    
    }
    else {
      regular = false;
     vers_to_collate = mydata_orig[0][line_number];     
    }
    doTraviz("containerDiv", vers_to_collate);
  });

    </script>
  </body>
</html>
