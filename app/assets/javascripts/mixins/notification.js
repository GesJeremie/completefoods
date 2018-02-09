(function()  {
    'use strict';

    window.mixins = window.mixins || {}

    window.mixins.notification = {
        computed: {
            $notification: function() {
                return {
                    show: function(type, message, duration) {
                        duration = duration || 5000;

                        new Noty({
                            type: type,
                            text: message,
                            timeout: 5000,
                            theme: 'custom'
                        }).show();
                    }
                }
            }
        }
    }
}());

