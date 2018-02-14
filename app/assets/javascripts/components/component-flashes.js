(function()  {
    'use strict';

    Vue.component('component-flashes', {
        mixins: [
            window.mixins.notification
        ],

        props: [
            'error',
            'notice',
            'success'
        ],

        created: function() {
            // Could be improved
            if (!_.isEmpty(this.error)) {
                this.$notification.show('error', this.error);
                return;
            }

            if (!_.isEmpty(this.notice)) {
                this.$notification.show('notice', this.notice);
                return;
            }

            if (!_.isEmpty(this.success)) {
                this.$notification.show('success', this.success);
            }
        },

        render: function(noTemplate) {
            return noTemplate();
        }
    });

}());
