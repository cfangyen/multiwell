import os
import cv2
import imageio
import numpy as np
import matplotlib.pyplot as plt
from scipy import ndimage
from skimage import measure
from skimage.filters import threshold_otsu
from skimage.morphology import square
from skimage.draw import ellipse
from matplotlib.patches import Circle


# Global variables to store the circle and dragging state
current_circle = None
roi = []
dragging = False


# Mouse button press event handler
def on_press(event):
    global current_circle, dragging
    if current_circle is not None:
        dx = event.xdata - current_circle.center[0]
        dy = event.ydata - current_circle.center[1]
        if dx ** 2 + dy ** 2 < current_circle.radius ** 2:
            dragging = True
            return

    center = (event.xdata, event.ydata)
    current_circle = Circle(center, 0, edgecolor='r', facecolor='none', linewidth=2)
    plt.gca().add_patch(current_circle)


# Mouse button release event handler
def on_release(event):
    global dragging
    if dragging:
        dragging = False
        return

    if current_circle is not None:
        current_circle.set_radius(((event.xdata - current_circle.center[0]) ** 2 + (event.ydata - current_circle.center[1]) ** 2) ** 0.5)
        plt.draw()


# Mouse motion event handler
def on_motion(event):
    global current_circle, dragging
    if dragging and current_circle is not None:
        current_circle.set_center((event.xdata, event.ydata))
        plt.draw()


num_circles_drawn = 0
drawn_circles = []


# Double-click event handler
def on_double_click(event, numwells):
    global roi, current_circle, dragging, num_circles_drawn, drawn_circles
    if event.dblclick and current_circle is not None:
        if not dragging:
            drawn_circles.append((current_circle.center, current_circle.radius))
            current_circle = None
            num_circles_drawn += 1
            if num_circles_drawn >= numwells:
                disconnect_events()
                plt.close()
                roi = drawn_circles


