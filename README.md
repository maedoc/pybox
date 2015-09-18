# pybox

This is another toolbox providing access to Python from MATLAB, with the
goals of building on MATLAB's new support for Python.

## conda

Miniconda from Continuum is used for setting up environments with prebuilt
packages, in cross platform fashion (or at least as much as conda is) 
especially onerous for scientific libraries.

For example

```matlab
>>> conda install py  % setup conda installation (dl if needed)
... 
>>> conda use py  % tell pybox where is conda installation
>>> conda create -n foo numpy   % make an environment with numpy
...
>>> py.numpy.random.rand(3)    % make array of random numbers

ans = 

  Python ndarray with properties:

           T: [1x1 py.numpy.ndarray]
        base: [1x1 py.NoneType]
      ctypes: [1x1 py.numpy.core._internal._ctypes]
        data: [1x24 py.buffer]
       dtype: [1x1 py.numpy.dtype]
       flags: [1x1 py.numpy.flagsobj]
        flat: [1x1 py.numpy.flatiter]
        imag: [1x1 py.numpy.ndarray]
    itemsize: 8
      nbytes: 24
        ndim: 1
        real: [1x1 py.numpy.ndarray]
       shape: [1x1 py.tuple]
        size: 3
     strides: [1x1 py.tuple]

    [ 0.32473666  0.59561982  0.77702851]

```