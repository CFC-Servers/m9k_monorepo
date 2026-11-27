"""Add an anti-aliased white outline around the contents of every PNG in a directory.

Requires: pillow, numpy, scipy
Usage:    python add_outline.py <directory> [thickness_px]
"""
import os
import sys

import numpy as np
from PIL import Image
from scipy import ndimage

SUPERSAMPLE = 8      # supersample factor used for anti-aliasing
COLOR = (1.0, 1.0, 1.0)  # outline color (white)


def process(filepath, thickness):
    img = Image.open(filepath).convert('RGBA')
    w, h = img.size
    src = np.asarray(img).astype(np.float64) / 255.0

    # Supersample alpha smoothly and threshold to a clean shape
    big = img.getchannel('A').resize((w * SUPERSAMPLE, h * SUPERSAMPLE), Image.BICUBIC)
    shape = np.asarray(big) >= 128

    # Euclidean distance from the shape (in supersampled pixels),
    # turned into coverage, then box-downsampled => anti-aliased outline alpha
    dist = ndimage.distance_transform_edt(~shape)
    cov = np.clip(thickness * SUPERSAMPLE + 0.5 - dist, 0.0, 1.0)
    cov = cov.reshape(h, SUPERSAMPLE, w, SUPERSAMPLE).mean(axis=(1, 3))

    # Composite original over the outline layer
    sa = src[..., 3:4]
    oa = cov[..., None]
    out_a = sa + oa * (1 - sa)
    out_rgb = (src[..., :3] * sa + np.array(COLOR) * oa * (1 - sa)) / np.maximum(out_a, 1e-8)
    out = np.concatenate([out_rgb, out_a], axis=2)

    Image.fromarray(np.round(out * 255).astype(np.uint8), 'RGBA').save(filepath, optimize=True)


if len(sys.argv) not in (2, 3):
    print(f'Usage: python {os.path.basename(__file__)} <directory> [thickness_px]')
    sys.exit(1)

directory = sys.argv[1]
thickness = float(sys.argv[2]) if len(sys.argv) == 3 else 1.0

if not os.path.isdir(directory):
    print(f'Error: "{directory}" is not a valid directory.')
    sys.exit(1)

for filename in sorted(os.listdir(directory)):
    if not filename.lower().endswith('.png'):
        continue
    process(os.path.join(directory, filename), thickness)
    print(f'Processed: {filename}')

print('Done.')
