# Replacing Filename characters with python
#   https://stackoverflow.com/a/7161453/8328786

import os

folder='.'
pathiter = (os.path.join(root, filename)
    for root, _, filenames in os.walk(folder)
    for filename in filenames
)
for path in pathiter:
    newname =  path.replace('-en-', '-zh-')
    if newname != path:
        os.rename(path,newname)