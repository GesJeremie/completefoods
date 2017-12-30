App.component('folio', function($scope) {
    'use strict';

    function Folio() {

        this.$scope = null;
        this.coins = {};
        this.updatedAgo = 0;

        this.init = function($scope) {
            this.$scope = $scope;
            this.setup();
        };

        this.setup = function() {
            this.events();
        };

        this.events = function() {
            $(document).on('coin:updated', this.onCoinUpdated.bind(this));
            $(document).on('coin:deleted', this.onCoinDeleted.bind(this));
            setInterval(function() {
                this.updatedAgo++;
                $('.folio__updated', this.$scope).html('Updated ' + this.updatedAgo + ' seconds ago');
            }.bind(this), 1000);
        };

        /**
         * Events
         */

        this.onCoinUpdated = function(e, data) {
            this.updatedAgo = 0;
            this.coins[data.coinSymbol] = parseFloat(data.valueHold);
            this.renderSum();
        };

        this.onCoinDeleted = function(e, data) {
            this.coins = _.omit(this.coins, data.coinSymbol);
            this.renderSum();
        };

        /**
         * Methods
         */

        this.renderSum = function() {
            var sum = this.calculateSum();

            this.$total().removeClass('folio__total--down folio__total--up');

            if (sum > this.getTotal()) {
                // Browsers batch the operations.
                // We need to delay to see the animation.
                _.delay(function() {
                    this.$total().addClass('folio__total--up')
                }.bind(this), 100);
            }

            if (sum < this.getTotal()) {
                // Browsers batch the operations.
                // We need to delay to see the animation.
                _.delay(function() {
                    this.$total().addClass('folio__total--down');
                }.bind(this), 100);
            }

            this.setTotal(sum);

            this.$total().html('&euro;' + sum.toFixed(2));
        };

        this.calculateSum = function() {
            return _(this.coins).values().sum();
        };

        /**
         * Getters
         */

        this.getTotal = function() {
            return parseFloat(this.$scope.attr('data-total'));
        };

        /**
         * Setters
         */
        this.setTotal = function(total) {
            this.$scope.attr('data-total', total);
        };

        /**
         * DOM accessors
         */
        this.$total = function() {
            return $('.folio__total', this.$scope);
        };

    }


    $('[data-component-folio]').each(function() {
        new Folio().init($(this));
    });
});
