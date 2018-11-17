(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        current_row: 1,

        static: {
            targets: ['browseMore', 'divider']
        },

        /**
         * Boot
         */

        initialize: function () {
        },

        /**
         * Methods
         */

        disableBrowseMore: function () {
            $(this.browseMoreTarget).remove();
            $(this.dividerTarget).remove();
        },

        showRow: function (row) {
            $('.collections__item--row-' + row).css('display', 'inline-block');
        },

        isLimitReached: function () {
            var next_row = this.current_row + 1;

            return !$('.collections__item--row-' + next_row).length;
        },

        /**
         * Callbacks
         */

        onClickBrowseMore: function (e) {
            var row = this.current_row + 1;

            e.preventDefault();

            this.showRow(row);
            this.current_row = row;

            if (this.isLimitReached()) {
                this.disableBrowseMore();
            }
        }
    });

    window.app.stimulus.register('browse-collections', Controller);
}());
