import numpy as np
import cv2
from skimage.measure import label, regionprops
from scipy.ndimage import generate_binary_structure, binary_dilation

def Vid_locoactivity(Vidname, separation):
    Vidpathname, Vname, ext = os.path.split(Vidname)
    vidObj = cv2.VideoCapture(os.path.join(Vidpathname, f"{Vname}{ext}"))
    numFrames = int(vidObj.get(cv2.CAP_PROP_FRAME_COUNT))
    FrameRate = vidObj.get(cv2.CAP_PROP_FPS)
    T = 0.6
    AreaEgg = 3

    LocoAVG = np.empty(len(separation))
    LocoSEM = np.empty(len(separation))

    for j, currentSep in enumerate(separation):
        CumulPixelDiff = []

        if currentSep == 1:
            Totalwormnums = 0
            totalwormpixels = 0

            for i in range(numFrames - currentSep):
                print(f"SEP = {currentSep}, Analyzing video {Vname}, frame {i + 1} out of {numFrames}")

                ret, previousImage = vidObj.read()
                vidObj.set(cv2.CAP_PROP_POS_FRAMES, i + currentSep)
                ret, currentImage = vidObj.read()
                vidObj.set(cv2.CAP_PROP_POS_FRAMES, i + 1)

                previousImage = cv2.cvtColor(previousImage, cv2.COLOR_BGR2GRAY) / 255
                currentImage = cv2.cvtColor(currentImage, cv2.COLOR_BGR2GRAY) / 255

                pixeldiff = np.sum(np.abs(currentImage - previousImage))
                totalwormpixels += np.sum(currentImage)
                BW = (currentImage > T).astype(np.uint8)
                CC = label(BW)
                stats = regionprops(CC)

                Sizes = np.array([stat.area for stat in stats])
                Worms = [stat for stat in stats if stat.area > AreaEgg * 5]
                Totalwormnums += len(Worms)

                CumulPixelDiff.append(pixeldiff)

            AvgWormNums = Totalwormnums / (numFrames - currentSep)
            PixelDiff_persec = np.array(CumulPixelDiff) * FrameRate
            AvgWormPixels = totalwormpixels / Totalwormnums

            LocoAVG[j] = np.mean(PixelDiff_persec)
            LocoSEM[j] = np.std(PixelDiff_persec) / np.sqrt(len(PixelDiff_persec))

        else:
            for i in range(numFrames - currentSep):
                print(f"SEP = {currentSep}, Analyzing video {Vname}, frame {i + 1} out of {numFrames}")

                ret, previousImage = vidObj.read()
                vidObj.set(cv2.CAP_PROP_POS_FRAMES, i + currentSep)
                ret, currentImage = vidObj.read()
                vidObj.set(cv2.CAP_PROP_POS_FRAMES, i + 1)

                previousImage = cv2.cvtColor(previousImage, cv2.COLOR_BGR2GRAY) / 255
                currentImage = cv2.cvtColor(currentImage, cv2.COLOR_BGR2GRAY) / 255

                pixeldiff = np.sum(np.abs(currentImage - previousImage))
                CumulPixelDiff.append(pixeldiff)

            PixelDiff_persec = np.array(CumulPixelDiff) * FrameRate
            LocoAVG[j] = np.mean(PixelDiff_persec)
            LocoSEM[j] = np.std(PixelDiff_persec) / np.sqrt(len(PixelDiff_persec))

    return LocoAVG, LocoSEM, AvgWormNums, AvgWormPixels


