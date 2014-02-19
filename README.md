sublimetext-cuda-cpp
====================

CUDA C++ package for Sublime Text 2 & 3

Syntax Highlighting
-------------------

Currently supports highlighting of all CUDA C/C++ syntax defined in Appendices [B][1] and [C][2] of the NVIDIA CUDA C Programming Guide (CUDA Toolkit v6.0).

Snippets
--------

 - Execution Configuration: `<<< + [TAB]` --> `<<<gridDim, blockDim, sharedBytes, streamId>>>()` with tab stops on each of the arguments.
 - `__syncthreads()`: `__s + [TAB]`
 - cudaMalloc: `cmal` --> `cudaMalloc((void**)&variable, bytes);`
 - cudaMallocManaged: `cmalmng` --> `cudaMallocManaged((void**)&variable, bytes);`
 - cudaMemcpy: `cmem` --> `cudaMemcpy(dest, src, bytes, cudaMemcpyHostToDevice);`
 - Kernel function prototype: `kernel` --> `__global__ void kernel()` with tab stops on the function name and inside the parentheses.
 - All existing snippets from the C++ package included with Sublime Text 2/3

Installation
------------

### Easy

[Install via Package Control](http://wbond.net/sublime_packages/package_control)

### Hard 

* At a git-enabled command prompt, cd to Sublime Text 2 packages directory:  
 * **OS X:** `~/Library/Application Support/Sublime Text 2/Packages/User`
	* **Windows:** `%APPDATA%\Sublime Text 2\Packages\User`
	* **Linux:** `~/.config/sublime-text-2/Packages/User`
* Install by cloning the repository to your Sublime Text 2 Packages directory:

    git clone git://github.com/harrism/sublimetext-cuda-cpp.git

Restart Sublime Text afterwards, switch to CUDA C++ as highlighting profile and try it out with one of the commands above.

Contributing
------------

If you want to contribute to this package, please make syntax changes in the cuda-c++.JSON-tmLanguage file, NOT in the cuda-c++.tmLanguage file. I use the AAAPackageDev package for Sublime text to make development easier, including converting JSON to plist (XML) format.


[1]: http://docs.nvidia.com/cuda-c-programming-guide/index.html#c-language-extensions
[2]: http://docs.nvidia.com/cuda-c-programming-guide/index.html#mathematical-functions-appendix