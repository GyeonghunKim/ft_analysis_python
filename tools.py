#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 21 20:46:19 2018

@author: ghkim
"""

import parameter as par
import movie_io as fr


import numpy as np
from scipy.ndimage import maximum_filter
from scipy import signal
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.axes3d import Axes3D
from matplotlib import cm
def init_param():
    param = par.parameter()
    param.add_attr('background', 0)
    param.add_attr('sub_rad', 4)
    return param

def make_stacked_peak(dire, movie_name, param):
    movie = fr.frame(dire, movie_name, param)
    stacked_peak = np.zeros([512, 512], dtype = np.int)
    for i in range(movie.length):
        one_frame = movie.get_next_frame()
        stacked_peak += np.array(find_peak_from_kmft(one_frame, param, output_type = 'image'), dtype=np.int)
    return stacked_peak
        
def find_peak_from_kmft(image, param, background = None, maxfiltersize = 3, output_type = 'peakdata'):
    image = np.array(image, dtype = np.float32)
    if background is None:
        background = param.get_attr('background')
    nbimage = (image - background) # image_wobg = image without background; background can be scalar or 512*512 np array
    nbimage = (1 - (nbimage)) * nbimage / 2
    max_filter = maximum_filter(nbimage, size = maxfiltersize)
    ispeak = (nbimage == max_filter)
    ispeak = np.array(ispeak, dtype = bool)
    nearfilter = np.ones([3,3], dtype=np.float32)/9
    isinten = np.array(nbimage > signal.convolve2d(nbimage, nearfilter, boundary='symm', mode='same'), dtype=bool)
    ispeak = np.logical_and(ispeak, isinten)
    xsize = int(param.get_attr('movie_x_size'))
    ysize = int(param.get_attr('movie_y_size'))
    data = [0,0]
    if output_type == 'image':
        return ispeak
    else:
        for i in range(xsize):
            for j in range(ysize):
                if ispeak[i, j]:
                    data = np.vstack((data, [i, j]))
        return data[1:]

def make_stacked_image(dire, movie_name, param, thre = 30):
    movie = fr.frame(dire, movie_name, param)
    stacked_movie = np.zeros([512, 512], dtype = np.float)
    mv_length = movie.length
    for i in range(mv_length):
        one_frame = np.array(movie.get_next_frame(), dtype = float)
        stacked_movie += one_frame * (one_frame > thre) / mv_length
    return stacked_movie

def peak_select_from_hist(peakimg):
    tmp = np.array(peakimg, dtype=np.int)
    peakimg_int = tmp.reshape([512*512, 1])
    tp = peakimg_int[peakimg_int!=0]
    print(tp)
    hst = plt.hist(tp)
    tau = hst[0][0]/sum(hst[0])
    tmp[tmp < (tau + 1)] = 0
    return tmp

def show_3d_peak(peakimg):
    x = np.arange(0, 512)
    y = np.arange(0, 512)
    X, Y = np.meshgrid(x, y)
    fig = plt.figure(figsize=(14,6))
    ax = fig.gca(projection='3d')
    p = ax.plot_surface(X, Y, peakimg, rstride=1, cstride=1, cmap=cm.coolwarm, linewidth=0, antialiased=False)
    cb = fig.colorbar(p, shrink=0.5)


def remove_background(one_frame, thre):
    return one_frame * (one_frame > thre)
    
def get_peak_data(dire, movie_name, param):
    movie = fr.frame(dire, movie_name, param)
    peak_data = [0, 0]
    for i in range(movie.length):
        one_frame = remove_background(movie.get_next_frame(), 30)
        temp = find_peak_from_kmft(one_frame, param, output_type = 'peakdata')
        peak_data = np.vstack((peak_data, temp))
    return peak_data[1:]
    
def peak_data2peak_image(peak_data):
    peak_image = np.zeros([512, 512],dtype = np.int)
    for i in peak_data:
        peak_image[i[0], i[1]] += 1
    return peak_image
    

    
def get_kernel_intensity(peak_data, one_frame, kernel_rad):
    kernel_intensity = [0,0,0]
    for one_point in peak_data:
        if ((one_point[0] > kernel_rad) and(one_point[0] < 512 - kernel_rad)) and ((one_point[1] > kernel_rad) and(one_point[1] < 512 - kernel_rad)):
            tmp = [one_point[0], one_point[1], one_frame[one_point[0]-kernel_rad:one_point[0]+kernel_rad, one_point[1]-kernel_rad:one_point[1]+kernel_rad].sum()]
            kernel_intensity = np.vstack((kernel_intensity, tmp))
            print(kernel_intensity)
    return kernel_intensity[1:]
    
    
    
    
    
    
    
    
    