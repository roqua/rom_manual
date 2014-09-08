RoQua User Manual
=================

This repository contains an user manual for RoQua ROM. The nicely formatted version [can be found here](http://roqua.github.io/rom_manual/).


Local development / preview
===========================

Running guard start a local server and recompiles the doc files when changed.

    bundle exec guard
    open http://localhost:9093/rom_manual


Publish to http://roqua.github.io/rom_manual
============================================

CircleCI will push to the githib pages when the tests pass.
