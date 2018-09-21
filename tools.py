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

from scipy.ndimage import maximum_filter

def init_param():
    param = par.parameter()
    param.add_attr('background', 0)
    param.add_attr('sub_rad', 4)
    return param

def make_stakced_peak(dire, movie_name, param):
    movie = fr.frame(dire, movie_name, param)
    for i in range(movie.length):
        one_frame = movie.get_next_frame()
        
def find_peak_from_kmft(image, param, background = None, maxfiltersize = 3, thre_rat = 0.4, output_type = 'image'):
    image = float(image)
    if background is None:
        background = param.get_attr('background')
    nbimage = (image - background) # image_wobg = image without background; background can be scalar or 512*512 np array
    nbimage = (1 - (nbimage)) * nbimage / 2
    max_filter = maximum_filter(nbimage, size = maxfiltersize)
    ispeak = (nbimage == max_filter)
    ispeak = np.array(ispeak, dtype = bool)
    xsize = int(self.param.get_attr('movie_x_size'))
    ysize = int(self.param.get_attr('movie_y_size'))
    if output_type == 'image':
        return ispeak
    else 
        data = np.array([])
        for i in range(self.xsize):
            for j in range(self.ysize):
                if ispeak[i, j] and (image[i, j] > thre_rat * image.max()):
                    data = np.append(data, [i, j], axis = 0)
        return data
