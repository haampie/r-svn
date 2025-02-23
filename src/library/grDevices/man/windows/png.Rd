% File src/library/grDevices/man/windows/png.Rd
% Part of the R package, https://www.R-project.org
% Copyright 1995-2023 R Core Team
% Distributed under GPL 2 or later

\name{png}
\alias{png}
\alias{jpeg}
\alias{tiff}
\alias{bmp}
\title{\abbr{BMP}, \abbr{JPEG}, \abbr{PNG} and \abbr{TIFF} graphics devices}
\description{
  Graphics devices for \abbr{BMP}, \abbr{JPEG}, \abbr{PNG} and \abbr{TIFF} format bitmap files.
}
\usage{
bmp(filename = "Rplot\%03d.bmp",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo"), antialias,
    symbolfamily="default")

jpeg(filename = "Rplot\%03d.jpg",
     width = 480, height = 480, units = "px", pointsize = 12,
     quality = 75,
     bg = "white", res = NA, family = "", restoreConsole = TRUE,
     type = c("windows", "cairo"), antialias,
     symbolfamily="default")

png(filename = "Rplot\%03d.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"), antialias,
    symbolfamily="default")

tiff(filename = "Rplot\%03d.tif",
     width = 480, height = 480, units = "px", pointsize = 12,
     compression = c("none", "rle", "lzw", "jpeg", "zip",
                     "lzw+p", "zip+p",
                     "lerc", "lzma",  "zstd", "webp"),
     bg = "white", res = NA, family = "", restoreConsole = TRUE,
     type = c("windows", "cairo"), antialias,
     symbolfamily="default")
}
\arguments{
  \item{filename}{the path of the output file, up to 511 characters.  The
    page number is substituted if a C integer format is included in the
    character string, as in the default, and tilde-expansion is
    performed (see \code{\link{path.expand}}).   (The result must be less than
    600 characters long.  See \code{\link{png}} for further
    details.)
  }
  \item{width}{the width of the device.}
  \item{height}{the height of the device.}
  \item{units}{The units in which \code{height} and \code{width} are
    given.  Can be \code{px} (pixels, the default), \code{in} (inches),
    \code{cm} or \code{mm}.}
  \item{pointsize}{the default pointsize of plotted text, interpreted as
    big points (1/72 inch) at \code{res} ppi.}
  \item{bg}{the initial background colour: can be overridden by setting
    par("bg").}
  \item{quality}{the \sQuote{quality} of the \abbr{JPEG} image, as a
    percentage.  Smaller values will give more compression but also more
    degradation of the image.}
   \item{compression}{the type of compression to be used.  Can also be a
     numeric value supported by the underlying \code{libtiff} library :
     see its \file{tiff.h} header file.}
  \item{res}{The nominal resolution in ppi which will be recorded in the
    bitmap file, if a positive integer.  Also used for units other than
    the default.  If not specified, taken as 72 ppi to set the size of
    text and line widths.}
  \item{family}{A length-one character vector specifying the default
    font family.  The default means to use the font numbers on the
    Windows GDI versions and \code{"sans"} on the cairographics
    versions.}
  \item{restoreConsole}{See the \sQuote{Details} section of
    \code{\link{windows}}.  For \code{type == "windows"} only.}
  \item{type}{Should be plotting be done using Windows GDI or cairographics?}
  \item{antialias}{Length-one character vector.

    For allowed values and their effect on fonts with \code{type =
      "windows"} see \code{\link{windows}}: for that type if the
    argument is missing the default is taken from
    \code{windows.options()$bitmap.aa.win}.

    For allowed values and their effect (on fonts and lines, but not
    fills) with \code{type = "cairo"} see \code{\link{svg}}.}
  \item{symbolfamily}{  For cairographics only:
      a length-one character string that specifies the font family to
      be used as the "symbol" font (e.g., for \link{plotmath} output).
      The default value is "default", which means that R will choose
      a default "symbol" font based on the graphics device capabilities.}
}
\details{
  Plots in \abbr{PNG} and \abbr{JPEG} format can easily be converted to many other
  bitmap formats, and both can be displayed in modern web browsers.  The
  \abbr{PNG} format is lossless and is best for line diagrams and blocks of
  colour.  The \abbr{JPEG} format is lossy, but may be useful for image plots,
  for example.  The \abbr{BMP} format is standard on Windows, and supported by
  most viewers elsewhere.  \abbr{TIFF} is a meta-format: the default format
  written by \code{tiff} is lossless and stores RGB (and alpha where
  appropriate) values uncompressed---such files are widely accepted,
  which is their main virtue over \abbr{PNG}.

  Windows GDI imposes limits on the size of bitmaps: these are not
  documented in the SDK and may depend on the version of Windows.
  It seems that \code{width} and \code{height} are each limited to
  \eqn{2^{15}-1}{2^15-1}.  In addition, there are limits on the total
  number of pixels which depend on the graphics hardware.

  By default no resolution is recorded in the file (except for \abbr{BMP}).
  Viewers will often assume a nominal resolution of 72 ppi when none is
  recorded.  As resolutions in \abbr{PNG} files are recorded in pixels/metre,
  the reported ppi value will be changed slightly.

  For graphics parameters that make use of dimensions in inches,
  \code{res} ppi (default 72) is assumed.

  Both \code{bmp} and \code{png} will use a palette if there are fewer
  than 256 colours on the page, and record a 24-bit RGB file otherwise.
  For the \code{png} device, \code{type = "cairo"} does the \abbr{PNG} output in
  the driver and so is compatible with the \code{"windows"} type.
  \code{type = "cairo-png"} uses cairographics' \abbr{PNG} backend which will
  never use a palette and normally creates a larger 32-bit ARGB
  file---this may work better for specialist uses with semi-transparent
  colours.

  The \abbr{JPEG} format only supports opaque backgrounds.

  \code{png(type = "windows")} supports transparent backgrounds on 16-bit
  (\sQuote{High Color}) or better screens: use \code{bg =
    "transparent"}.  There is also support for semi-transparent colours
  of lines, fills and text.  However, as there is only partial support
  for transparency in the graphics toolkit used: if there is a
  transparent background semi-transparent colours are painted onto a
  slightly off-white background and hence the pixels are opaque.

  Not all \abbr{PNG} viewers render files with transparency correctly.

  \code{tiff} compression types \code{"lzw+p"} and \code{"zip+p"} use
  horizontal differencing (\sQuote{differencing predictor}, section 14
  of the \abbr{TIFF} specification) in combination with the compression method,
  which is effective for continuous-tone images, especially colour ones.
  The \code{jpeg} quality when used for \code{tiff} compression is fixed
  at 75.
  
  Unknown resolutions in \abbr{BMP} files are recorded as 72 ppi.
}

