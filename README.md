express-uncapitalize
====================

A quite simple Express middleware module that will redirect user HTTP requests that contain uppercase letters, to the same URL in lowercase form.

This is primarily to ensure that dynamic routes (using dynamic parameters, e.g. :username) will be interpreted in their lowercase form. Some would argue that user input should be normalized individually, but I found this to be quicker, simpler overall solution to a bunch of code to normalize URL parameter input.

A 301 redirect is used to ensure that search engines treat the lowercase form of your URLs to be the canonical versions; this is important for SEO.

[View this project on npmjs.org](https://npmjs.org/package/express-uncapitalize)

Installation
------------
    
    $ npm install express-uncapitalize


Usage
-----

Simply add the following line as a middleware in your Express app.configure:

    app.use(require('express-uncapitalize')());

Placement of this middleware is important; if placed before your static middleware will redirect your requests to your static content as well:

    app.configure(function(){
        app.set('views', __dirname + '/views');
        app.set('view engine', 'jade');
        app.use(express.bodyParser());
        app.use(express.methodOverride());
        app.use(require('express-uncapitalize')());
        app.use(require('stylus').middleware(__dirname + '/public'));
        app.use(express.static(__dirname + '/public'));
        app.use(app.router);
    });
    
I generally prefer to place after the static middleware to only redirect requests managed by the router, i.e. only the content where there is likely to be database lookups where case sensitivity matters:

    app.configure(function(){
        app.set('views', __dirname + '/views');
        app.set('view engine', 'jade');
        app.use(express.bodyParser());
        app.use(express.methodOverride());
        app.use(require('stylus').middleware(__dirname + '/public'));
        app.use(express.static(__dirname + '/public'));
        app.use(require('express-uncapitalize')());
        app.use(app.router);
    });

Planned Features
----------------

This module is quite simple right now, and was really created to save time across many small projects I have. I plan to add conditional options in the future.

License 
-------

Copyright (c) 2012 Jamie Steven, jamiesteven on github.

Licensed under the MIT license

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.