from Cython.Build import cythonize
from distutils.core import setup

setup(
	name='My_lib',
	ext_modules=cythonize('my_lib.pyx')
)
