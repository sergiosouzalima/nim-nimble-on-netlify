## Program name........: htmlSource.nim
## Program description.: Provides index.html.
## Author..............: Sergio Lima
## Created on..........: Jun, 18 2022
## How to compile:
##   $ nim c -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed --out:exe/mainapp src/mainapp.nim
## How to run
##   $ ./exe/mainapp

import std/[times]
import std/strutils

const htmlPagePart01*: string = readFile("src/html_page_part1.html")

let currentTimeStamp: string = now().format("ddd, d MMMM yyyy, hh:mm tt")

let htmlPagePart02*: string = readFile("src/html_page_part2.html").replace("{currentTimeStamp}", currentTimeStamp)