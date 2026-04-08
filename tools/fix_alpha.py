from PIL import Image
import os
import sys

RESOLUTION = 256

if len(sys.argv) != 2:
    print(f'Usage: python {os.path.basename(__file__)} <directory>')
    sys.exit(1)

directory = sys.argv[1]

if not os.path.isdir(directory):
    print(f'Error: "{directory}" is not a valid directory.')
    sys.exit(1)

for filename in os.listdir(directory):
    if not filename.lower().endswith('.png') or filename == 'fix_alpha.py':
        continue

    filepath = os.path.join(directory, filename)
    img = Image.open(filepath).convert('RGBA')
    r, g, b, a = img.split()

    # Set any pixel with alpha > 0 to fully opaque (255)
    a = a.point(lambda x: 255 if x > 0 else 0)

    img = Image.merge('RGBA', (r, g, b, a))
    img = img.resize((RESOLUTION, RESOLUTION), Image.LANCZOS)
    img.save(filepath)
    print(f'Processed: {filename}')

print('Done.')
