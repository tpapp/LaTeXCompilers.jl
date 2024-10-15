# LaTeXCompilers.jl

![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
[![build](https://github.com/tpapp/LaTeXCompilers.jl/workflows/CI/badge.svg)](https://github.com/tpapp/LaTeXCompilers.jl/actions?query=workflow%3ACI)
<!-- NOTE: Codecov.io badge now depends on the token, copy from their site after setting up -->
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

Compile LaTeX code from Julia.

The exported functions are `pdf`, `svg`, and `png`. Each has a form that takes a closure for writing code to an `::IO` output.

Currently [tectonic](https://github.com/JuliaTesting/Aqua.jl) "https://tectonic-typesetting.github.io/en-US/") is the only supported backend. A backend using a local `pdflatex` is planned.
