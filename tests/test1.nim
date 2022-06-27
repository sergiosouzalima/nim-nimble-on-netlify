## Program name........: test1.nim
## Program description.: Unit tests
## Author..............: Sergio Lima
## Created on..........: Jun, 26 2022
## How to compile:
##   $ nim c -r -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed tests/test1
## How to run
##   $ ./tests/test1

import unittest
import std/strformat

import ../src/mainapp

suite "func updatedAtFormat":

  let currentTimeStamp1: string = "Sun, 26 Jun 2022 10:54:12 Z"
  let test1 = fmt"""when date is {currentTimeStamp1} it returns '26/Jun/2022 10:54:12' """

  let currentTimeStamp2: string = "Sat, 18 Jun 2022 05:46:51 Z"
  let test2 = fmt"""when date is {currentTimeStamp2} it returns '18/Jun/2022 05:46:51' """

  let currentTimeStamp3: string = "Fri, 17 Jun 2022 04:16:12 Z"
  let test3 = fmt"""when date is {currentTimeStamp3} it returns '17/Jun/2022 04:16:12' """

  test test1:
    check updatedAtFormat(currentTimeStamp1) == "26/Jun/2022 10:54:12"

  test test2:
    check updatedAtFormat(currentTimeStamp2) == "18/Jun/2022 05:46:51"

  test test3:
    check updatedAtFormat(currentTimeStamp3) == "17/Jun/2022 04:16:12"

