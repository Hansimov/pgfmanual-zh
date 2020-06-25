import os

aux_L = [".aux", ".fdb_latexmk", ".fls", ".idx", ".ilg", ".ind", ".log", ".out", ".toc", ".xdv"]

for root, dirs, fnames in os.walk("."):
    for fname in fnames:
        name, ext = os.path.splitext(fname)
        if ext in aux_L:
            os.remove(os.path.join(root,fname))