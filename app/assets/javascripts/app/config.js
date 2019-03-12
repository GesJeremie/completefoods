(function () {
    'use strict';

    window.app.config = {
        breakpoints: {
            'small': 480,
            'medium': 760,
            'wide': 960,
            'x-wide': 1160,
            'xx-wide': 1310
        },
        modalNewsletter: {
            delayBeforeToShow: 7000, // 7 seconds
            cookieExpirationTime: 7 // 7 days
        }
    };
}());
