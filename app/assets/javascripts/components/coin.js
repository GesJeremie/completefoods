App.component('coin', function($scope) {
    'use strict';

    function Coin() {

        this.$scope = null;
        this.ticker = null;
        this.fetchingPrice = false;
        this.lastTickerPrice = 0;

        this.options = {
            refreshDelay: 10000 // ms
        };

        this.init = function($scope) {
            this.$scope = $scope;
            this.setup();
        };

        this.setup = function() {
            this.onTick();
            this.events();
        };

        this.events = function() {
            this.ticker = setInterval(this.onTick.bind(this), this.options.refreshDelay);
            this.$buttonDelete().on('click', this.onClickButtonDelete.bind(this));
        };

        /**
         * Events
         */

        this.onTick = function() {
            this.refresh();
        };

        this.onClickButtonDelete = function() {
            $(document).trigger('coin:deleted', {
                coinSymbol: this.getCoinSymbol()
            });
            this.destroy();
            this.$scope.parent().fadeOut('slow', function() {
                $(this).remove();
            });
        };

        this.onNoCoinsHold = function() {
            this.renderPrice(0, '&euro;')
            this.renderCoinsHold(0);
        };

        this.onFetchedPrice = function(response) {
            var priceValue;

            this.fetchingPrice = false;

            if (!response.success) {
                return;
            }

            if (response.ticker.price === this.lastTickerPrice) {
                return;
            }

            this.lastTickerPrice = response.ticker.price;

            priceValue = this.calculatePriceTotal(response.ticker.price, this.getCoinsHold());

            this.renderPrice(priceValue, '&euro;');
            this.renderCoinValue(this.lastTickerPrice, '&euro;');

            $(document).trigger('coin:updated', {
                coinSymbol: this.getCoinSymbol(),
                valueHold: priceValue
            });
        };

        /**
         * Methods
         */

        this.refresh = function() {
            if (!this.hasCoinsHold()) {
                this.onNoCoinsHold();
                return;
            }

            this.renderCoinsHold(this.getCoinsHold());
            this.fetchPrice();
        };

        this.fetchPrice = function() {
            var request;

            if (this.fetchingPrice) {
                return;
            }

            this.fetchingPrice = true;

            request = $.get('https://api.cryptonator.com/api/ticker/' + this.getCoinSymbol() + '-eur');

            request.done(this.onFetchedPrice.bind(this));
        };

        this.calculatePriceTotal = function(tickerPrice, coinsHold) {
            return (parseFloat(tickerPrice) * parseFloat(coinsHold)).toFixed(2);
        };

        this.renderCoinsHold = function(coinsHold) {
            this.$hold().html('Coins hold: ' + coinsHold);
            this.setCoinsHold(coinsHold);
        };

        this.renderPrice = function(price, symbol) {
            var oldPrice = this.getPriceTotal();

            this.$price().removeClass('coins__item-price--up coins__item-price--down');
            this.$arrow().removeClass('coins__item-arrow--up coins__item-arrow--down');

            if (price > oldPrice) {
                // Browsers batch the operations
                // We need to delay to see the animation.
                _.delay(function() {
                    this.$price().addClass('coins__item-price--up');
                }.bind(this), 100);

                this.$arrow().addClass('coins__item-arrow--up').html('<i class="icon-arrow-up"></i>');
            }

            if (price < oldPrice) {
                // Browsers batch the operations.
                // We need to delay to see the animation.
                _.delay(function() {
                    this.$price().addClass('coins__item-price--down');
                }.bind(this), 100);

                this.$arrow().addClass('coins__item-arrow--down').html('<i class="icon-arrow-down"></i>');
            }

            this.$price().html(symbol + price);

            this.setPriceTotal(price);
        };

        this.renderCoinValue = function(price, symbol) {
            this.$coinValue().html(this.getCoinSymbol() + ' Price: ' + symbol + parseFloat(price).toFixed(3));
        };

        /**
         * Conditions
         */
        this.hasCoinsHold = function() {
            return this.getCoinsHold() > 0;
        };

        /**
         * Getters
         */

        this.getCoinSymbol = function() {
            return this.$scope.attr('data-coin-symbol');
        };

        this.getCoinsHold = function() {
            return parseFloat(this.$scope.attr('data-coins-hold'));
        };

        this.getPriceTotal = function() {
            return parseFloat(this.$scope.attr('data-price-total'));
        };

        /**
         * Setters
         */
        this.setCoinsHold = function(coinsHold) {
            this.$scope.attr('data-coins-hold', coinsHold);
        };

        this.setPriceTotal = function(priceTotal) {
            this.$scope.attr('data-price-total', priceTotal);
        };

        /**
         * DOM accessors
         */
        this.$price = function() {
            return $('.coins__item-price', this.$scope);
        };

        this.$hold = function() {
            return $('.coins__item-hold', this.$scope);
        };

        this.$arrow = function() {
            return $('.coins__item-arrow', this.$scope);
        };

        this.$buttonDelete = function() {
            return $('.coins__item-actions', this.$scope).find('.button--danger');
        };

        this.$coinValue = function() {
            return $('.coins__item-coin-value', this.$scope);
        }

        /**
         * Unmount component
         */
        this.destroy = function() {
            this.ticker = null;
            this.$buttonDelete().off('click');
        };
    }


    $('[data-component-coin]').each(function() {
        new Coin().init($(this));
    });
});
