#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 28 16:35:14 2018

@author: ghkim
"""

import numpy as np
from scipy.ndimage import maximum_filter
from scipy import signal
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.axes3d import Axes3D
from matplotlib import cm


import parameter as par
import movie_io as fr

def remove_background(one_frame, thre):
    return one_frame * (one_frame > thre)
    
def peak_find(dire, movie_name, param):
    movie = fr.frame(dire, movie_name, param)
    peak_data = [0, 0]
    for i in range(movie.length):
        one_frame = remove_background(movie.get_next_frame(), 30)
        temp = find_from_intensity(one_frame)
        peak_data = np.vstack((peak_data, temp))
    return peak_data[1:]

def find_from_intensity(one_frame, gridsize = 8):
    max_point = [0,0]
    for i in range(512//gridsize):
        start_x = i * gridsize
        for j in range(512//gridsize):
            start_y = j * gridsize
            grided_image = one_frame[start_x:start_x+gridsize, start_y:start_y+gridsize]
            if grided_image.max() == 0:
                continue;
            ind = np.unravel_index(np.argmax(grided_image, axis=None), grided_image.shape)
            if (grided_image[ind[0] - 1:ind[0] + 1, ind[1] - 1:ind[1] + 1] > grided_image[ind[0], ind[1]] * 0.4).sum() - 1 >= 2:
                max_point = np.vstack([max_point, [ind[0]+start_x, ind[1]+start_y]])
    return max_point[1:]