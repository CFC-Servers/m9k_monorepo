"""Convert every PNG in a directory to a crisp VTF (same name, next to the PNG).

Writes VTF 7.2 with no mipmaps and NOMIP|NOLOD flags, so thin details
(like 1px outlines) are not blurred by lower mip levels in-game.

Formats:
  dxt5 (default)  ~1 byte/pixel, high quality cluster-fit compression (needs ImageMagick `magick`)
  bgra8888        4 bytes/pixel, lossless

Requires: pillow, numpy, ImageMagick 7 (for dxt5)
Usage:    python png_to_vtf.py <directory> [dxt5|bgra8888]
"""
import os
import struct
import subprocess
import sys
import tempfile

import numpy as np
from PIL import Image

FLAG_NOMIP = 0x0100
FLAG_NOLOD = 0x0200
FLAG_EIGHTBITALPHA = 0x2000
FLAGS = FLAG_NOMIP | FLAG_NOLOD | FLAG_EIGHTBITALPHA

FORMAT_BGRA8888 = 12
FORMAT_DXT5 = 15
FORMAT_NONE = 0xFFFFFFFF


def encode_dxt5(png_path, w, h):
    with tempfile.TemporaryDirectory() as tmp:
        dds = os.path.join(tmp, 'out.dds')
        subprocess.run([
            'magick', png_path,
            '-define', 'dds:compression=dxt5',
            '-define', 'dds:mipmaps=0',
            '-define', 'dds:cluster-fit=true',
            '-define', 'dds:weight-by-alpha=true',
            dds,
        ], check=True)
        with open(dds, 'rb') as f:
            data = f.read()
    size = max(1, (w + 3) // 4) * max(1, (h + 3) // 4) * 16
    return data[128:128 + size]  # skip DDS header, top mip only


def convert(png_path, vtf_path, fmt):
    img = Image.open(png_path).convert('RGBA')
    w, h = img.size
    rgba = np.asarray(img)

    # Reflectivity = average linear color of visible pixels
    vis = rgba[rgba[..., 3] > 0][:, :3] / 255.0
    refl = (vis ** 2.2).mean(axis=0) if len(vis) else np.zeros(3)

    header = struct.pack(
        '<4s2IIHHIHH4s3f4sfIBIBBH',
        b'VTF\0', 7, 2, 80,
        w, h, FLAGS,
        1, 0, b'\0' * 4,
        *refl, b'\0' * 4,
        1.0, FORMAT_DXT5 if fmt == 'dxt5' else FORMAT_BGRA8888, 1,
        FORMAT_NONE, 0, 0,
        1,
    )
    header = header.ljust(80, b'\0')

    if fmt == 'dxt5':
        data = encode_dxt5(png_path, w, h)
    else:
        data = rgba[..., [2, 1, 0, 3]].tobytes()
    with open(vtf_path, 'wb') as f:
        f.write(header)
        f.write(data)


if len(sys.argv) not in (2, 3) or (len(sys.argv) == 3 and sys.argv[2] not in ('dxt5', 'bgra8888')):
    print(f'Usage: python {os.path.basename(__file__)} <directory> [dxt5|bgra8888]')
    sys.exit(1)

directory = sys.argv[1]
fmt = sys.argv[2] if len(sys.argv) == 3 else 'dxt5'
if not os.path.isdir(directory):
    print(f'Error: "{directory}" is not a valid directory.')
    sys.exit(1)

for filename in sorted(os.listdir(directory)):
    if not filename.lower().endswith('.png'):
        continue
    base = os.path.splitext(filename)[0]
    convert(os.path.join(directory, filename), os.path.join(directory, base + '.vtf'), fmt)
    print(f'Converted: {filename} -> {base}.vtf')

print('Done.')
