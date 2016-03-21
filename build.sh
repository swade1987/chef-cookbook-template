#!/bin/bash

sudo $(which chef) exec bundle install
sudo $(which chef) exec rake ci