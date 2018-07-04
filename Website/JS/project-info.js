var valid_lang = ["de", "en","es"];
var content = 
	{"en":
		{"home":"Home",
		"title":"<h1>The Project</h1>", 
		"editions":"Editions",
		"about":"About the Project",
		"p_1": "<p>This digital edition of Konrad von Würzburg's short stories is the result of my PhD Dissertation at the University of Buenos Aires. The work began in April 2014, when I was awarded a scholarship by the Argentinian national scientific agency (CONICET) for this purpose. The thesis is supervised by <a href='http://www.germanistenverzeichnis.phil.uni-erlangen.de/institutslisten/files/es/00000_es/66_es.html'>Prof. Dr. Victor Millet</a> (Universidad de Santiago de Compostela) and <a href='http://www.germanistenverzeichnis.phil.uni-erlangen.de/institutslisten/files/ar/00000_ar/12_ar.html'>Prof. Dr. Regula Rohland</a> (Universidad de Buenos Aires).</p><p>The aim of the project is to create a new edition focused on the textual variation rather than on the reconstruction of the original archetype. The digital medium offers the best enviroment to achieve this goal. The source texts for the edition are encoded in XML, according to the TEI guidelines, and can be downloaded for further analyses or to be used in other applications with a scientific purpose.<br/>The edition's interphase was devoleped by myself to have an appropiate way of displaying the texts. The application is programmed to work on most modern browsers. It renders the information of the source XML/TEI files using a series of scripts in  JAVASCRIPT, PHP and XSL. This is still a Beta Version, if you encounter any problems, please report them to me at gustavo.riva[at]filo.uba.ar.</p><p>The edition tries to offer a way of approaching the variation within the textual tradition. The synoptic view allows to compare transcriptions and critical text(s). The critical text(s), clearly displays the editor's intervention and references to the most important variations within the tradition (missing, added or alternative verses). To view the verse-level variation I use Stephan Jänicke's <a href='http://www.traviz.vizcovery.org'/>TRAViz </a> (Text Re-use Alignment Visualization), which offers an efficient (and beautiful) way of rendering the variant readings and replaces the traditional critical apparatus.</p><p>I hope this edition can be a valuable resource for students, researchers or curious readers.</p><br/><p>Gustavo Fernández Riva</p>"}
		, 
	"de":
		{"home":"Anfang", 
		"title":"<h1>Das Projekt</h1>",
		"editions":"Editionen",
		"about":"Über das Projekt",
		"p_1": "<p>This digital edition of Konrad von Würzburg's short stories is the result of my PhD Dissertation at the University of Buenos Aires. The work began in April 2014, when I was awarded a scholarship by the Argentinian national scientific agency (CONICET) for this purpose. The thesis is supervised by <a href='http://www.germanistenverzeichnis.phil.uni-erlangen.de/institutslisten/files/es/00000_es/66_es.html'>Prof. Dr. Victor Millet</a> (Universidad de Santiago de Compostela) and <a href='http://www.germanistenverzeichnis.phil.uni-erlangen.de/institutslisten/files/ar/00000_ar/12_ar.html'>Prof. Dr. Regula Rohland</a> (Universidad de Buenos Aires).</p><p>The aim of the project is to create a new edition focused on the textual variation rather than on the reconstruction of the original archetype. The digital medium offers the best enviroment to achieve this goal. The source texts for the edition are encoded in XML, according to the TEI guidelines, and can be downloaded for further analyses or to be used in other applications with a scientific purpose.<br/>The edition's interphase was devoleped by myself to have an appropiate way of displaying the texts. The application is programmed to work on most modern browsers. It renders the information of the source XML/TEI files using a series of scripts in  JAVASCRIPT, PHP and XSL. This is still a Beta Version, if you encounter any problems, please report them to me at gustavo.riva[at]filo.uba.ar.</p><p>The edition tries to offer a way of approaching the variation within the textual tradition. The synoptic view allows to compare transcriptions and critical text(s). The critical text(s), clearly displays the editor's intervention and references to the most important variations within the tradition (missing, added or alternative verses). To view the verse-level variation I use Stephan Jänicke's <a href='http://www.traviz.vizcovery.org'/>TRAViz </a> (Text Re-use Alignment Visualization), which offers an efficient (and beautiful) way of rendering the variant readings and replaces the traditional critical apparatus.</p><p>I hope this edition can be a valuable resource for students, researchers or curious readers.</p><br/><p>Gustavo Fernández Riva</p>"}, 
	"es":
		{"home":"Inicio", 
		"title":"<h1>El Proyecto</h1>",
		"editions":"Ediciones",
		"about":"Sobre el Proyecto",
		"p_1": "<p>Esta edición digital de los relatos cortos de Konrad von Würzburg es el resultado de mi tesis de doctorado en la Universidad de Buenos Aires. El trabajo comenzó en abril de 2014 cuando me fue otorgada una beca del Consejo Nacional de Investigaciones Científicas y Técnicas (CONICET) de Argentina para llevar a cabo esta tarea. La tesis fue supervisada por el <a href='http://www.germanistenverzeichnis.phil.uni-erlangen.de/institutslisten/files/es/00000_es/66_es.html'>Prof. Dr. Victor Millet</a> (Universidad de Santiago de Compostela) y la <a href='http://www.germanistenverzeichnis.phil.uni-erlangen.de/institutslisten/files/ar/00000_ar/12_ar.html'>Prof. Dr. Regula Rohland</a> (Universidad de Buenos Aires).</p><p>El objetivo del proyecto es crear una nueva edición focalizada en la variación textual más que en la reconstrucción del arquetipo original. El medio digital ofrece el mejor ambiente para alcanzar este propósito. Las fuentes para la edición están codificadas en XML siguiendo las guías de la TEI y pueden ser descargadas para ser analizadas o para ser utilizadas en otras aplicaciones científicas. La interfaz de la edición fue desarrollada por mí mismo, para tener una manera apropiada de mostrar los textos. La aplicación está programada para funcionar con la mayoría de los navegadores modernos. Muestra la información de las fuentes XML/TEI usando una serie de programas de JAVASCRIPT, PHP y XSL. Esta todavía es una versión beta, si se encontraran errores, por favor reportarlos a gusfer[at]gmail.com</p><p>Esta edición intenta ofrecer nuevas maneras de aproximarse a la variación dentro de esta tradición textual. La vista sinóptica permite comparar las transcripciones y el texto crítico. El texto crítico muestra claramente las intervenciones edicoriales y las referencias a las variaciones más importantes (versos faltantes, añadidos, alternativos). Para ver la variación al nivel del verso utilizo TRAViz (Text Re-use Alignment Visualization) diseñado por Stephan Jänicke, que ofrece una manera eficiente (y bella) de mostrar las variantes y reemplaza al aparato crítico tradicional.</p><p>Espero que esta edición pueda ser un recurso valioso para estudiantes, investigadores y lectores curiosos.</p><br/><p>Gustavo Fernández Riva</p>"}};


