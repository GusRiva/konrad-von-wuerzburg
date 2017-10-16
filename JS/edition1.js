$(document).ready(function () {
    $('.tooltip').tooltip({ //allows tooltip    
        placement: "bottom",
        trigger: "hover"
    }); 
    
    $('.form-control').prop('selectedIndex',0); //Resets the text selectors to None
    
/*    VARIABLES*/
    var language = "en";
    var extensiveEdition = false;
    var groupScroll = false;
    var scrollController = [0,0,0,0,0,0,0,0,0,0,0,0]; // to move all scrolls at the same time, see scroll function
    var automaticScrolling = false; //to change when using the automatic click scrolling, to avoid conflict with user scroll events
    var numcolumns = 4;
    var counter = 0;
     /*Variables so that Titl-navbar shrinks */
    var smallFontTitle = 28; //Font-size when small, in case I would like to change it
    $("#maereTitle").css("font-size", smallFontTitle);
    var titleHeightSmall = $('#title').height(); 
    $("#maereTitle").css("font-size", 100);
    var titleHeightBig = $('#title').height(); 
    $("#text-titles-nav").css("top", titleHeightBig);
/*    END VARIABLES*/
    
    
/*FUNCTIONS*/

    //This function shows only the spans with the appropiate language. Example: class = "lang en"
    function languageCheck(language){
        $(".lang").addClass("hidden");
        $("[lang='"+language+"']").removeClass("hidden");
    };
    
    function languageSelector(language){
        if (language == "en"){
            $("option[value ='default']").text("Select text");
            $("option[value*='_krit']").text("Critical Text");
            $("option[value*='_app']").text("Critical Apparatus");
        }
        if (language == "de"){
            $("option[value ='default']").text("Textauswählen");
            $("option[value*='_krit']").text("Kritischer Text");
            $("option[value*='_app']").text("Kritischer Apparat");
        }
        if (language == "es"){
            $("option[value ='default']").text("Seleccionar Texto");
            $("option[value*='_krit']").text("Texto crítico");
            $("option[value*='_app']").text("Aparato crítico");
        }
    };
/*   END FUNCTIONS */

/*    disable extensive edition*/
    $("#extensive-edition-toggle").prop('checked', false);
/*    Disable the options before having a text in the column*/
    $("#text-titles-nav").find("input").attr('disabled', true);
    
/*    Form Control - Text Selector appearence*/
    $(".form-control").addClass("form-control-initial");
    $(".form-control").hover(
        function(){
            $(this).removeClass("form-control-initial");
            $(this).addClass("hover");
        }, function(){
            $(this).removeClass("hover");
            $(this).addClass("form-control-initial");
        }
    );
    
/*    LANGUAGE CHECK*/
    languageCheck(language);
    languageSelector(language);
        
    
    
/*  COLUMNS TO DISPLAY*/
  $("input[name=number-cols]").change(function(){
    numcolumns = parseInt($(this).val());
    width = 12 / numcolumns;
    $(".text-title").each(function(index){ // Text selectors 
        if (index +1 > numcolumns){
            $(this).addClass("hidden")
        }
        if (index + 1<= numcolumns){
            $(this).removeClass();
            $(this).addClass("text-title")
            $(this).addClass("col-md-"+width);
            }
    }); 
    $(".edition-text").each(function(index){ // The texts columns themselves 
        $(this).removeClass();
        $(this).addClass("edition-text");
        $(this).addClass("col-md-"+width);
        if (index + 1 > numcolumns){
            $(this).addClass("hidden");
            }
        });
    });
   
    
/* GLOBAL OPTIONS*/
    $("#extensive-edition-toggle").change(function(){
        if (extensiveEdition === false){        //extensive edition turns on
          $(".toHide").removeClass("hidden");// removes the hidden empty verses
          extensiveEdition = true;}
        else{  //extensive edition turns off
        $(".toHide").addClass("hidden");
        $(".highlight").removeClass("hidden");
        extensiveEdition = false;  
        };
    });
    //group scrollin
    $("#group-scroll").change(function(){
        if (groupScroll === false){
           groupScroll = true;
           }
       else{
           groupScroll = false;
           };
    });
    
    
/*    LOAD TEXTS*/
    $(".form-control").change(function(){
       //Reduces title if it is the first time a text is loaded
            counter = counter +1;
            if (counter == 1){
            $("#maereTitle").animate({fontSize: smallFontTitle}, 400); 
            $("#text-titles-nav").animate({top: titleHeightSmall}, 400);
            setBodyTop(titleHeightSmall);   
            //Set the height
            var viewportHeight = $(window).height();
            var textTitlesNavHeight = $("#text-titles-nav").height();
            var textContainerHeight = viewportHeight - titleHeightSmall - textTitlesNavHeight;
            $(".text-container").height(textContainerHeight);
            $("#row_introduction").addClass("hidden");
            //hide all non used columns
//            cols = $("input[name = number-cols]:checked").attr("value");
//           $("div.edition-text").each(function(){
//                if ($(this).index() + 1 > cols){
//                    $(this).addClass("hidden")
//                    }
//                });
           }
            
         //LOAD 
            var optionValue = $(this).val().split('_'); // Takes the attribute "value" of the selected option and turns it into an array. The first elemente is the text's code, then the testimony 
            var maere = optionValue[0]; // characters code for text
            var manuscriptToShow = '#'+optionValue[1]; // character code for manuscript
            var columnToChange = ($(this).parents(".text-title")).index(); // index of the column starting at 0
            var columnObject = $(".text-container").filter(function(){ // the actual JQuery object for the column to change
               return $(this).parents(".edition-text").index() == columnToChange; 
            });
            columnObject.empty();
            //Ajax request
           var request = $.ajax({
           url: 'JS/loadtext.php',
           type: 'get',
           data: {'manuscript': manuscriptToShow, 'text': maere}    
       });
       
       request.always(function(data){
           columnObject.append(data);
       });
/*       Watis until the DOM is refreshed. Maybe I could use setInterval, in order to avoid using an arbitrary amount of time that might need to change due to connection speed*/
      /*      rescroll = setInterval(function(){
               if ( $("tr.highlight").length ){
                   automaticScrolling = true;
                   var verse = $("tr.highlight").first();
                   var verseNum = verse.children("td.line_number").children("span.corresp_line").text();
                   var correspRow = $(".edition-text").filter(function(){return $(this).index() == columnToChange}).find("span.corresp_line").filter(function(){return $(this).text() == verseNum}).parents("tr");
                   correspRow.addClass("highlight");
                    if (correspRow[0].hasChildNodes()){
                        clearInterval(rescroll);
                        //show blank verses if extensive edition is on
                        if (extensiveEdition === true){
                            $(".toHide").removeClass("hidden")};
                        //Start at the same scroll point as the other witnesses
                        var offsetFinal = verse.offset().top;
                        var offsetInitial = correspRow.offset().top;
                        var newScroll= offsetInitial - offsetFinal;
                        columnObject.scrollTop(newScroll);  
                        scrollController[columnToChange] = newScroll;
                        };
               };
               languageCheck(language);
             }, 50);*/
       setTimeout(function(){
           //show blank verses if extensive edition is on
                if (extensiveEdition === true){
                  $(".toHide").removeClass("hidden")};
               //Start at the same scroll point as the other witnesses
               if ( $("tr.highlight").length ){
                   automaticScrolling = true;
                   var verse = $("tr.highlight").first();
                   var verseNum = verse.children("td.line_number").children("span.corresp_line").text();
                   var correspRow = $(".edition-text").filter(function(){return $(this).index() == columnToChange}).find("span.corresp_line").filter(function(){return $(this).text() == verseNum}).parents("tr");
                   correspRow.addClass("highlight");
                   var offsetFinal = verse.offset().top;
                   var offsetInitial = correspRow.offset().top;
                   var newScroll= offsetInitial - offsetFinal;
                   columnObject.scrollTop(newScroll);  
                   scrollController[columnToChange] = newScroll;
               };
               languageCheck(language);
       }, 600);
       
               
            
            //Enable the options for the column -- ADD DIFFERENT OPTIONS FOR DIFFERENT KINDS OF TEXTS
            var columnOptions = $("div.text-title").filter(function(){return $(this).index() == columnToChange});
            columnOptions.find("input").attr("disabled", false);
            
            (this).blur();   
         
           //if it is the critical text the display options change
            if (manuscriptToShow == "x"){
                $("input[name='notes']").parents("li").removeClass("hidden");
            };    
        });
    
    /*CLICKING ON VERSES*/
    $('.text-container').on('click', 'td.verse', function () {
        automaticScrolling = true; //to avoid conflict with SCROLLING function
        verse = $(this).parent().children('td.line_number').children('span.corresp_line').text(); // var verse stores the verse number (in the abstract edition), to be able to compare.
        correspVerses = $("tr").filter(function(){return $(this).children("td.line_number").find("span.corresp_line").text() == verse}); // The verses with the same number in other witnesses
        //Remove highlight all verses with the same verse number and hide empty verses if the extensive edition is off 
        $("tr").removeClass("highlight"); 
        if (extensiveEdition == false){
          $(".toHide").addClass("hidden")  
        };
        //calculate offsets and scrolls to align all witnesses and add highlight
        offsetFinal = $(this).offset().top;
        correspVerses.each(function(){
            $(this).removeClass("hidden");
            $(this).addClass("highlight");
            offsetInit = $(this).offset().top;
            scrollOrig = $(this).parents("div.text-container").scrollTop();
            scrollFinal = offsetInit + scrollOrig - offsetFinal;
            $(this).parents("div.text-container").scrollTop(scrollFinal);
            index = $(this).parents("div.edition-text").index(); //add the new scroll to the variable
            scrollController[index] = scrollFinal;
        });
    });    
    
/*    PRESSING UP-DOWN KEY*/
    $(document).keydown(function(e){
        automaticScrolling = true; //to avoid conflict with SCROLLING function
        switch(e.which){
              case 38: //up
               {$(".text-container").not(".paratext").has("table").each(function(){
                   curScroll = $(this).scrollTop();
                   $(this).scrollTop(curScroll - 40);
               }) ;
                break
                };
            case 40: //down
                   {$(".text-container").not(".paratext").has("table").each(function(){
                   curScroll = $(this).scrollTop();
                   $(this).scrollTop(curScroll + 40);
               }) ;
                break
                };
            }e.preventDefault();
        automaticScrolling = false; //to avoid conflict with SCROLLING function
    });    
    
/*    HOVER ON VERSE*/
    $(".text-container").on("mouseenter", "td.verse",function(){
            verseNum = $(this).prev("td.line_number").children("span.corresp_line").text();
           correspVerses = $("tr").filter(function(){return $(this).children("td.line_number").children("span.corresp_line").text() == verseNum});
           correspVerses.addClass("highlight-hover");
    });
     $(".text-container").on("mouseout", "td.verse",function(){
            verseNum = $(this).prev("td.line_number").children("span.corresp_line").text();
           correspVerses = $("tr").filter(function(){return $(this).children("td.line_number").children("span.corresp_line").text() == verseNum});
           correspVerses.removeClass("highlight-hover");
    });
    
/*    SCROLLING*/
    $(".text-container").on("scroll", function(event){
        if (automaticScrolling === true){
            automaticScrolling = false}
        else {
            console.log("scroll");
            index = $(this).parent(".edition-text").index();
            newScroll = $(this).scrollTop();
            if (groupScroll === true){
                originalScroll = scrollController[index];
                distance = newScroll - originalScroll;
                $(".text-container").not(event.target).each(function(){
                    if ($(this).is(":parent")){
                        ind = $(this).parent(".edition-text").index();
                        origScroll = scrollController[ind];
                        finalScroll = origScroll + distance;
                        $(this).scrollTop(finalScroll);
                        scrollController[ind] = finalScroll;
                        };
                    });
                };
            scrollController[index] = newScroll;
            console.log(scrollController);
        };
    })
    
    
/*    Collation opens when clicking on verse number*/
   $('#vers-collation-tool').click(function () {
        window.open("vers-collation.html");    
    });
    
/*    LANGUAGE SELECTOR*/ 
    
    $("a.language-selector").click(function(){
        language = $(this).attr("id");
        languageCheck(language);
        languageSelector(language);
    });
    
/*    OPTIONS*/
/*    Option: Abreviations*/
     $("input[name^=abbreviaturen]").change(function(){
        var column = ($(this).parents(".text-title")).index();
         if ($(this).is(":checked")){
             $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.expansion").removeClass("hidden");
              $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.abbr").addClass("hidden");
         }
         else {
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.expansion").addClass("hidden");
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.abbr").removeClass("hidden");
            }
     });
     
     /*    Option: Paleographic view*/
    $("input[name^=korrekturen]").change(function(){
        var column = ($(this).parents(".text-title")).index();
        if ($(this).is(":checked")){
              $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.del").removeClass("hidden");
              $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.paleog").removeClass("hidden");
              $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.bracket").removeClass("hidden");
              $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.edited").addClass("hidden");
              
         }
         else {
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.del").addClass("hidden");
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.paleog").addClass("hidden");
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.bracket").addClass("hidden");
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.edited").removeClass("hidden");
            }
    });
    
/*    Option: Punctuation*/
     $("input[name^=punktion]").change(function(){
         var column = ($(this).parents(".text-title")).index();
         if ($(this).is(":checked")){
              $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.punctuation").removeClass("hidden");
         }
         else {
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.punctuation").addClass("hidden");
            }
     });
     
/*     Option: Normalisation (not working)*/
    $("input[name^=normalisierung]").change(function(){
        var column =($(this).parents(".text-title")).index();
        if ($(this).is(":checked")){
             $(".text-container").filter(function(){return $(this).parent().index() == column}).find("td.verse").contents().filter(function(){return this.nodeType === 3;}).each(function(){
                 $(this).replace("ſ","s");
             });
        }
    });
    
    /*    Option: Paleographic view*/
    $("input[name^=korrekturen]").change(function(){
        var column = ($(this).parents(".text-title")).index();
        if ($(this).is(":checked")){
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.only_pal").removeClass("hidden");
        }
        else {
            $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.only_pal").addClass("hidden");
        };
    });
    
    /*    Option: Right Margin References*/
        $("input[name^=notes]").change(function(){
            var column = ($(this).parents(".text-title")).index();
            if ($(this).is(":checked")){
                $(".text-container").filter(function(){return $(this).parent().index() == column}).find("td.folioetc").removeClass("hidden");
            }
            else{
                $(".text-container").filter(function(){return $(this).parent().index() == column}).find("td.folioetc").addClass("hidden");
            };
        });
    
    
/*    Option: Numbering (Manuscript or Edition)*/
    $("input[name^=numerierung]").change(function(){
        var column = ($(this).parents(".text-title")).index();
        if ($(this).val() == "manuscript"){
        $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.line").removeClass("hidden");
        $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.corresp_line").addClass("hidden");
        }
        if ($(this).val() == "edition"){
        $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.line").removeClass("hidden");
        $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.corresp_line").addClass("hidden");
        }
        else if ($(this).val() == "alt_ed"){
        $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.line").addClass("hidden");
        $(".text-container").filter(function(){return $(this).parent().index() == column}).find("span.corresp_line").removeClass("hidden");
        } 
    });
    
    
    
/*    Body Padding so that the navbar don't go over the texts */
    function setBodyTop(titleHeight){
    var textTitlesNavHeight = $("#text-titles-nav").height();
    var bodyPadding = titleHeight + textTitlesNavHeight + 5;
    $('body').animate({ paddingTop: bodyPadding}, 20);  
    };
    setBodyTop(titleHeightBig);

});