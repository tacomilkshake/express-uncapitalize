// express-uncapitlize
// Copyright (c) 2012 Jamie Steven, jamiesteven on github.
// Licensed under MIT

module.exports = function() {
    return function(req, res, next) {
        if (/[A-Z]/.test(req.url)) {
            res.redirect(301, req.url.toLowerCase());
        } else {
            next();
        }
    }
};