function change_language(lang){
	$("#home").text(content[lang]["home"]);

	$("#title").empty().append(content[lang]["title"]);
	$("#main").find("h2").slice(0,1).text(content[lang]["editions"]);
	$("#main").find("h2").slice(1,2).text(content[lang]["about"]);
	$("#main").find("h2").slice(2,3).text(content[lang]["welcome"]);
	$("#main-text").empty();
	$("#main-text").prepend(content[lang]["p_1"]);
	// $("#main-text").find("p").slice(0,1).text(content[lang]["p_1"]);
	// $("#main-text").find("p").slice(1,2).text(content[lang]["p_2"]);
	// $("#main-text").find("p").slice(2,3).text(content[lang]["p_3"]);
	// $("#main-text").find("p").slice(3,4).text(content[lang]["p_4"]);
	// $("#main-text").find("p").slice(4,5).text(content[lang]["p_5"]);
	// $("#main-text").find("p").slice(5,6).text(content[lang]["p_6"]);

};

$(document).ready(function () {
	if (valid_lang.includes(lang) == false){
		lang = "en";
	};
	change_language(lang);
	
	$("a.language-selector").on("click", function(){
		lang = $(this).attr("id");
		change_language(lang);
	});
	// Assing href attribute to the links to the editions, so that they keep the correct language
	$(".link_edition").on("click", function(){
		 // href="edition.php?source=herz"
		 destination = "edition.php?source="
		 destination += $(this).attr("id").substring(5);
		 destination += "&lang=" + lang;
		 window.location = destination;
	});
});