def Vid_BkgSubtraction_Output(filename, orgviddir, wellimgdir, wellviddir, fieldmode, numwells):
    global num_circles_drawn, drawn_circles
    parent_folder = os.path.dirname(orgviddir)
    vidname, _ = os.path.splitext(filename)
    vid_obj = cv2.VideoCapture(os.path.join(orgviddir, filename))
    num_frames = int(vid_obj.get(cv2.CAP_PROP_FRAME_COUNT))
    fps = vid_obj.get(cv2.CAP_PROP_FPS)
    ret, frame_sample = vid_obj.read()
    frame_sample = cv2.cvtColor(frame_sample, cv2.COLOR_BGR2GRAY)
    num_row, num_col = frame_sample.shape

    # Display the frame sample
    plt.figure(figsize=(7, 5))
    plt.imshow(frame_sample, cmap="gray")
    plt.axis("on")
    plt.gca().set_title(f"Indicate {numwells} wells")
    # Draw ROIs for wells
    k = 0
    # Identify wells
    print(f"Indicate {numwells} wells")
    maskfile = os.path.join(parent_folder, f'masks{numwells}.npz')
    if not os.path.exists(maskfile):
        roi = []
        drawn_circles = []  # Reset drawn_circles
        num_circles_drawn = 0  # Reset num_circles_drawn

        cid1 = plt.gcf().canvas.mpl_connect("button_press_event", on_press)
        cid2 = plt.gcf().canvas.mpl_connect("button_release_event", on_release)
        cid3 = plt.gcf().canvas.mpl_connect("motion_notify_event", on_motion)
        cid4 = plt.gcf().canvas.mpl_connect("button_press_event", lambda event: on_double_click(event, numwells))

        # Define disconnect_events function here to access the cid variables
        def disconnect_events():
            plt.gcf().canvas.mpl_disconnect(cid1)
            plt.gcf().canvas.mpl_disconnect(cid2)
            plt.gcf().canvas.mpl_disconnect(cid3)
            plt.gcf().canvas.mpl_disconnect(cid4)

        plt.show()

        for kk in range(numwells):
            savepathname_vid = os.path.join(wellviddir, f"Well{kk}")
            savepathname_img = os.path.join(wellimgdir, f"Well{kk}")
            os.makedirs(savepathname_vid, exist_ok=True)
            os.makedirs(savepathname_img, exist_ok=True)

        np.savez(maskfile, roi=roi)
        roi = np.load(maskfile)["roi"]
    else:
        for kk in range(numwells):
            savepathname_vid = os.path.join(wellviddir, f"Well{kk}")
            savepathname_img = os.path.join(wellimgdir, f"Well{kk}")
            os.makedirs(savepathname_vid, exist_ok=True)
            os.makedirs(savepathname_img, exist_ok=True)

        roi = np.load(maskfile)["roi"]
    plt.close()

    # Extract well images from videos
    print("Extract well images from videos")
    background = np.zeros_like(frame_sample, dtype=np.float64)
    while k <= num_frames-1:
        ret, current_frame = vid_obj.read()
        if not ret:
            break
        current_frame = cv2.cvtColor(current_frame, cv2.COLOR_BGR2GRAY)

        if (k+1) % fps == 0:
            for ii in range(1, numwells+1):
                rr, cc = ellipse(roi[ii-1][1], roi[ii-1][0], roi[ii-1][2], roi[ii-1][3], frame_sample.shape)
                mask = np.zeros_like(frame_sample, dtype=bool)
                mask[rr, cc] = True
                masked_image = current_frame.copy()
                masked_image[~mask] = 0
                imgname = os.path.join(wellimgdir, f"Well{ii}", f"{vidname}_frame{k}.png")
                imageio.imwrite(imgname, masked_image)

        current_frame = current_frame.astype(np.float64)
        if k == 0:
            background = current_frame
        else:
            if fieldmode == 'd':  # if dark-field
                background = np.minimum(background, current_frame)
            elif fieldmode == 'b':  # if bright-field
                background = np.maximum(background, current_frame)
        k += 1

    print("Finished")
    # Add a pause(2) equivalent here if needed

    # Generate worm-only videos
    background = background.astype(np.uint8)
    t = threshold_otsu(background)
    area_egg = 4
    print("Generate worm-only videos")

    for kk in range(1, numwells+1):
        i = 1
        vid_obj.set(cv2.CAP_PROP_POS_FRAMES, 0)
        video_worm = cv2.VideoWriter(os.path.join(wellviddir, f"Well{kk}", f"{vidname}_Well{kk}.avi"),
                                     cv2.VideoWriter_fourcc(*'XVID'), fps, (num_col, num_row), isColor=False)
        while True:
            ret, current_image = vid_obj.read()
            if not ret:
                break
            current_image = cv2.cvtColor(current_image, cv2.COLOR_BGR2GRAY) - background
            rr, cc = ellipse(roi[kk - 1][1], roi[kk - 1][0], roi[kk - 1][2], roi[kk - 1][3], current_image.shape)
            mask = np.zeros_like(current_image, dtype=bool)
            mask[rr, cc] = True
            props = measure.regionprops_table(mask.astype(np.uint8), properties=['bbox'])
            current_image = current_image[props['bbox-0']:props['bbox-2'], props['bbox-1']:props['bbox-3']]

            blank = np.zeros_like(current_image)
            bw = current_image > t
            cc = measure.label(bw)
            stats = measure.regionprops_table(cc, properties=['area', 'coords'])
            sizes = stats['area']
            worms = np.where(sizes > area_egg * 10)[0]

            mask_image = np.zeros_like(current_image)
            for j in worms:
                worm_pxls = stats['coords'][j]
                worm_bw = np.zeros_like(blank, dtype=bool)
                worm_bw[worm_pxls[:, 0], worm_pxls[:, 1]] = True
                se = square(2)
                worm_bw_d = ndimage.binary_dilation(worm_bw, structure=se)
                mask_image[worm_bw_d] = 1

            video_worm.write(mask_image.astype(np.uint8))
            print(f'Video {vidname}, Well {kk}, Frame {i}')
            i += 1

        video_worm.release()

    print("Finished")

