// SYNTAX TEST "Packages/CUDA C++/cuda-c++.sublime-syntax"

#include <cstdio>
// <- meta.preprocessor.include

__constant__ float4 coeffs[4];
// <- storage.modifier.cuda-c++
//           ^^^^^^ support.type.cuda-c++

__device__ __managed__ int counter;
// <- storage.modifier.cuda-c++
//         ^^^^^^^^^^^ storage.modifier.cuda-c++

float4 make_vector() { return {}; }
// <- support.type.cuda-c++
//     ^^^^^^^^^^^ meta.function.c++ entity.name.function.c++

__host__ __device__ inline int square(int x) { return x * x; }
// <- storage.modifier.cuda-c++
//       ^^^^^^^^^^ storage.modifier.cuda-c++
//                             ^^^^^^ entity.name.function.c++

__global__ void __launch_bounds__(256, 2) scale(float* __restrict__ a, int n)
// <- storage.modifier.cuda-c++
//         ^^^^ storage.type
//              ^^^^^^^^^^^^^^^^^ storage.modifier.cuda-c++
//                               ^^^^^^^^ meta.group.c++
//                                        ^^^^^ meta.function.c++ entity.name.function.c++
//                                                     ^^^^^^^^^^^^ storage.modifier.cuda-c++
{
    __shared__ float tile[256];
//  ^^^^^^^^^^ storage.modifier.cuda-c++
    int i = blockIdx.x * blockDim.x + threadIdx.x;
//          ^^^^^^^^ variable.language.cuda-c++
//                       ^^^^^^^^ variable.language.cuda-c++
//                                    ^^^^^^^^^ variable.language.cuda-c++
//                                              ^ variable.other.readwrite.member.c++
    dim3 g(1, 2);
//  ^^^^ support.type.cuda-c++
    tile[threadIdx.x] = __ldg(&a[i]);
//       ^^^^^^^^^ variable.language.cuda-c++
//                      ^^^^^ support.function.cuda-c++
    __syncthreads();
//  ^^^^^^^^^^^^^ support.function.cuda-c++
    atomicAdd(&counter, 1);
//  ^^^^^^^^^ support.function.cuda-c++
    float y = __shfl_down(x, 1) + __fmul_rn(x, y) + __expf(x);
//            ^^^^^^^^^^^ support.function.cuda-c++
//                                ^^^^^^^^^ support.function.cuda-c++
//                                                  ^^^^^^ support.function.cuda-c++
    float v = tex1Dfetch<float>(tex, i) + tex2D<float4>(obj, u, v).x;
//            ^^^^^^^^^^ support.function.cuda-c++
//                      ^ punctuation.definition.generic.begin.c++
//                       ^^^^^ storage.type
//                            ^ punctuation.definition.generic.end.c++
//                                        ^^^^^ support.function.cuda-c++
//                                              ^^^^^^ support.type.cuda-c++
    printf("%d\n", i);
//  ^^^^^^ - support.function.cuda-c++
}
// <- meta.function.c++ meta.block.c++ punctuation.section.block.end.c++

struct Functor {
    __device__ float operator()(float x) const { return x; }
//  ^^^^^^^^^^ storage.modifier.cuda-c++
//                   ^^^^^^^^^^ entity.name.function
    friend std::ostream& operator<<<>(std::ostream&, const Functor&);
//                       ^^^^^^^^^^^^^^ - meta.kernel-launch - keyword.operator.kernel-launch
    friend std::ostream& operator <<<>(std::ostream&, const Functor&);
//                       ^^^^^^^^^^^^^^^ - meta.kernel-launch - keyword.operator.kernel-launch
};
// <- - meta.kernel-launch

template <typename T> __global__ void apply(T* a) { }
// <- keyword.declaration.template
//                    ^^^^^^^^^^ storage.modifier.cuda-c++
//                                    ^^^^^ entity.name.function.c++

