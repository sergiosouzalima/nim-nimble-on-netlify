## Program name........: scheduledJob.nim
## Program description.: .
## Author..............: Sergio Lima
## Created on..........: Jul, 2 2022
## How to compile:
##   $ nim c --verbosity:0 --hints:off --opt:speed --threads:on --out:exe/scheduledJob src/scheduledJob.nim
## How to run
##   $ ./exe/scheduledJob

import schedules, times, os

const commandLine = "./exe/mainapp"

schedules:
  every(seconds=60, id="NimProgram"):
    echo("Running " & commandLine & " at " & $now())
    discard execShellCmd(commandLine)
