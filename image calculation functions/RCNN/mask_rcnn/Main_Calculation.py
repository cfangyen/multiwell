import os
import cv2
import scipy.io
import numpy as np
from glob import glob
from pathlib import Path
from scipy.io import savemat, loadmat
import matplotlib.pyplot as plt
from skimage import io
from skimage.measure import label, regionprops
from skimage.morphology import remove_small_objects
from skimage.color import rgb2gray
from matplotlib.patches import Circle
import sys
import tkinter as tk
from tkinter import Tk, simpledialog
from concurrent.futures import ProcessPoolExecutor

import re
import Vid_BkgSubtraction_Output
import Vid_locoactivity
import Tutorial_Mask_R_CNN_PyTorchOfficial

def natural_key(string_):
    """Helper function to sort strings containing numbers in a natural order."""
    return [int(s) if s.isdigit() else s for s in re.split(r'(\d+)', string_)]

def search_files(directory, target_string):
    matching_files = []

    for filename in os.listdir(directory):
        if target_string in filename:
            matching_files.append(filename)

    return matching_files

def run_main():
    p = r"C:\Users\fffei\Dropbox\Paper\Egg-laying\Data\2023-3-18 2hr 2min 15sec 20fps 6 well dop3"
    parentfolder = p

    Dir_orgvid = glob(os.path.join(parentfolder, 'original', '*.avi'))
    Dir_orgvid = sorted(Dir_orgvid, key=lambda x: natural_key(os.path.basename(x)))
    wellimgdir = os.path.join(parentfolder, 'wellimg')
    wellviddir = os.path.join(parentfolder, 'wellvid')
    os.makedirs(wellimgdir, exist_ok=True)
    os.makedirs(wellviddir, exist_ok=True)

    # Create and hide root window
    root = tk.Tk()
    root.withdraw()

    prompt = "How many wells"
    dlgtitle = "Number of wells"
    WellNum = simpledialog.askstring(dlgtitle, prompt)
    numwells = int(WellNum)
    numvids = len(Dir_orgvid)
    separation = list(range(1, 21))

    for ii in range(numvids):
        fname = os.path.basename(Dir_orgvid[ii])
        orgvidfolder = os.path.dirname(Dir_orgvid[ii])
        Vid_BkgSubtraction_Output.Vid_BkgSubtraction_Output(fname, orgvidfolder, wellimgdir, wellviddir, 'd', numwells)
    # Destroy the root window after use
    root.destroy()

    mfolder_path = '/Users/hongfei/Library/CloudStorage/Dropbox-Personal/Paper/Egg-laying/Data/2023-3-18 2hr 2min 15sec 20fps 6 well dop3/wellimg'
    Tutorial_Mask_R_CNN_PyTorchOfficial.run_main(mfolder_path)
    print('Finished')

    import scipy.io
    from collections import defaultdict
    from statistics import mean, stdev

    Dir_orgvid = glob(os.path.join(parentfolder, 'wellimg', 'Well*'))
    LocoAVG_data = [None] * numwells
    LocoSEM_data = [None] * numwells
    AvgWormNums = [None] * numwells
    AvgPxlperWorm = [None] * numwells

    def process_well(i):
        current_vid_path = os.path.join(parentfolder, 'wellvid', f'Well {i + 1:02d}')
        vids_dir = glob(os.path.join(current_vid_path, '*.avi'))
        num_vids = len(vids_dir)

        current_well_LocoAVG = np.zeros((num_vids, len(separation)))
        current_well_LocoSEM = np.zeros((num_vids, len(separation)))
        current_well_WormNums = np.zeros(num_vids)
        current_PxlperWorm = np.zeros(num_vids)

        for j in range(num_vids):
            vid_name = os.path.join(current_vid_path, vids_dir[j])
            current_well_LocoAVG[j, :], current_well_LocoSEM[j, :], current_well_WormNums[j], current_PxlperWorm[j] = Vid_locoactivity(vid_name, separation)

        return i, current_well_LocoAVG, current_well_LocoSEM, current_well_WormNums, current_PxlperWorm

    with ProcessPoolExecutor(max_workers=8) as executor:
        for i, current_well_LocoAVG, current_well_LocoSEM, current_well_WormNums, current_PxlperWorm in executor.map(process_well, range(numwells)):
            LocoAVG_data[i] = current_well_LocoAVG
            LocoSEM_data[i] = current_well_LocoSEM
            AvgWormNums[i] = current_well_WormNums
            AvgPxlperWorm[i] = current_PxlperWorm

    # Save data for locomotion dynamics from pixel difference
    scipy.io.savemat(os.path.join(parentfolder, 'LocoEgg_data.mat'), {'LocoAVG_data': LocoAVG_data, 'LocoSEM_data': LocoSEM_data, 'AvgWormNums': AvgWormNums, 'AvgPxlperWorm': AvgPxlperWorm})

    # Get a list of directories with 'Well*' pattern in wellimgdir
    Dir_wellimg = [d for d in os.listdir(wellimgdir) if os.path.isdir(os.path.join(wellimgdir, d)) and d.startswith('Well')]

    EggAVG_data = [None] * numwells
    EggSEM_data = [None] * numwells

    for i in range(numwells):
        print(f"Analyzing Well {i+1} out of {numwells}")
        current_img_path = os.path.join(wellimgdir, Dir_wellimg[i])

        # Load TOTAL_MASKNUMS.mat data
        TOTAL_MASKNUMS_data = scipy.io.loadmat(os.path.join(current_img_path, 'TOTAL_MASKNUMS.mat'))
        TOTAL_MASKNUMS = TOTAL_MASKNUMS_data['TOTAL_MASKNUMS']

        num_imgs = len(TOTAL_MASKNUMS)
        current_well_EggAVG = np.zeros(numvids)
        current_well_EggSEM = np.zeros(numvids)
        num_images_done = 0

        for j in range(numvids):
            currentVidImgsdir = [f for f in os.listdir(current_img_path) if f.startswith(f'fps{j+1:04}')]

            num_images_inqueue = len(currentVidImgsdir)
            current_well_EggAVG[j] = np.mean(TOTAL_MASKNUMS[num_images_done:num_images_done + num_images_inqueue])
            current_well_EggSEM[j] = np.std(TOTAL_MASKNUMS[num_images_done:num_images_done + num_images_inqueue]) / np.sqrt(num_images_inqueue)
            num_images_done += num_images_inqueue

        EggAVG_data[i] = current_well_EggAVG
        EggSEM_data[i] = current_well_EggSEM

    # Save data
    scipy.io.savemat(os.path.join(parentfolder, 'LocoEgg_data.mat'), {'EggAVG_data': EggAVG_data, 'EggSEM_data': EggSEM_data}, appendmat=True)

    # Load LocoEgg_data.mat
    LocoEgg_data = scipy.io.loadmat(os.path.join(parentfolder, 'LocoEgg_data.mat'))
    LocoAVG_data = LocoEgg_data['LocoAVG_data']
    LocoSEM_data = LocoEgg_data['LocoSEM_data']
    AvgWormNums = LocoEgg_data['AvgWormNums']
    AvgPxlperWorm = LocoEgg_data['AvgPxlperWorm']

    # Analyze egg-laying activity
    # ... (load or compute the required data)

    # Plot egg-laying activity
    plt.figure()
    for i in range(numwells):
        current_Well_EggAVG = EggAVG_data[i]
        current_Well_EggSEM = EggSEM_data[i]
        current_well_WormNums = AvgWormNums[i]
        current_Well_EggAVG_perworm = current_Well_EggAVG / np.mean(current_well_WormNums)
        current_Well_EggSEM_perworm = current_Well_EggSEM / np.sqrt(np.mean(current_well_WormNums))
        num_vids = len(current_Well_EggAVG)
        T = np.arange(num_vids) * Interval
        plt.errorbar(T, current_Well_EggAVG_perworm, current_Well_EggSEM_perworm, linewidth=2)

    plt.xlabel('Time (min)')
    plt.ylabel('# of eggs')
    plt.gca().set_fontsize(18)
    plt.show()

    # Plot locomotion activity
    plt.figure()
    for i in range(numwells):
        # ... (load or compute the required data)

        # Perform linear interpolation to fill missing values in x and err
        x_interp = np.interp(T, T_no_nan, x_no_nan)
        err_interp = np.interp(T, T_no_nan, err_no_nan)
        plt.errorbar(T, x_interp, err_interp, linewidth=2)

    plt.xlabel('Time (min)')
    plt.ylabel('Loco Activity')
    plt.gca().set_fontsize(18)
    plt.show()

    # Plot worm number per well
    plt.figure()
    for i in range(numwells):
        current_well_WormNums = AvgWormNums[i]
        num_vids = len(current_well_WormNums)
        T = np.arange(num_vids) * Interval
        plt.plot(T, current_well_WormNums, linewidth=2)

    plt.xlabel('Time (min)')
    plt.ylabel('# of worms')
    plt.gca().set_fontsize(18)
    plt.show()


if __name__ == "__main__":
    run_main()