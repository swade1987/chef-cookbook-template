#!/bin/bash

sudo $(which chef) gem install bundler
sudo $(which chef) exec rake ci