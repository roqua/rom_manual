// Init sidebar
$(function() {
  var activeItem,
      helpList = $('#js-sidebar .js-topic'),
      firstOccurance = true,
      styleTOC = function() {
        var pathRegEx = /\/\/[^\/]+(\/.+)/g,
            docUrl = pathRegEx.exec(window.location.toString())
        if (docUrl){
          $('#js-sidebar .js-topic a').each(function(){
            if ($(this).parent('li').hasClass('disable'))
              $(this).parent('li').removeClass('disable')

            var url = $(this).attr('href').toString()
            var cleanDocUrl = docUrl[1]
            if(url.indexOf(cleanDocUrl) >= 0 && url.length == cleanDocUrl.length){
              $(this).parent('li').addClass('disable')
              var parentTopic = $(this).parentsUntil('div.sidebar-module > ul').last()
              parentTopic.addClass('js-current')
              parentTopic.find('.js-expand-btn').toggleClass('collapsed expanded')
            }
          });
        }
      }

  // bind every href with a hash; take a look at v3/search/ for example
  $('#js-sidebar .js-accordion-list .js-topic a[href*=#]').bind("click", function(e) {
    if (window.location.toString().indexOf($(e.target).attr('href')) == -1)
      setTimeout(styleTOC, 0); // trigger the window.location change, then stylize
  });

  // hide list items at startup
  if($('body.api') && window.location){
    styleTOC();
  }

  $('#js-sidebar .js-topic').each(function(){
    if(($(this).find('.disable').length == 0 || firstOccurance == false) &&
    $(this).hasClass('js-current') != true){
      $(this).find('.js-guides').children().hide()
    } else {
      activeItem = $(this).index()
      firstOccurance = false
    }
  })

  // Toggle style list. Expanded items stay
  // expanded when new items are clicked.
  $('#js-sidebar .js-toggle-list .js-expand-btn').click(function(){
    var clickedTopic = $(this).parents('.js-topic'),
        topicGuides  = clickedTopic.find('.js-guides li')
    $(this).toggleClass('collapsed expanded')
    topicGuides.slideToggle(100)
    return false
  })

  // Accordion style list. Expanded items
  // collapse when new items are clicked.
  $('#js-sidebar .js-accordion-list .js-topic h3 a').click(function(){
    var clickedTopic = $(this).parents('.js-topic'),
        topicGuides = clickedTopic.find('.js-guides li')

    if(activeItem != clickedTopic.index()){
      if(helpList.eq(activeItem)){
        helpList.eq(activeItem).find('.js-guides li').slideToggle(100)
      }
      activeItem = clickedTopic.index()
      topicGuides.slideToggle(100)
    } else {
      activeItem = undefined
      topicGuides.slideToggle(100)
    }

    return false
  })

  // Dynamic year for footer copyright
  var currentYear = (new Date).getFullYear();
  $("#year").text( (new Date).getFullYear() );

  // Add link anchors for headers with IDs
  $(".content h1, .content h2, .content h3, .content h4").each(function(e){
    var id = $(this).attr("id");
    if (!id) return;

    $(this).prepend("<a class='header-anchor' href='#" + id + "'></a>");
  });

});
