(function ($) {
    $.fn.dragonDrop = function(action, options) {
        var settings = $.extend({
            movingClass: "moving",
            ghostClass: "ghost",
            highlightClass: "highlight",
            dropCallback: function (dragged, dropped) {}
        }, options );

        if (action == 'drag') {
            return this.each(function() {
                $(this).mousedown(function (e) {
                    e.preventDefault();
                    $(this).addClass(settings.movingClass);
                    grabbed = $(this);
                });
            });
        }

        else if (action == 'drop') {
            return this.each(function() {
                $(this).mouseover(function () {
                    if(grabbed != null && $(this).has(grabbed).length == 0) {
                        $(this).addClass(settings.highlightClass);
                        ghostNode = grabbed.clone().addClass(settings.ghostClass);
                        $(this).append(ghostNode);
                    }
                }).mouseout(function () {
                    $(this).removeClass(settings.highlightClass);
                    if(ghostNode != null) {
                        ghostNode.remove();
                        ghostNode = null;
                    }
                }).mouseup(function () {
                    if(grabbed != null) {
                        grabbed.removeClass('moving');
                        grabbed.detach().appendTo($(this));
                        if(ghostNode != null) {
                            ghostNode.remove();
                            ghostNode = null;
                        }
                        settings.dropCallback(grabbed, $(this));
                    }
                });
            });
        }
    };

    $(window).mouseup(function () {
        grabbed = null;
    });

    var grabbed = null;
    var ghostNode = null;
}( jQuery ));
