using LaTeXCompilers
using Test

###
### utilities: rudimentary checks for output files
###

is_pdf(path) = open(io -> read(io, 4), path, "r") == b"%PDF"
is_svg(path) = open(io -> read(io, 5), path, "r") == b"<?xml"
is_png(path) = open(io -> read(io, 4), path, "r") == b"\x89PNG"

###
### specific tests
###

@testset "compile" begin
    LATEX_MWE = raw"""
              \documentclass{article}
              \begin{document}
              Hello world
              \end{document}
              """
    pdf_path = tempname() * ".pdf"
    @time LaTeXCompilers.pdf(io -> write(io, LATEX_MWE), pdf_path)
    @test is_pdf(pdf_path)
    svg_path = tempname() * ".svg"
    @time LaTeXCompilers.svg(io -> write(io, LATEX_MWE), svg_path)
    @test is_svg(svg_path)
    png_path = tempname() * ".png"
    @time LaTeXCompilers.png(io -> write(io, LATEX_MWE), png_path)
    @test is_png(png_path)
end

@testset "compile error" begin
    LATEX_BOGUS_MWE = raw"""
              \documentclass{article}
              \begin{document}
              \hbox{$unterminated}
              \end{document}
              """
    pdf_path = tempname() * ".pdf"
    @test_throws(raw"Extra }, or forgotten $",
                 LaTeXCompilers.pdf(io -> write(io, LATEX_BOGUS_MWE), pdf_path))
end

###
### generic checks
###

using JET
@testset "static analysis with JET.jl" begin
    @test isempty(JET.get_reports(report_package(LaTeXCompilers, target_modules=(LaTeXCompilers,))))
end

@testset "QA with Aqua" begin
    import Aqua
    Aqua.test_all(LaTeXCompilers; ambiguities = false)
    # testing separately, cf https://github.com/JuliaTesting/Aqua.jl/issues/77
    Aqua.test_ambiguities(LaTeXCompilers)
end
