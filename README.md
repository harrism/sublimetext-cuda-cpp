sublimetext-cuda-cpp
====================

CUDA C++ package for Sublime Text 4. Sublime Text 3 is no longer supported; ST3 users can stay on release 1.0.2.

Syntax Highlighting
-------------------

Highlights the CUDA C++ language extensions from the NVIDIA CUDA C++ Programming Guide ([C++ language extensions][1] and [intrinsic functions][2]): function and variable qualifiers, `__launch_bounds__`, built-in vector types and variables, intrinsics, and `<<<...>>>` kernel launches. The keyword lists date from CUDA Toolkit v6.0.

The package contains two syntax definitions:

 - `cuda-c++.sublime-syntax` is used by Sublime Text 4. It extends the built-in C++ syntax, so CUDA keywords are highlighted inside function bodies and kernels still appear in Goto Symbol. Standard C functions that CUDA also supports in device code (`printf`, `malloc`, `free`, `memcpy`, `memset`, `assert`, `clock`) are left to the C++ syntax. `syntax_test_cuda.cu` holds its syntax tests.
 - `cuda-c++.tmLanguage` is used by [GitHub Linguist](https://github.com/github-linguist/linguist) to highlight CUDA on GitHub. Sublime Text 4 ignores it in favour of the `.sublime-syntax` file of the same name.

Snippets
--------

 - Execution Configuration: `<<< + [TAB]` --> `<<<gridDim, blockDim, sharedBytes, streamId>>>()` with tab stops on each of the arguments.
 - `__syncthreads()`: `__s + [TAB]`
 - cudaMalloc: `cmal` --> `cudaMalloc((void**)&variable, bytes);`
 - cudaMallocManaged: `cmalmng` --> `cudaMallocManaged((void**)&variable, bytes);`
 - cudaMemcpy: `cmem` --> `cudaMemcpy(dest, src, bytes, cudaMemcpyHostToDevice);`
 - Kernel function prototype: `kernel` --> `__global__ void kernel()` with tab stops on the function name and inside the parentheses.
 - Copies of the C/C++ snippets that ship with Sublime Text, so they also work in CUDA files

Installation
------------

### Easy

[Install via Package Control](http://wbond.net/sublime_packages/package_control)

### Hard 

* At a git-enabled command prompt, cd to the Sublime Text `Packages` directory (`Preferences > Browse Packages...` opens it):
	* **macOS:** `~/Library/Application Support/Sublime Text/Packages`
	* **Windows:** `%APPDATA%\Sublime Text\Packages`
	* **Linux:** `~/.config/sublime-text/Packages`
* Clone the repository into a directory named `CUDA C++` (the name Package Control uses, which the syntax tests expect):

    git clone https://github.com/harrism/sublimetext-cuda-cpp.git "CUDA C++"

Restart Sublime Text afterwards, switch to CUDA C++ as highlighting profile and try it out with one of the commands above.

Contributing
------------

If you want to contribute to this package, please make syntax changes in both cuda-c++.sublime-syntax and cuda-c++.JSON-tmLanguage, NOT directly in the cuda-c++.tmLanguage file. Run the syntax tests in Sublime Text 4 with the `Build With: Syntax Tests` command while `syntax_test_cuda.cu` is open. I use the AAAPackageDev package for Sublime text to make development easier, including converting JSON to plist (XML) format.


[1]: http://docs.nvidia.com/cuda-c-programming-guide/index.html#c-language-extensions
[2]: http://docs.nvidia.com/cuda-c-programming-guide/index.html#mathematical-functions-appendix