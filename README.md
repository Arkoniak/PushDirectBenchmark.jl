# PushDirectBenchmark

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Arkoniak.github.io/PushDirectBenchmark.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Arkoniak.github.io/PushDirectBenchmark.jl/dev)
[![Build Status](https://travis-ci.com/Arkoniak/PushDirectBenchmark.jl.svg?branch=master)](https://travis-ci.com/Arkoniak/PushDirectBenchmark.jl)
[![Coveralls](https://coveralls.io/repos/github/Arkoniak/PushDirectBenchmark.jl/badge.svg?branch=master)](https://coveralls.io/github/Arkoniak/PushDirectBenchmark.jl?branch=master)

This is small benchmark package, which compares performance of different versions of array creation depending on the array size.

## Installation and usage

Package installation
```julia
julia> ] dev https://github.com/Arkoniak/PushDirectBenchmark.jl.git
```
Usage
```julia
using PushDirectBenchmark; plot_benchmarks()
```
will create files in `image` folder with Julia version info and benchmark plots. Include this plots in this README file in the same manner as it's done below.

Created files have form `<datetime>_<hostname>_<picturename>.png`, first two prefixes can be changed with the `name` argument
```julia
plot_benchmarks(name = "myname")
```
creates files in the form `myname_<picturename>.png`,
```julia
plot_benchmarks(name = name_helper("myname"))
```
creates files in the form `<datetime>_myname_<picturename>.png`. For consistency with
other results please use latter version.

## Benchmarks

### Arkoniak ubuntu vm

```julia
Julia Version 1.3.1
Commit 2d5741174c (2019-12-30 21:36 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-6.0.1 (ORCJIT, skylake)
Environment:
  JULIA_EDITOR = atom  -a
  JULIA_NUM_THREADS = 1
```

Performance
![arkoniak_ubuntu_vm_comparison](images/20200205T134146arkoniak_ubuntu_vm_push_direct_comparison.png)

Performance relative to minimum benchmark time
![arkoniak_ubuntu_vm_comparison_rel_min](images/20200205T134146arkoniak_ubuntu_vm_push_direct_comparison_rel_min.png)

Performance relative to maximum benchmark time
![arkoniak_ubuntu_vm_comparison_rel_max](images/20200205T134146arkoniak_ubuntu_vm_push_direct_comparison_rel_max.png)

### Arkoniak home laptop

```julia
Julia Version 1.3.0
Commit 46ce4d7933 (2019-11-26 06:09 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-6.0.1 (ORCJIT, skylake)
```

Performance
![arkoniak_home_laptop_comparison](images/20200212T211955_h1_push_direct_comparison.png)

Performance relative to minimum benchmark time
![arkoniak_home_laptop_comparison_rel_min](images/20200212T211955_h1_push_direct_comparison_rel_min.png)

Performance relative to maximum benchmark time
![arkoniak_home_laptop_comparison_rel_max](images/20200212T211955_h1_push_direct_comparison_rel_max.png)
