describe('stop animation', function () {

    var test, testee, testEl, testeeEl;

    beforeEach(function () {
        // Delete previous elements
        if (testEl && test) {
            testEl.parentNode.removeChild(testEl);
            test = null;
            testEl = null;
        }

        // Create DOM Elements
        testEl = document.createElement('div');
        document.body.appendChild(testEl);
        test = moofx(testEl);

    });

    describe('Existence', function () {
        it('should have a stop method', function () {
            expect(test.stop).to.be.a('function');
        });

        it('should stop the animation', function (next) {
            test.style.opacity = 0;

            var opacity = test.animate({opacity: 1}, {duration: '0.2s'});

            setTimeout(function () {
                var opacityValue = test.compute('opacity');
                opacity.stop();
                expect(test.compute('opacity')).to.be(opacityValue);
                next();
            }, 100);
        });
    });


    describe('Behaviour', function () {
        it('should stop the animation and set it\'s CSS to final stage', function(next){
            test.style.opacity = 0;

            var opacity = test.animate({opacity: 1}, {duration: '0.2s'});

            setTimeout(function () {
                test.stop(true);
                expect(test.compute('opacity')).to.be("1");
                next();
            }, 100);
        });

        it('should run the callback if not stopped', function (next) {
            test.style.opacity = 0;

            var opacity = test.animate({
                opacity: 1
            },{ callback: function () { return next(); } });

        });

        it('should not run the callback if stopped', function (next) {

            var wtf = false,
                animation = test.animate({ 'margin-left': '400px' }, {
                    duration: '5s',
                    // it should throw error if it reaches here
                    callback: function () { wtf = true; }
                });

            setTimeout(function () {
                test.stop();
                expect(wtf).to.not.be.ok();
                next();
            }, 100);

        });

        it('should not run the callback if hard stopped', function (next) {

            var wtf = false,
                animation = test.animate({ 'margin-left': '400px' }, {
                    duration: '5s',
                    // it should throw error if it reaches here
                    callback: function () { wtf = true; }
                });

            setTimeout(function () {
                test.stop(true);
                expect(wtf).to.not.be.ok();
                next();
            }, 100);

        });

        it('[BUGFIX] it should only run one callback', function (next) {

            var wtf = false,
                animation = test.animate({ 'margin-left': '400px' }, {
                    duration: '5s',
                    // it should throw error if it reaches here
                    callback: function () { wtf = true; }
                });

            setTimeout(function () {
                test.stop(true);
                expect(wtf).to.not.be.ok();

                test.animate({ 'margin-left': '400px' }, {
                    duration: '0.2s',
                    callback: function () { next(); }
                });
            }, 100);

        });

    });

});
