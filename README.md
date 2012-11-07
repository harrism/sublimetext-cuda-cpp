sublimetext-cuda-cpp
====================

CUDA C++ package for Sublime Text 2

Syntax Highlighting
-------------------

Currently supports highlighting of all CUDA C/C++ syntax defined in Appendices [B][1] and [C][2] of the NVIDIA CUDA C Programming Guide.

Snippets
--------

 - Execution Configuration: `<<< + [TAB]` --> `<<<gridDim, blockDim, sharedBytes, streamId>>>()` with tab stops on each of the arguments.
 - `__syncthreads()`: `__s + [TAB]`
 - cudaMalloc: `cmal` --> `cudaMalloc((void**)&variable, bytes);`
 - cudaMemcpy: `cmem` --> `cudaMemcpy(dest, src, bytes, cudaMemcpyHostToDevice);`
 - All existing snippets from the C++ package included with Sublime Text 2

Installation
------------
Install by cloning the repository to your Sublime Text 2 Packages directory:

    cd <package directory>
    git clone git://github.com/harrism/sublimetext-cuda-cpp.git

Restart Sublime Text afterwards, switch to CUDA C++ as highlighting profile and try it out with one of the commands above.

I am working on adding this package to Will Bond's excellent Package Control extension to make installation trivial.


Contributing
------------

If you want to contribute to this package, please make syntax changes in the cuda-c++.JSON-tmLanguage file, NOT in the cuda-c++.tmLanguage file. I use the AAAPackageDev package for Sublime text to make development easier, including converting JSON to plist (XML) format.


[1]: http://docs.nvidia.com/cuda-c-programming-guide/index.html#c-language-extensions
[2]: http://docs.nvidia.com/cuda-c-programming-guide/index.html#mathematical-functions-appendix