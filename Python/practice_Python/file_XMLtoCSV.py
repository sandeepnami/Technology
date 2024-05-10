from xml.etree import ElementTree
import csv

xml_path = 'tempxml.xml'
csv_path = 'tempcsv.csv'

xml_data = ElementTree.parse(xml_path)
csv_data = open(csv_path, 'w')
csv_writer = csv.writer(csv_data)

csv_line = []
#get name of elements and build heading
for row in xml_data.findall("row"):
    for child in row:
        csv_line.append(child.tag)
    csv_writer.writerow(csv_line)
    break

row_count = 0
for row in xml_data.findall("row"):
    print('test')