int main()
{
    scale<<<g, 256, 0, stream>>>(d_a, n);
//  ^^^^^ variable.function.cuda-c++
//       ^^^ meta.kernel-launch.cuda-c++ keyword.operator.kernel-launch.begin.cuda-c++
//          ^^^^^^^^^^^^^^^^^^ meta.kernel-launch.cuda-c++
//           ^ punctuation.separator
//                           ^^^ meta.kernel-launch.cuda-c++ keyword.operator.kernel-launch.end.cuda-c++
//                              ^^^^^^^^ meta.group.c++
//                                      ^ punctuation.terminator
    scale<<<dim3(n / 256), dim3(256)>>>(d_a->data(), n);
//  ^^^^^ variable.function.cuda-c++
//          ^^^^ support.type.cuda-c++
//                                  ^^^ keyword.operator.kernel-launch.end.cuda-c++
//                                         ^^ punctuation.accessor
    apply<float><<<1, 1>>>(d_a);
//              ^^^ keyword.operator.kernel-launch.begin.cuda-c++
//                     ^^^ keyword.operator.kernel-launch.end.cuda-c++
    (apply<float, int>)<<<1, 1>>>(d_a);
//                     ^^^ keyword.operator.kernel-launch.begin.cuda-c++
//                            ^^^ keyword.operator.kernel-launch.end.cuda-c++
    ns::scale<<<n >> 1, 256>>>(d_a, n);
//  ^^ - variable.function
//    ^^ punctuation.accessor.double-colon.c++
//      ^^^^^ variable.function.cuda-c++
//           ^^^ keyword.operator.kernel-launch.begin.cuda-c++
//                ^^ keyword.operator
//                         ^^^ keyword.operator.kernel-launch.end.cuda-c++
    ::scale<<<1, 1>>>(d_a, n);
//    ^^^^^ variable.function.cuda-c++
//         ^^^ keyword.operator.kernel-launch.begin.cuda-c++
    scale<<<n < limit ? 1 : 2, 32>>>(d_a, n);
//            ^ keyword.operator.comparison
//                               ^^^ keyword.operator.kernel-launch.end.cuda-c++
//                                  ^^^^^^^^ meta.group.c++ - meta.kernel-launch
    scale<<<n, i < j ? 1 : 2, s > -1 ? 4 : 8>>>(d_a, n);
//               ^ keyword.operator.comparison - punctuation.definition.generic
//                              ^ keyword.operator.comparison - punctuation.definition.generic
//                                          ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<n, i<j ? 1 : 2, s > -1 ? 4 : 8>>>(d_a, n);
//              ^ keyword.operator.comparison - punctuation.definition.generic
//                            ^ keyword.operator.comparison - punctuation.definition.generic
//                                        ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<1, block_size_v<Traits<Layout<float>>> >> 1>>>(d_a);
//                                             ^^^ punctuation.definition.generic.end.c++
//                                                 ^^ keyword.operator
//                                                     ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<dim3(std::max<int>(n, 1)), 32>>>(d_a, n);
//                       ^ punctuation.definition.generic.begin.c++
//                                       ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<1, f<g<h<int>>>()>>>(d_a, n);
//             ^ variable.function.c++
//                      ^^^ punctuation.definition.generic.end.c++
//                           ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<static_cast<unsigned>(n + 255) / 256, 256>>>(d_a, n);
//          ^^^^^^^^^^^ keyword.operator.word.cast.c++
//                                                   ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<tex1Dfetch<int>(t, 0), 32>>>(d_a, n);
//          ^^^^^^^^^^ support.function.cuda-c++
//                                   ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<1, ::Traits<Kernel<Layout<float>>>::block_size>>>(d_a, n);
//             ^^ punctuation.accessor.double-colon.c++
//                     ^ punctuation.definition.generic.begin.c++
//                                         ^^^ punctuation.definition.generic.end.c++
//                                                        ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<block_size_v<T>, 32>>>(d_a, n);
//                      ^ punctuation.definition.generic.begin.c++
//                        ^ punctuation.definition.generic.end.c++
//                             ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale<<<1, block_size_v<T>>>>(d_a, n);
//                         ^ punctuation.definition.generic.begin.c++
//                           ^ punctuation.definition.generic.end.c++
//                            ^^^ keyword.operator.kernel-launch.end.cuda-c++
//                               ^^^^^^^^ meta.group.c++ - meta.kernel-launch
    scale<<<1, block_size_v<Traits<Layout<float>>> + 1>>>(d_a, n);
//                                             ^^^ punctuation.definition.generic.end.c++
//                                                    ^^^ keyword.operator.kernel-launch.end.cuda-c++
    scale
        <<<1, 32>>>(d_a, n);
//      ^^^ keyword.operator.kernel-launch.begin.cuda-c++
//              ^^^ keyword.operator.kernel-launch.end.cuda-c++
    apply<float>
        <<<1, 32>>>(d_a);
//      ^^^ keyword.operator.kernel-launch.begin.cuda-c++
//              ^^^ keyword.operator.kernel-launch.end.cuda-c++
    ::atomicAdd(&counter, 1);
//  ^^ punctuation.accessor.double-colon.c++
//    ^^^^^^^^^ support.function.cuda-c++
    float w = ::tex1Dfetch<float>(tex, i);
//            ^^ punctuation.accessor.double-colon.c++
//              ^^^^^^^^^^ support.function.cuda-c++
    operator  <<<>(a, b);
//            ^^^^ - meta.kernel-launch - keyword.operator.kernel-launch
//                      ^ - meta.kernel-launch
    operator/*x*/<<<>(a, b);
//               ^^^^ - meta.kernel-launch - keyword.operator.kernel-launch
//                         ^ - meta.kernel-launch
    operator
        <<<>(a, b);
//      ^^^^ - meta.kernel-launch - keyword.operator.kernel-launch
//                ^ - meta.kernel-launch
    operator
        <<< >(a, b);
//      ^^^^^ - meta.kernel-launch - keyword.operator.kernel-launch
//                 ^ - meta.kernel-launch
    int x = a << 2;
//            ^^ keyword.operator
    return 0;
//  ^^^^^^ keyword.control
}
// <- meta.function.c++ meta.block.c++ punctuation.section.block.end.c++

// An unterminated launch must not swallow the rest of the file.
void unfinished() { scale<<<1, 32; }
//                                ^ - meta.kernel-launch
//                                 ^ punctuation.section.block.end.c++

void half_typed() { float t = tex1Dfetch<float(tex, i); }
//                            ^^^^^^^^^^ support.function.cuda-c++
//                                                      ^ punctuation.section.block.end.c++

void next() {}
// <- - meta.kernel-launch
//   ^^^^ entity.name.function.c++
