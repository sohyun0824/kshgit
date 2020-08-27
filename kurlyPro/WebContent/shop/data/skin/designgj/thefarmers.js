/*
 * ���ĸӽ� ��ũ��Ʈ
 */

// 2018-10-30 ������ : PD-822 PC) ��ٱ��� ��� ��� > ���̾� �˾� ������ ���� ����
var goodsListItemCartButtonCheck = false;
// end
window.thefarmers = (function ($) {

    var thefarmers = {};
    var zIndex = 10000;

    thefarmers.callback = {};

    function closeAskLayer () {
        $(this).closest('.ask-layer-wrapper').remove();
    }

    $(document).on('click', '[data-ask-callback-key]', function ($e) {
        $e.preventDefault();
        var callbackKey = $(this).data('ask-callback-key');
        if (thefarmers.callback[callbackKey]) {
            thefarmers.callback[callbackKey].call(this, {
                close: closeAskLayer.bind(this)
            });

            // 2018-10-30 ������ : PD-822 PC) ��ٱ��� ��� ��� > ���̾� �˾� ������ ���� ����
            goodsListItemCartButtonCheck = false;
            // end
        }
    }).on('click', '.ask-alert-close-button, .ask-layer-background', function ($e) {
        $e.preventDefault();
        closeAskLayer.call(this);

        // 2018-10-30 ������ : PD-822 PC) ��ٱ��� ��� ��� > ���̾� �˾� ������ ���� ����
        goodsListItemCartButtonCheck = false;
        // end
    });

    thefarmers.ask = function (config, buttons, success) {
        // callbacks ����
        $.each(buttons, function (key, value) {
            if (value.callback) {
                var rkey;
                do {
                    rkey = parseInt(+new Date * Math.random(), 10);
                } while ( value.callback[rkey] );
                var callback = value.callback;
                thefarmers.callback[ rkey ] = callback;
                //"onclick='thefarmers._callback[1237345875].call(this, window.event);'"
                value.callback = rkey;
            }
        });
        if (typeof config === "string") {
            config = {
                "type": "message",
                "message": config,
                "title": "�˸��޼���"
            };
        }
        $.post("/shop/proc/ask-message.php", {
            "type": config.type || "message",
            "content": config.message || config.content || "",
            "title": config.title,
            "buttons": buttons
        }, function (askWindow) {
            $('body').prepend(askWindow);
            var $layer = $('.ask-layer-wrapper').last().css('zIndex', zIndex++);
            $layer.find(':tabbable')[0].focus();
            var $window = $layer.find('.ask-alert-window');
            var $contents = $window.find('> *');
            var totalHeight = 0;
            $contents.map(function(){return $(this).outerHeight()}).each(function (i, value) {
                totalHeight += value;
            });
            $window.height( totalHeight );
            success && success($layer);
        });
    };

    thefarmers.alert = function (config, success) {
        this.ask(config, {
            "Ȯ��": {
                "className": "__active",
                "callback": function (control) {
                    control.close();
                    success && success();
                }
            }
        });
    };
    thefarmers.confirm = function (config, success) {
        this.ask(config, {
            "���": {
                "callback": function (control) {
                    control.close();
                }
            },
            "Ȯ��": {
                "className": "__active",
                "callback": function (control) {
                    control.close();
                    success && success();
                }
            }
        });
    };

    /*
    thefarmers.alert({"title":"���ɻ�ǰ���","message":"������ ��ǰ�� �������ּ���."}).then(function () {
      
    }, function () {
      
    });
    thefarmers.confirm();
    
    thefarmers.ask({"title":"���ɻ�ǰ ���","message":"�����Ͻ� ��ǰ�� ���ɻ�ǰ�� ��ҽ��ϴ�.<br>���� ���ɻ�ǰ�� Ȯ���Ͻðڽ��ϱ�?"},{
      "���� ����ϱ�": {
        "callback": function () {
          
        }
      },
      "���ɻ�ǰ Ȯ��": {
        "className": "__active",
        "callback": function () {
          
        }
      }
    });
    
    */
    return thefarmers;

}(jQuery));