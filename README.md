Image analysis software for multimetric behavioral analysis of the nematode Caenorhabditis elegans housed in 96-well plates.

"HJ_MultWell_Analysis.m": The main function for image analysis.  It generates behavioral outputs including activity, locomotor frequency, and embryo number.

Directory "image calculation functions": Directory that contains all functions/subfunctions for image calculation, called by the main function "HJ_MultWell_Analysis.m".  In this folder, "RCNN" contains all python scripts that use regional convolutional neural network (RCNN) for counting embryos in the image, this module is called by the main function "HJ_MultWell_Analysis.m".

Directory "data management and visualization": Directory that contains all scripts for data management and visualization.

Directory "Sample data" contains sample image data of C. elegans behavior in a 96-well plate.


Detailed instruction for "HJ_MultWell_Analysis.m":

When running the main function, all the results will be stored in the "_Result_DATA" file. 

The file stores an MxN struct variable called "S".
In each entry of S, there are 13 fields:

Vidname: the corresponding video name under analysis

FrameRate: framerate of the video, also the framerate used for computing the image-difference-based activity (ActVal, the 4th field)

FrameSkip: the frames that are skipped for computing ActValS, the 5th field. ActValS is similar to ActVal, but based on a larger time step defined by FrameSkip

ActVal: image-difference-based activity, computed via adjacent frames

ActValS: image-difference-based activity, computed via every two frames N timesteps apart (N = FrameSkip)

Freq: mean frequency of a worm within the duration of the video

Freq_L: frequency value of the 75th percentile of the frequency dynamics during the video

Freq_U: frequency value of the 25th percentile of the frequency dynamics during the video

Fullseq: an intermediate vector data used for computing frequency (unrelated to future analysis)

Periodicity: the index indicating the extent to which a worm is performing rhythmic locomotion. If it is <=0.3, the worm is regarded as not doing rhythmic locomotion and the corresponding Freq should be set to NaN.

EggArea: the total area of eggs per well

EggMaskNum: the total number of egg masks per well

data: recording data of the video

Some comments regarding the above parameters:

Each entry of T denotes the behavioral info of the respective recording time point. For example, if you record videos every 2 minutes, then T(1) is for t = 0 min, T(2) is for t = 2 min, and T(4) is for t = 6 min.
In each entry of T, each behavioral parameter is of an 8x12 format, which is exactly matched with the layout of the 96 wells in the plate, provided that your plate is in the normal orientation in the video.
You can either use EggMaskNum or EggArea to deduce the egg number in each well.  

EggMaskNum denotes the number of eggs, which is straightford, but I found using EggArea to infer egg number is slightly more accurate especially when many eggs are laid.  To use EggArea, you need to manually annotate the egg numbers from all of the 96 wells in 2~3 images and make a correlation with the corresponding EggArea to get the "slope" or the average egg area.  This step is done by using the script "multiwell code/data management and visualization/HJ_Eggcounting_RCNN_vs_GT.m".
