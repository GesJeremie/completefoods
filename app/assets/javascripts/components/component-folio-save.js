(function()  {
    'use strict';

    Vue.component('component-folio-save', {
        props: [
            'currentUser'
        ],

        data: function() {
            return {
                role: JSON.parse(this.currentUser).role,
                haveAFolioClicked: false
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
                return this.isAnonymous && !this.haveAFolioClicked;
            },

            shouldRenderConnect: function() {
                return this.isAnonymous && this.haveAFolioClicked;
            },

            textHaveAFolio: function() {
                if (this.haveAFolioClicked) {
                    return 'Cancel';
                }

                return 'Already have a folio?';
            }
        },

        methods: {
            onClickHaveAFolio: function()  {
                this.haveAFolioClicked = !this.haveAFolioClicked;
            }
        }
    });

}());