\value{
  A plot device is opened: nothing is returned to the \R interpreter.
}

\section{Warnings}{
  Note that by default the \code{width} and \code{height} values are in
  pixels not inches.  A warning will be issued if both are less than 20.

  If you plot more than one page on one of these devices and do not
  include something like \code{\%d} for the sequence number in
  \code{file}, the file will contain the last page plotted.
}

\section{Differences between OSes}{
  These functions are interfaces to three or more different underlying
  devices.
  \itemize{
    \item On Windows, devices based on plotting to a hidden screen using
    Windows' GDI calls.

    \item On platforms with support for X11, plotting to a hidden X11
    display.

    \item On macOS when working at the console and when \R is
    compiled with suitable support, using Apple's Quartz plotting
    system.

    \item Where support has been compiled in for cairographics, plotting
    on cairo surfaces.  This may use the native platform support for
    fonts, or it may use \code{fontconfig} to support a wide range of
    font formats.
  }
  Inevitably there will be differences between the options supported and
  output produced.  Perhaps the most important are support for
  antialiased fonts and semi-transparent colours: the best results are
  likely to be obtained with the cairo- or Quartz-based devices where
  available.

  The default extensions are \file{.jpg} and \file{.tif} on Windows, and
  \file{.jpeg} and \file{.tiff} elsewhere.
}

\note{
  The \code{type = "windows"} versions of these devices effectively
  plot on a hidden screen and then copy the image to the required
  format.  This means that they have the same colour handling as the
  actual screen device, and work best if that is set to a 24-bit or
  32-bit colour mode.

  For high-quality plots you will probably want \code{antialias =
    "cleartype"} if this is not the default on your Windows system.  On
  the other hand, \code{png(antialias = "none")} will give the most
  compact files

  Support for compression types depends on the underlying \samp{libtiff}
  library: types \code{"lerc"}, \code{"lzma"}, \code{"zstd"} and
  \code{"webp"} are relatively recent additions and may well not be
  supported.  They are also liable to be unsupported in \abbr{TIFF} viewers.
}

\references{
  The \abbr{PNG} specification, \url{https://www.w3.org/TR/png/}.
  
  The \abbr{TIFF} specification,
  \url{https://www.iso.org/standard/34342.html}.
  See also \url{https://en.wikipedia.org/wiki/TIFF}.
  %% no longer works:
  %% \url{https://partners.adobe.com/public/developer/tiff/}.
}
\seealso{
  \code{\link{Devices}}, \code{\link{dev.print}}

  \code{\link{capabilities}} to see if these devices are
  supported by this build of \R, and if \code{type = "cairo"} is supported.

  \code{\link{bitmap}} provides an alternative way to generate plots in many
  bitmap formats that does not depend on accessing the X11 display but does
  depend on having GhostScript installed.

  Ways to write raster images to bitmap formats are available in
  packages \CRANpkg{jpeg}, \CRANpkg{png} and \CRANpkg{tiff}.
}

\section{Conventions}{
  This section describes the implementation of the conventions for
  graphics devices set out in the \sQuote{R Internals} manual.

  \itemize{
    \item The default device size is in pixels.
    \item Font sizes are in big points interpreted at \code{res} ppi.
    \item The default font family is Arial.
    \item Line widths are a multiple of 1/96 inch (interpreted at
    \code{res} ppi), with a minimum of one pixel (\code{type =
      "windows"}) or 0.01 (\code{type = "cairo"}).
    \item The minimum radius of a circle is 1 pixel for \code{type =
      "windows"}.
    \item Colours are interpreted by the viewing application.
  }
}

\examples{
## copy current plot to a (large) PNG file
\dontrun{dev.print(png, file = "myplot.png", width = 1024, height = 768)

png(file = "myplot.png", bg = "transparent")
plot(1:10)
rect(1, 5, 3, 7, col = "white")
dev.off()

jpeg(file = "myplot.jpeg")
example(rect)
dev.off()
}}
\keyword{device}
