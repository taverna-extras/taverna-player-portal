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
                    return false;
                });
            });
        }

        else if (action == 'drop') {
            return this.each(function() {
                $(this).mouseover(function () {
                    if(grabbed != null && !grabbed.is($(this)) && !grabbed.parent().is($(this))) {
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
                        if(!grabbed.is($(this)) && !grabbed.parent().is($(this))) {
                            grabbed.detach().appendTo($(this));
                            settings.dropCallback(grabbed, $(this));
                        }
                    }
                });
            });
        }
    };

    $(window).mouseup(function () {
        if(grabbed != null) {
            grabbed.removeClass('moving');
            if(ghostNode != null) {
                ghostNode.remove();
                ghostNode = null;
            }
            grabbed = null;
        }
    });
    var grabbed = null;
    var ghostNode = null;
}( jQuery ));

$(document).ready(function () {
    $('.folder-entry').dragonDrop('drag');
    $('.folder').dragonDrop('drop', {
        dropCallback: function(drag,drop) {
            $.ajax("/folders/" + drop.data('folder-id'),
                { type:'PUT',
                    dataType:'json',
                    data: {entry_id: drag.data('entry-id')}}
            );
        }
    });
});
