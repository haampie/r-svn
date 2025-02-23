% File src/library/grDevices/man/unix/png.Rd
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
    bg = "white", res = NA, \dots,
    type = c("cairo", "Xlib", "quartz"), antialias)

jpeg(filename = "Rplot\%03d.jpeg",
     width = 480, height = 480, units = "px", pointsize = 12,
     quality = 75,
     bg = "white", res = NA, \dots,
     type = c("cairo", "Xlib", "quartz"), antialias)

png(filename = "Rplot\%03d.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA, \dots,
    type = c("cairo", "cairo-png", "Xlib", "quartz"), antialias)

tiff(filename = "Rplot\%03d.tiff",
     width = 480, height = 480, units = "px", pointsize = 12,
     compression = c("none", "rle", "lzw", "jpeg", "zip",
                     "lzw+p", "zip+p",
                     "lerc", "lzma",  "zstd", "webp"),
     bg = "white", res = NA,  \dots,
     type = c("cairo", "Xlib", "quartz"), antialias)
}
\arguments{
  \item{filename}{the output file path.
    The page number is substituted if a C integer format is included in
    the character string, as in the default.  (Depending on the platform,
    the result should be less
    than \code{PATH_MAX} characters long, and may be truncated if not.
    See \code{\link{pdf}} for further details.)  Tilde expansion
    is performed where supported by the platform.  An input with
    a marked encoding is converted to the native encoding on an error is
    given.}
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
     see its \file{tiff.h} header file.   Ignored with a warning for
     \code{type = "quartz"}.} 
  \item{res}{The nominal resolution in ppi which will be recorded in the
    bitmap file, if a positive integer.  Also used for \code{units}
    other than the default, and to convert points to pixels.}
  \item{\dots}{for \code{type = "Xlib"} only, additional arguments to
    the underlying \code{\link{X11}} device such as \code{fonts} or
     \code{family}.

    For types \code{"cairo"} and \code{"quartz"}, the \code{family}
    argument can be supplied.  See the \sQuote{Cairo fonts}
    section in the help for \code{\link{X11}}.
    
    For type \code{"cairo"}, the \code{symbolfamily}
    argument can be supplied.  See \code{\link{X11.options}}.
  }

  \item{type}{character string, one of \code{"Xlib"} or \code{"quartz"}
    (some macOS builds) or \code{"cairo"}.  The latter will only be
    available if the system was compiled with support for cairo --
    otherwise \code{"Xlib"} will be used.  The default is set by
    \code{\link{getOption}("bitmapType")} -- the \sQuote{out of the box}
    default is \code{"quartz"} or \code{"cairo"} where available,
    otherwise \code{"Xlib"}.}

  \item{antialias}{for \code{type = "cairo"}, giving the type of
    anti-aliasing (if any) to be used for fonts and lines (but not
    fills). See \code{\link{X11}}.  The default is set by
    \code{\link{X11.options}}.  Also for \code{type = "quartz"}, where
    antialiasing is used unless \code{antialias = "none"}.}
}
\details{
  Plots in \abbr{PNG} and \abbr{JPEG} format can easily be converted to many other
  bitmap formats, and both can be displayed in modern web browsers.  The
  \abbr{PNG} format is lossless and is best for line diagrams and blocks of
  colour.  The \abbr{JPEG} format is lossy, but may be useful for image plots,
  for example.  \abbr{BMP} is a standard format on Windows.  \abbr{TIFF} is a
  meta-format: the default format written by \code{tiff} is lossless and
  stores RGB (and alpha where appropriate) values uncompressed---such
  files are widely accepted, which is their main virtue over \abbr{PNG}.

  The \abbr{JPEG} format only supports opaque backgrounds.

  \code{png} supports transparent backgrounds: use \code{bg =
  "transparent"}.  (Not all \abbr{PNG} viewers render files with transparency
  correctly.)  When transparency is in use in the \code{type = "Xlib"}
  variant a very light grey is used as the background and so appears as
  transparent if used in the plot. This allows opaque white to be used,
  as in the example.  The \code{type = "cairo"}, \code{type =
  "cairo-png"} and \code{type = "quartz"} variants allow
  semi-transparent colours, including on a transparent or
  semi-transparent background.

  \code{tiff} with types \code{"cairo"} and \code{"quartz"} supports
  semi-transparent colours, including on a transparent or
  semi-transparent background.  Compression type \code{"zip"} is
  \sQuote{deflate (Adobe-style)}.  Compression types \code{"lzw+p"} and
  \code{"zip+p"} use horizontal differencing (\sQuote{differencing
  predictor}, section 14 of the \abbr{TIFF} specification) in combination with
  the compression method, which is effective for continuous-tone images,
  especially colour ones.

  The \code{jpeg} quality when used for \code{tiff} compression is fixed
  at 75.

  \R can be compiled without support for some or all of the types for
  each of these devices: this will be reported if you attempt to use
  them on a system where they are not supported.  For \code{type =
  "Xlib"} they may not be usable unless the X11 display is available to
  the owner of the \R process.  \code{type = "cairo"} requires cairo 1.2
  or later.  \code{type = "quartz"} uses the \code{\link{quartz}} device
  and so is only available where that is (on some macOS builds: see
  \code{\link{capabilities}("aqua")}).

  By default no resolution is recorded in the file, except for \abbr{BMP}.
  Viewers will often assume a nominal resolution of 72 ppi when none is
  recorded.  As resolutions in \abbr{PNG} files are recorded in pixels/metre,
  the reported ppi value will be changed slightly.

  For graphics parameters that make use of dimensions in inches
  (including font sizes in points) the resolution used is \code{res} (or
  72 ppi if unset).

  \code{png} will normally use a palette if there are less than 256
  colours on the page, and record a 24-bit RGB file otherwise (or a
  32-bit ARGB file if \code{type = "cairo"} and non-opaque colours are
  used).  However, \code{type = "cairo-png"} uses cairographics' \abbr{PNG}
  backend which will never use a palette and normally creates a larger
  32-bit ARGB file---this may work better for specialist uses with
  semi-transparent colours.

  Quartz-produced \abbr{PNG} and \abbr{TIFF} plots with a transparent background are
  recorded with a dark grey matte which will show up in some viewers,
  including \command{Preview} on macOS.
  
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
  For \code{type = "Xlib"} these devices are based on the \code{\link{X11}}
  device.  The colour model used will be that set up by
  \code{X11.options} at the time the first Xlib-based devices was opened
  (or the first after all such devices have been closed).

  Support for compression types depends on the underlying \samp{libtiff}
  library: types \code{"lerc"}, \code{"lzma"}, \code{"zstd"} and
  \code{"webp"} are relatively recent additions and may well not be
  supported.  They are also liable to be unsupported in \abbr{TIFF} viewers.
}

\author{Guido Masarotto and Brian Ripley}

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
    \item The default font family is Helvetica.
    \item Line widths in 1/96 inch (interpreted at \code{res} ppi),
    minimum one pixel for \code{type = "Xlib"}, 0.01 for \code{type =
      "cairo"}.
    \item For \code{type = "Xlib"} circle radii are in pixels with
    minimum one.
    \item Colours are interpreted by the viewing application.
  }

  For \code{type = "quartz"} see the help for \code{\link{quartz}}.
}

\examples{
## these examples will work only if the devices are available
## and cairo or an X11 display or a macOS display is available.

## copy current plot to a (large) PNG file
\dontrun{dev.print(png, file = "myplot.png", width = 1024, height = 768)}
\donttest{
png(file = "myplot.png", bg = "transparent")
plot(1:10)
rect(1, 5, 3, 7, col = "white")
dev.off()

## will make myplot1.jpeg and myplot2.jpeg
jpeg(file = "myplot\%d.jpeg")
example(rect)
dev.off()
}}
\keyword{device}
