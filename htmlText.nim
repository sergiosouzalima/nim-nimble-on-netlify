## Program name........: htmlText.nim
## Program description.: Provides index.html page in parts.
## Author..............: Sergio Lima
## Created at..........: Jun, 18 2022
## How to compile:
##   nimbleDirectoryHtml$ nim c -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed src/nimbleDirectoryHtml.nim
## How to run
##   ./src/nimbleDirectoryHtml

import strutils, std/[times]

func htmlPagePart1*: string =
  return """
<!DOCTYPE html>
<html lang="en-GB">
"""

func htmlPagePart2*: string =
  return """
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title>Home Page | Nimble Packages Directory</title>
  <meta name="description" content="Nimble Packages Directory." />
  <link rel="stylesheet" href="https://cdn.simplecss.org/simple.css" />

  <style>
    /* Dark theme */
    :root {
      --bg: #212121;
      --accent-bg: #2b2b2b;
      --text: #dcdcdc;
      --text-light: #ababab;
      --border: #666;
      --accent: #ffb300;
      --code: #f06292;
      --preformatted: #ccc;
      --disabled: #111;
    }
    /* Add a bit of transparancy so light media isn't so glaring in dark mode */
    img,
    video {
      opacity: 0.8;
    }
  </style>
</head>
"""
func htmlPagePart3*: string =
  return """
  <body>
    <header>
      <nav>
        <a href="index.html">Home</a>

        <a href="https://nimble.directory/" target="_blank">Nimble Directory</a>

        <a href="https://www.nim-lang.org/" target="_blank">👑 Nim Language</a>
      </nav>

      <h1>Nim Package Directory</h1>
      <p>Are you a 👑 Nim developer? Search for packages or jump to a package page.</p>
    </header>

    <main>
      <div class="blog-item">
        <table>
          <thead>
            <tr>
              <th>Packages</th>
              <th>Description</th>
              <th>Updated at</th>
            </tr>
          </thead>
          <tbody>
  """

proc htmlPagePart4*: string =
  let strCurrentDate: string = now().format("yyyy-MM-dd")
  let strHtml = """
        </tbody>
      </table>

      <article>
        This website was last updated on $# <br />
        Nim packages dataset available <a href="https://nimble.directory/packages.xml" target="_blank">here</a>.
      </article>
  </main>
  <footer>
    <p>
      This website was created with &#128151; by <a href="https://sergiosouzalima.dev">Sergio Lima</a>.
      Powered &#128170; by
      <a href="https://nim-lang.org/">Nim</a> & <a href="https://simplecss.org/">Simple.css</a>.
    </p>
  </footer>
</body>

</html>
"""
  return strHtml.format(strCurrentDate)
