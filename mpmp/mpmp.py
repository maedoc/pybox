#

"""
MATLAB-Python Monkey Patches

"""

from __future__ import print_function
import sys
import ctypes


try:
    LIBMEX = ctypes.CDLL('mex') # Windows
    LIBMX = ctypes.CDLL('mx')
except:
    LIBMEX = ctypes.CDLL('libmex') # Linux/Mac
    LIBMX = ctypes.CDLL('libmx')


class MATLABOut(object):
    "Writable object which forwards strings to mexPrintf."

    def write(self, str):
        LIBMEX.mexPrintf(str)

    def flush(self):
        LIBMEX.mexEvalString('drawnow;')


def patch_std(out=True, err=True):
    if out:
        sys.stdout = MATLABOut()
    if err:
        sys.stderr = MATLABOut()


def test_out_and_flush():
    import time
    for i in range(5):
        print(i)
        sys.stdout.flush()
        time.sleep(1)