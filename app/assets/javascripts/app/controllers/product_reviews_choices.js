/**
 * ProductReviewsChoices
 */

(function() {
    'use strict';

    var Controller = new Class({

        extends: Stimulus.Controller,

        static: {
            targets: ['choice', 'meaning'],
        },

        meanings: {
            0: 'You threw the product in your garbage - and you peed on it.',
            1: 'You will eat it if you have to - but you sincerely hope not.',
            2: 'You are torn, it\'s not that bad but it\'s not that great.',
            3: 'You placed a new order.',
            4: 'You found THE one - and will eat only that for the rest of your life.'
        },

        initialize: function () {
            var score = this.data.get('startsScore');

            this.updateMeaning(score);
        },

        removeClassActiveChoices: function () {
            var $choices = $(this.targets.findAll('choice'));

            $choices.removeClass('active');
        },

        updateMeaning: function (score) {
            var meaning = '<strong>Meaning: </strong>' + this.meanings[score];

            $(this.meaningTarget).html(meaning);
        },

        onClickChoice: function (event) {
            event.preventDefault();

            var $this = $(event.currentTarget),
                score = $this.data('score');

            this.updateMeaning(score);
            this.removeClassActiveChoices();
            $this.addClass('active');
        },
    });

    window.app.stimulus.register('product-reviews-choices', Controller);
}());
