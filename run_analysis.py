#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Sep 22 05:54:39 2018

@author: ghkim
"""

import movie_io as mv
import parameter as par
import numpy as np
import tools as tl

def main():
    data_name = 'hel002.pma'
    data_path = '/media/ghkim/HDD1/smb/fret-tracking/8_23_analysis'
    param = tl.init_param()
    peak_data = tl.get_peak_data(data_path, data_name, param)
    peak_image = tl.peak_data2peak_image(peak_data)
    kernel_data = tl.get_kernel_intensity(peak_data, peak_image, kernel_rad = 5)
if __name__ == "__main__":
    main()