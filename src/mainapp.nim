## Program name........: mainapp.nim
## Program description.: Creates index.html page, based on
##                       Nimble packages Directory (https://nimble.directory/packages.xml).
## Author..............: Sergio Lima
## Created on..........: Jun, 18 2022
## How to compile:
##   $ nim c -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed --out:exe/mainapp src/mainapp.nim
## How to run
##   $ ./exe/mainapp

import httpClient, xml, xml/selector, strutils
import htmlSource
import std/strformat

const url = "https://nimble.directory/packages.xml"
const xmlFile = "public/packages.xml"
const htmlFile = "public/index.html"

proc writeMessageToUser(message: string) =
  echo message

func updatedAtFormat*(updatedAt: string):string =
  return fmt"""{updatedAt[5 .. 6]}/{updatedAt[8 .. 10]}/{updatedAt[12 .. 15]}{updatedAt[16 .. 24]}"""

proc writeHtml(htmlFile: string, htmlPage: string, beforeOrAfterItems: string, fileMode: FileMode) =
  let successHtmlCreation = fmt"""HTML file created ({beforeOrAfterItems} items)."""
  let failHtmlCreation = fmt"""Failed to create HTML ({beforeOrAfterItems} items): """
  var htmlCreationMessage = successHtmlCreation
  let indexHtmlFile = open(htmlFile, fileMode)
  defer: indexHtmlFile.close()
  try:
    indexHtmlFile.write(htmlPage)
  except IOError as err:
    htmlCreationMessage = failHtmlCreation & err.msg
  writeMessageToUser(htmlCreationMessage)

proc writeHtmlBeforeItems(htmlFile: string) =
  writeHtml(htmlFile, htmlPagePart01, "before", fmWrite)

proc writeHtmlAfterItems(htmlFile: string) =
  writeHtml(htmlFile, htmlPagePart02, "after", fmAppend)

proc downloadXmlFromNimbleDir(url, xmlFile: string) =
  var client = newHttpClient()
  var xmlDownload = "XML downloaded to " & xmlFile
  try:
    var file = system.open(xmlFile, fmWrite)
    defer: file.close()
    file.write(client.getContent(url))
  except IOError as err:
    xmlDownload = "Failed to download XML: " & err.msg
  writeMessageToUser(xmlDownload)

func writeHTMLTableRow(seqXmlItems: seq[XmlNode] ): string =
  let spaces = repeat(" ",12)
  var pkgDescription = seqXmlItems[1].text
  var pkgLink = seqXmlItems[2].text
  var pkgShowLink = pkgLink.split("/")[4]
  var pkgUpdatedAt = seqXmlItems[4].text.updatedAtFormat
  result &= fmt"""{spaces}<tr>{'\n'}"""
  result &= fmt"""{spaces}  <td><link><a href="{pkgLink}" target=_blank>{pkgShowLink}</a></link></td>{'\n'}"""
  result &= fmt"""{spaces}  <td class=cell-breakWord>{pkgDescription}</td>{'\n'}"""
  result &= fmt"""{spaces}  <td>{pkgUpdatedAt}</td>{'\n'}"""
  result &= fmt"""{spaces}</tr>{'\n'}"""

proc writeHtmlItemsFromXML(xmlFile: string) =
  var htmlCreation = "HTML file created (items)."
  var xml = q($system.readFile(xmlFile))
  var arrayXmlItemFields = xml.select("item")
  try:
    let itemsFile = open(htmlFile, fmAppend)
    defer: itemsFile.close()
    for item in 0..arrayXmlItemFields.len-1:
      let seqXmlItems = arrayXmlItemFields[item].select("^channel^item")
      let strHtmlLine = writeHTMLTableRow(seqXmlItems)
      itemsFile.write(strHtmlLine)
  except IOError as err:
    htmlCreation = "Failed to create HTML (items): " & err.msg
  writeMessageToUser(htmlCreation)

when isMainModule:
  downloadXmlFromNimbleDir(url, xmlFile)
  writeHtmlBeforeItems(htmlFile)
  writeHtmlItemsFromXML(xmlFile)
  writeHtmlAfterItems(htmlFile)
  writeMessageToUser(fmt"""HTML file successfully generated: {htmlFile} {'\n'}""")