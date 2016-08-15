import sys
import ctypes
mex = ctypes.CDLL('libmex')

class mexOut(object):
    def write(self, s):
        mex.mexPrintf(s)
    def flush(self):
        mex.mexEvalString('drawnow;')

mex_out = mexOut()
if False:
    sys.stdout = sys.stderr = mexOut()
    print 'Python stdout/err -> mexPrintf enabled.'

import logging
logging.basicConfig(level=logging.DEBUG, stream=mex_out)
LOG = logging.getLogger('helpers')
LOG.info('ready')
from tvb.basic.profile import TvbProfile
TvbProfile.set_profile(TvbProfile.MATLAB_PROFILE)
