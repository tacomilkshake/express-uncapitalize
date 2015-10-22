// express-uncapitlize
// Copyright (c) 2012 Jamie Steven, jamiesteven on github.
// Licensed under MIT

module.exports = function() {
    return function(req, res, next) {
        var url = req._parsedUrl;
        if (/[A-Z]/.test(url.pathname)) {
            if (url.search == null) {
                url.search = '';
            }
            res.redirect(301, url.pathname.toLowerCase() + url.search);
        } else {
            next();
        }
    }
};
