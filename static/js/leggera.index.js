$(document).ready(function(){
    $('.navbar ul > li > a').click(function(){
        $('html, body').animate({
            scrollTop: $('[id="' + $.attr(this, 'href').substr(1) + '"]').offset().top - 50
        }, 500);
        return false;
    });

    $('.navbar .navbar-brand').click(function(){
        $('html, body').animate({
            scrollTop: 0
        }, 500);
        return false;
    });
});
