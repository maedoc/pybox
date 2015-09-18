# pybox

This is another toolbox providing access to Python from MATLAB, with the
goals of building on MATLAB's new support for Python.

Miniconda from Continuum is used for setting up environments with prebuilt
packages, in cross platform fashion (or at least as much as conda is) 
especially onerous for scientific libraries.

For example

```matlab
>>> pybox install_conda  % setup conda installation (dl if needed)
... 
>>> pybox install numpy pyqt % install some packages
... 
>>> pybox use               % tell MATLAB to use our python install
>>> py.sys.executable

ans = 

  Python str with no properties.

    /home/duke/MATLAB/pybox/conda/bin/python

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

MATLAB automatically exposes most stuff on Python objects in the console
and the variable inspector, but it's useful to have the results as a MATLAB
array:

```matlab
>>> np2m(py.numpy.arange(8).reshape(2, 4))

ans =

     0     4
     1     5
     2     6
     3     7
```

Shapes are handled correctly.

Usuability is not bad, see how MATLAB even can make intelligent corrections
(here I misspelled `QApplication`)

![pyqtshot](pyqtshot.png)