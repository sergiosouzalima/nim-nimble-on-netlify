## Program name........: nimbleDirectoryHtml.nim
## Program description.: Creates index.html page, based on
##                       Nimble packages Directory (https://nimble.directory/packages.xml).
## Author..............: Sergio Lima
## Created at..........: Jun, 18 2022
## How to compile:
##   nimbleDirectoryHtml$ nim c -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed src/nimbleDirectoryHtml.nim
## How to run
##   ./src/nimbleDirectoryHtml

import httpClient, xml, xml/selector, strutils
import htmlText

let url = "https://nimble.directory/packages.xml"
let xmlFile = "assets/packages.xml"
let htmlFile = "public/index.html"

proc writeMessageToUser(messageToUser: string) =
  echo messageToUser

func updatedAtFormat(updatedAt: string):string =
  var updatedSplit = updatedAt.split
  return updatedSplit[1] & "/" & updatedSplit[2] & "/" & updatedSplit[3] & " " & updatedSplit[4]

proc downloadXmlFromNimbleDir(url, xmlFile: string) =
  var client = newHttpClient()
  var messageToUser = "XML downloaded to " & xmlFile
  try:
    var file = system.open(xmlFile, fmWrite)
    defer: file.close()
    file.write(client.getContent(url))
  except IOError as err:
    messageToUser = "Failed to download XML: " & err.msg
  writeMessageToUser(messageToUser)

func writeHTMLTableRow(seqXmlItems: seq[XmlNode] ): string =
    var pkgDescription = seqXmlItems[1].text
    var pkgLink = seqXmlItems[2].text
    var pkgShowLink = pkgLink.split("/")[4]
    var pkgUpdatedAt = seqXmlItems[4].text.updatedAtFormat
    result &= "<tr>\n"
    result &= "  <td><link><a href=\"" & pkgLink & "\" target=\"_blank\">" & pkgShowLink & "</a></link></td>\n"
    result &= "  <td class=\"cell-breakWord\">" & pkgDescription & "</td>\n"
    result &= "  <td>" & pkgUpdatedAt & "</td>\n"
    result &= "</tr>"

proc writeHtmlBeforeItems(htmlFile: string) =
  var messageToUser = "HTML file created (before items)."
  let indexHtmlFile = open(htmlFile, fmWrite)
  defer: indexHtmlFile.close()
  try:
    indexHtmlFile.writeLine(htmlPagePart1())
    indexHtmlFile.writeLine(htmlPagePart2())
    indexHtmlFile.writeLine(htmlPagePart3())
  except IOError as err:
    messageToUser = "Failed to create HTML (before items): " & err.msg
  writeMessageToUser(messageToUser)

proc writeHtmlItemsFromXML(xmlFile: string) =
  var messageToUser = "HTML file created (items)."
  var xml = q($system.readFile(xmlFile))
  var arrayXmlItemFields = xml.select("item")
  try:
    let itemsFile = open(htmlFile, fmAppend)
    defer: itemsFile.close()
    for item in 0..arrayXmlItemFields.len-1:
      let seqXmlItems = arrayXmlItemFields[item].select("^channel^item")
      let strHtmlLine = writeHTMLTableRow(seqXmlItems)
      itemsFile.writeLine(strHtmlLine)
  except IOError as err:
    messageToUser = "Failed to create HTML (items):: " & err.msg
  writeMessageToUser(messageToUser)

proc writeHtmlAfterItems(htmlFile: string) =
  var messageToUser = "HTML file created (after items)."
  try:
    let indexHtmlFile = open(htmlFile, fmAppend)
    defer: indexHtmlFile.close()
    indexHtmlFile.writeLine(htmlPagePart4())
  except IOError as err:
    messageToUser = "Failed to create HTML (after items):: " & err.msg
  writeMessageToUser(messageToUser)

when isMainModule:
  downloadXmlFromNimbleDir(url, xmlFile)
  writeHtmlBeforeItems(htmlFile)
  writeHtmlItemsFromXML(xmlFile)
  writeHtmlAfterItems(htmlFile)
  writeMessageToUser("HTML file successfully generated: " & htmlFile & "\n")