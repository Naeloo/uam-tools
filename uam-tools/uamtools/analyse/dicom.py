import matplotlib
from matplotlib.widgets import Slider
from matplotlib import animation
import matplotlib.pyplot as plt
import pydicom
import os
import time
import numpy as np

#class DicomFigure:
#    def __init__(self, datasets: ):
#        self.datasets = datasets
#    def prepare(self):
#        pass
#    def prepare_image(self):
#        pass
#    def prepare_


def update_ds(ds, im):
    print(ds[0x0020, 0x0032].value[0])
    im.set_data(ds.pixel_array)

def view_dicom(path):
    matplotlib.use('TkAgg')
    #filename = get_testdata_files("CT_small.dcm")[0]
    print("Reading DICOMs")
    path = "/home/leonhard/Documents/FH/PRT/dicom/0190165010_20a_F/DICOM/0000DFBE/AA2A53B4/AAE2261D/000071E9"
    files = os.listdir(path)
    datasets = [pydicom.dcmread(os.path.join(path, file)) for file in files]
    datasets.sort(key=lambda ds: ds[0x0020, 0x0032].value[0])
    #print(datasets[0])
    print(f"Total of {len(datasets)} from x mm to x mm")
    # Identify areas in DS 0
    print("Identifying air areas")
    air_mask = identify_air_areas(datasets[0])
    print("Starting UI")
    # UI
    fig = plt.figure()
    extent = 0, 400, 0, 400

    aximg = plt.axes([0, .1, 1, .9])
    im = aximg.imshow(datasets[0].pixel_array, cmap=plt.cm.bone, extent=extent)
    
    #z1 = np.add.outer(range(20), range(20)) % 2
    #za = np.array(z1, dtype='uint8')
    #za[z1 > 0] = 0
    #za[z1 < 1] = 1
    #print(z1)
    #print(za)
    aximg.imshow(np.full((400, 400), 1000), extent=extent, alpha=air_mask)

    axdepth = plt.axes([0.25, 0, 0.65, 0.03])
    freq_slider = Slider(
        ax=axdepth,
        label='Depth [mm]',
        valmin=0,
        valmax=len(datasets)-1,
        valstep=1
    )
    freq_slider.on_changed(lambda i: update_ds(datasets[i], im))
    # Start the show
    plt.show()

def identify_air_areas(ds, thr=350):
    # Threshold all the air
    air_area = np.array(ds.pixel_array)
    air_area[air_area < thr] = 0
    air_area[air_area >= thr] = 1
    return air_area
    #y_max = len(ds.pixel_array)
    #x_max = len(ds.pixel_array[0])
    #for y in range(0, y_max):
    #    print(str(y) + " / " + str(y_max))
    #    for x in range(0, x_max):
    #        if ds.pixel_array[y][x] < thr: ds.pixel_array[y][x] = 0