var valid_lang = ["de", "en","es"];
var content = 
	{"en":
		{"title":"Short Stories", 
		"editions":"Editions",
		"about":"About the Project",
		"welcome": "Welcome to the Digital Edition of Konrad von Würzburg's Short Stories (Beta Version)",
		"p_1": "In this page you will find a synoptic digital edition of the three short stories by the Middle High German poet Konrad von Würzburg (13th century). It was created by Gustavo Fernández Riva for his PhD Dissertation at the University of Buenos Aires thanks to the financial support of CONICET.",
		"p_2": "The synoptic view provides transcriptions of all manuscript witnesses, a new critical text and a variant graph.",
		"p_3": "Warning: This is still a Beta Version! Some texts and features are unavailable or might not be working properly."}, 
	"de":
		{"title":"Versnovellen", 
		"editions":"Editionen",
		"about":"Über das Projekt",
		"welcome": "Willkommen bei der Digitalen Edition der Versnovellen Konrads von Würzburg (Beta Version)",
		"p_1": "Auf dieser Seite finden Sie eine synoptische digitale Edition der drei Versnovellen des mittelhochdeutschen Dichters Konrads von Würzburg (13. Jahrhundert). Sie wurde von Gustavo Fernández Riva für seine Doktorarbeit an der Universität von Buenos Aires dank der Unterstützung des CONICET hergestellt.",
		"p_2": "Die synoptische Ansicht bietet Transkriptionen aller Textzeugnisse, einen neuen kritischen Text und Variantengraphen an.",
		"p_3": "Achtung! Diese Seite ist eine Beta-Version! Einige Texte und Eigenschaften sind entweder nicht verfügbar oder funktionieren nicht richtig"}, 
	"es":
		{"title":"Relatos Cortos en Verso", 
		"editions":"Ediciones",
		"about":"Sobre el Proyecto",
		"welcome": "Bienvenido a la edición digital de los relatos cortos en verso de Konrad von Würzburg (Versión Beta)",
		"p_1": "En esta página encontrarás a una edición digital sinóptica de los tres relatos cortos en verso del poeta en alto alemán medio Konrad von Würzburg (siglo XIII). Ha sido creada por Gustavo Fernández Riva para su tesis de doctorado en la Universidad de Buenos Aires gracias al apoyo financiero de CONICET.",
		"p_2": "La vista sinóptica ofrece transcripciones de todos los testimonios, un nuevo texto crítico y graficos de variantes.",
		"p_3": "¡Atención! ¡Esto es una versión beta! Algunos textos y características pueden no estar disponibles o funcionar de manera incorrecta."}};


function change_language(lang){
	$("#versnovellen").text(content[lang]["title"]);
	$("#main").find("h2").slice(0,1).text(content[lang]["editions"]);
	$("#main").find("h2").slice(1,2).text(content[lang]["about"]);
	$("#main").find("h2").slice(2,3).text(content[lang]["welcome"]);
	$("#main-text").find("p").slice(0,1).text(content[lang]["p_1"]);
	$("#main-text").find("p").slice(1,2).text(content[lang]["p_2"]);
	$("#main-text").find("p").slice(2,3).text(content[lang]["p_3"]);
};

$(document).ready(function () {
	user_lang = navigator.language.substring(0,2);
	lang = user_lang;
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