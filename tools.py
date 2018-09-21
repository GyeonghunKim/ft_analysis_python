#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 21 20:46:19 2018

@author: ghkim
"""

import parameter as par
import peak as pk
import movie_io as fr
import trace as tr

def make_stakced_peak(dire, movie_name):
    param = par.parameter()
    param.add_attr('background', 0)
    param.add_attr('sub_rad', 4)
    movie = fr.frame(dire, movie_name, param)
    for i in range(frame.length):
        one_frame = movie.get_next_frame()
        



