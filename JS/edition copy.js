$(document).ready(function () {
    $('.tooltip').tooltip({
        //allows tooltip
        placement: "bottom",
        trigger: "hover"
    });
    
    $('.form-control').prop('selectedIndex', 0);
    //Resets the text selectors to None
    
    /*    VARIABLES*/
    var language = "en";
    var extensiveEdition = false;
    var groupScroll = false;
    var scrollController =[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // to move all scrolls at the same time, see scroll function
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
    function languageCheck(language) {
        $(".lang").addClass("hidden");
        $("[lang='" + language + "']").removeClass("hidden");
    };
    
    function languageSelector(language) {
        if (language == "en") {
            $("option[value ='default']").text("Select text");
            $("option[value*='_krit']").text("Critical Text");
            $("option[value*='_app']").text("Critical Apparatus");
        }
        if (language == "de") {
            $("option[value ='default']").text("Textauswählen");
            $("option[value*='_krit']").text("Kritischer Text");
            $("option[value*='_app']").text("Kritischer Apparat");
        }
        if (language == "es") {
            $("option[value ='default']").text("Seleccionar Texto");
            $("option[value*='_krit']").text("Texto crítico");
            $("option[value*='_app']").text("Aparato crítico");
        }
    };
    
    /*   END FUNCTIONS */
    
    /*    disable extensive edition*/
    $("#extensive-edition-toggle").prop('checked', false);
    
    /*    Form Control - Text Selector appearence*/
    $(".form-control").addClass("form-control-initial");
    $(".form-control").hover(
    function () {
        $(this).removeClass("form-control-initial");
        $(this).addClass("hover");
    },
    function () {
        $(this).removeClass("hover");
        $(this).addClass("form-control-initial");
    });
    
    /*    LANGUAGE CHECK*/
    languageCheck(language);
    languageSelector(language);
    
    
    
    /*  COLUMNS TO DISPLAY*/
    $("input[name=number-cols]").change(function () {
        numcolumns = parseInt($(this).val());
        width = 12 / numcolumns;
        $(".text-title").each(function (index) {
            // Text selectors
            if (index + 1 > numcolumns) {
                $(this).addClass("hidden")
            }
            if (index + 1 <= numcolumns) {
                $(this).removeClass();
                $(this).addClass("text-title")
                $(this).addClass("col-md-" + width);
            }
        });
        $(".edition-text").each(function (index) {
            // The texts columns themselves
            $(this).removeClass();
            $(this).addClass("edition-text");
            $(this).addClass("col-md-" + width);
            if (index + 1 > numcolumns) {
                $(this).addClass("hidden");
            }
        });
    });
    
    
    /* GLOBAL OPTIONS*/
    $("#extensive-edition-toggle").change(function () {
        if (extensiveEdition === false) {
            //extensive edition turns on
            $(".toHide").removeClass("hidden");
            // removes the hidden empty verses
            extensiveEdition = true;
        } else {
            //extensive edition turns off
            $(".toHide").addClass("hidden");
            $(".highlight").removeClass("hidden");
            extensiveEdition = false;
        };
    });
    //group scrollin
    $("#group-scroll").change(function () {
        if (groupScroll === false) {
            groupScroll = true;
        } else {
            groupScroll = false;
        };
    });
    
    
    /*    LOAD TEXTS*/
    $(".form-control").change(function () {
        //Reduces title if it is the first time a text is loaded
        counter = counter + 1;
        if (counter == 1) {
            $("#maereTitle").animate({
                fontSize: smallFontTitle
            },
            400);
            $("#text-titles-nav").animate({
                top: titleHeightSmall
            },
            400);
            setBodyTop(titleHeightSmall);
            //Set the height
            var viewportHeight = $(window).height();
            var textTitlesNavHeight = $("#text-titles-nav").height();
            var textContainerHeight = viewportHeight - titleHeightSmall - textTitlesNavHeight;
            $(".text-container").height(textContainerHeight);
            $("#row_introduction").addClass("hidden");
            //hide all non used columns
            cols = $("input[name = number-cols]:checked").attr("value");
            $("div.edition-text").each(function () {
                if ($(this).index() + 1 > cols) {
                    $(this).addClass("hidden")
                }
            });
        }
        
        //LOAD
        var optionValue = $(this).val().split('_');
        // Takes the attribute "value" of the selected option and turns it into an array. The first elemente is the text's code, then the testimony
        var maere = optionValue[0]; // characters code for text
        var manuscriptToShow = '#' + optionValue[1]; // character code for manuscript
        var columnToChange = ($(this).parents(".text-title")).index();
        // index of the column starting at 0
        var columnObject = $(".text-container").filter(function () {
            // the actual JQuery object for the column to change
            return $(this).parents(".edition-text").index() == columnToChange;
        });
        columnObject.empty();
        //Ajax request
        var request = $.ajax({
            url: 'JS/loadtext.php',
            type: 'get',
            data: {
                'manuscript': manuscriptToShow, 'text': maere
            }
        });
        
        request.always(function (data) {
            columnObject.append(data);
        });
        
        /*        To highlight the corresponding verses and move the scroll*/
        if ($("tr.highlight").length) {
            //check if there are already selected verses
            var counterStop = 0; // this will help to avoid infite loops of the function setInterval
            automaticScrolling = true; // to avoid weird scrolling
            var verse = $("tr.highlight").first();
            var verseNum = verse.children("td.line_number").children("span.corresp_line").text();
            var verseNumDigit = verseNum.substring(1);
            //The verse has an "s", it needs to be removed to be able to function as digit latter.
            var scrollToPrev = setInterval(function () { //Function to highlight, scroll and render text according to options
                counterStop = counterStop + 1;
                if (counterStop > 30) {
                    //stops function if it takes too long
                    clearInterval(scrollToPrev);
                };
                if (columnObject.children('table tbody tr:nth-child(' + verseNumDigit + ')')) {
                    //checks if the column already has a children in the place were the highlighted verse is, an indication that the DOM has finished loading
                    var correspRow = $(".edition-text").filter(function () {
                        //the row that needs to be highlighted and scrolled to
                        return $(this).index() == columnToChange
                    }).find("span.corresp_line").filter(function () {
                        return $(this).text() == verseNum
                    }).parents("tr");
                    if (typeof correspRow[0] != 'undefined') {
                        // if, for some reason the DOM has not finished loading and the row is seen as "undefined", then the function will end and start over. If not, the row will be highlighted and scrolled to and then the function will be over.
                        if (extensiveEdition === true) {
                            $(".toHide").removeClass("hidden")
                        };
                        correspRow.addClass("highlight");
                        var offsetFinal = verse.offset().top;
                        var offsetInitial = correspRow.offset().top;
                        var newScroll = offsetInitial - offsetFinal;
                        columnObject.scrollTop(newScroll);
                        scrollController[columnToChange] = newScroll;
                        // Render the text according to the selected options (visualization and numbering)
                        columnOptions.find("li[type='visualization']").find("input").each(function () {
                            var inputName = $(this).attr("name");
                            if ($(this).is(":checked")) {
                                $(this).prop("checked", false);
                            } else {
                                $(this).prop("checked", true);
                            };
                            $(this).trigger("click");
                        });
                        clearInterval(scrollToPrev);
                        // ends the function
                    };
                };
            },
            50);
        };
        (this).blur();
    });
    
    /*CLICKING ON VERSES*/
    $('.text-container').on('click', 'td.verse', function () {
        automaticScrolling = true; //to avoid conflict with SCROLLING function
        verse = $(this).parent().children('td.line_number').children('span.corresp_line').text();
        // var verse stores the verse number (in the abstract edition), to be able to compare.
        correspVerses = $("tr").filter(function () {
            return $(this).children("td.line_number").find("span.corresp_line").text() == verse
        });
        // The verses with the same number in other witnesses
        //Remove highlight all verses with the same verse number and hide empty verses if the extensive edition is off
        $("tr").removeClass("highlight");
        if (extensiveEdition == false) {
            $(".toHide").addClass("hidden")
        };
        //calculate offsets and scrolls to align all witnesses and add highlight
        offsetFinal = $(this).offset().top;
        correspVerses.each(function () {
            $(this).removeClass("hidden");
            $(this).addClass("highlight");
            offsetInit = $(this).offset().top;
            scrollOrig = $(this).parents("div.text-container").scrollTop();
            scrollFinal = offsetInit + scrollOrig - offsetFinal;
            $(this).parents("div.text-container").scrollTop(scrollFinal);
            index = $(this).parents("div.edition-text").index();
            //add the new scroll to the variable
            scrollController[index] = scrollFinal;
        });
    });
    
    /*    PRESSING UP-DOWN KEY*/
    $(document).keydown(function (e) {
        automaticScrolling = true; //to avoid conflict with SCROLLING function
        switch (e.which) {
            case 38: //up
            { $(".text-container").not(".paratext").has("table").each(function () {
                    curScroll = $(this).scrollTop();
                    $(this).scrollTop(curScroll - 40);
                });
                break
            };
            case 40: //down
            { $(".text-container").not(".paratext").has("table").each(function () {
                    curScroll = $(this).scrollTop();
                    $(this).scrollTop(curScroll + 40);
                });
                break
            };
        }
        e.preventDefault();
        automaticScrolling = false; //to avoid conflict with SCROLLING function
    });
    
    /*    HOVER ON VERSE*/
    $(".text-container").on("mouseenter", "td.verse", function () {
        verseNum = $(this).prev("td.line_number").children("span.corresp_line").text();
        correspVerses = $("tr").filter(function () {
            return $(this).children("td.line_number").children("span.corresp_line").text() == verseNum
        });
        correspVerses.addClass("highlight-hover");
    });
    $(".text-container").on("mouseout", "td.verse", function () {
        verseNum = $(this).prev("td.line_number").children("span.corresp_line").text();
        correspVerses = $("tr").filter(function () {
            return $(this).children("td.line_number").children("span.corresp_line").text() == verseNum
        });
        correspVerses.removeClass("highlight-hover");
    });
    
    /*    SCROLLING*/
    $(".text-container").on("scroll", function (event) {
        if (automaticScrolling === true) {
            automaticScrolling = false
        } else {
            index = $(this).parent(".edition-text").index();
            newScroll = $(this).scrollTop();
            if (groupScroll === true) {
                originalScroll = scrollController[index];
                distance = newScroll - originalScroll;
                $(".text-container").not(event.target).each(function () {
                    if ($(this).is(":parent")) {
                        ind = $(this).parent(".edition-text").index();
                        origScroll = scrollController[ind];
                        finalScroll = origScroll + distance;
                        $(this).scrollTop(finalScroll);
                        scrollController[ind] = finalScroll;
                    };
                });
            };
            scrollController[index] = newScroll;
        };
    })
    
    
    /*    Collation opens when clicking on verse number*/
    $('#vers-collation-tool').click(function () {
        window.open("vers-collation.html");
    });
    
    /*    LANGUAGE SELECTOR*/
    
    $("a.language-selector").click(function () {
        language = $(this).attr("id");
        languageCheck(language);
        languageSelector(language);
    });
    
    /*    OPTIONS*/
    
    /*    Global Options Change and trigger all witnesses to change*/
    $("input[name^=global]").change(function () {
        var selectedInput = $(this).attr("name").substring(7);
        if ($(this).is(":checked")) {
            $("input[name=" + selectedInput + "]").prop("checked", false);
            $("input[name=" + selectedInput + "]").trigger("click");
        } else {
            $("input[name=" + selectedInput + "]").prop("checked", true);
            $("input[name=" + selectedInput + "]").trigger("click");
        };
    });
    /*    Option: Punctuation (single witness)*/
    $("input[name=punktion]").click(function () {
        var column = ($(this).parents(".text-title")).index();
        if ($(this).is(":checked")) {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.punctuation").removeClass("hidden");
        } else {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.punctuation").addClass("hidden");
        }
    });
    
    /*    Option: Abreviations*/
    /*   Single witness         */
    $("input[name=abbreviaturen]").click(function () {
        var column = ($(this).parents(".text-title")).index();
        if ($(this).is(":checked")) {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.expansion").removeClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.abbr").addClass("hidden");
        } else {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.expansion").addClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.abbr").removeClass("hidden");
        }
    });
    
    /*    Option: Paleographic view*/
    $("input[name=korrekturen]").change(function () {
        var column = ($(this).parents(".text-title")).index();
        if ($(this).is(":checked")) {
            var actual_column =  $(".text-container").filter(function () {
                return $(this).parent().index() == column
            });
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.del").removeClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.pal").removeClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.bracket").removeClass("hidden");
        } else {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.del").addClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.pal").addClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.bracket").addClass("hidden");
        }
    });
    
    /*    Option: Paleographic view*/
    $("input[name=korrekturen]").change(function () {
        var column = ($(this).parents(".text-title")).index();
        if ($(this).is(":checked")) {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.del").removeClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.paleog").removeClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.bracket").removeClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.edited").addClass("hidden");
        } else {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.del").addClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.paleog").addClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.bracket").addClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.edited").removeClass("hidden");
        }
    });
    
    /*    Option: Right Margin References*/
    $("input[name=notes]").change(function () {
        var column = ($(this).parents(".text-title")).index();
        if ($(this).is(":checked")) {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("td.folioetc").removeClass("hidden");
        } else {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("td.folioetc").addClass("hidden");
        };
    });
    
    
    /*    Option: Numbering (Manuscript or Edition)*/
    $("input[name^=numerierung]").change(function () {
        var column = ($(this).parents(".text-title")).index();
        if ($(this).val() == "manuscript") {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.line").removeClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.corresp_line").addClass("hidden");
        }
        if ($(this).val() == "edition") {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.line").removeClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.corresp_line").addClass("hidden");
        } else if ($(this).val() == "alt_ed") {
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.line").addClass("hidden");
            $(".text-container").filter(function () {
                return $(this).parent().index() == column
            }).find("span.corresp_line").removeClass("hidden");
        }
    });
    
    
    
    /*    Body Padding so that the navbar don't go over the texts */
    function setBodyTop(titleHeight) {
        var textTitlesNavHeight = $("#text-titles-nav").height();
        var bodyPadding = titleHeight + textTitlesNavHeight + 5;
        $('body').animate({
            paddingTop: bodyPadding
        },
        20);
    };
    setBodyTop(titleHeightBig);
});