## Program name........: test1.nim
## Program description.: Unit tests
## Author..............: Sergio Lima
## Created on..........: Jun, 26 2022
## How to compile:
##   $ nim c -r -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed tests/test1
## How to run
##   $ ./tests/test1

import unittest

import ../src/mainapp

suite "Main App":
  setup:
    let currentTimeStamp: string = "Sun, 26 Jun 2022 10:54:12 Z"

  test "updatedAtFormat":
    check updatedAtFormat(currentTimeStamp) == "26/Jun/2022 10:54:12"
