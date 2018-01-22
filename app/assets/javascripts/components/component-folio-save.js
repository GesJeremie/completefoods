(function()  {
    'use strict';

    Vue.component('component-folio-save', {
        props: ['currentUser'],

        data: function() {
            return {
                role: JSON.parse(this.currentUser).role,
                haveAFolioClicked: false
            }
        },

        watch: {
        },

        created: function() {
        },

        computed: {
            isAnonymous: function() {
                return this.role === 'anonymous';
            },

            isUser: function() {
                return this.role === 'user';
            },

            textHaveAFolio: function() {
                if (this.haveAFolioClicked) {
                    return 'Cancel';
                }

                return 'Already have a folio?';
            },

            shouldRenderSubscribe: function() {
                return this.isAnonymous && !this.haveAFolioClicked;
            },

            shouldRenderConnect: function() {
                return this.isAnonymous && this.haveAFolioClicked;
            }
        },

        methods: {
            onClickHaveAFolio: function()  {
                this.haveAFolioClicked = !this.haveAFolioClicked;
            }
        }
    });

}());
