(function()  {
    'use strict';

    Vue.component('component-folio-save', {
        props: [
            'currentUser'
        ],

        data: function() {
            return {
                role: JSON.parse(this.currentUser).role,
                toggled: false
            }
        },

        computed: {
            isAnonymous: function() {
                return this.role === 'anonymous';
            },

            isUser: function() {
                return this.role === 'user';
            },

            shouldRenderSubscribe: function() {
                return this.isAnonymous && this.toggled;
            },

            shouldRenderConnect: function() {
                return this.isAnonymous && !this.toggled;
            },

            textToggle: function() {
                if (this.toggled) {
                    return 'Cancel';
                }

                return 'You don\'t have a folio yet? Save this one!';
            }
        },

        methods: {
            onClickToggle: function()  {
                this.toggled = !this.toggled;
            }
        }
    });

}());
