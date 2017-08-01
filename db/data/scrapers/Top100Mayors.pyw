import csv
import requests
import sys
reload(sys)
sys.setdefaultencoding('utf8')
from BeautifulSoup import BeautifulSoup

url = 'https://ballotpedia.org/List_of_current_mayors_of_the_top_100_cities_in_the_United_States'
response = requests.get(url)
html = response.content

soup = BeautifulSoup(html)
mayors = soup.find('table', attrs={'class': 'wikitable sortable'})

list_of_rows = []
for row in mayors.findAll('tr')[1:]:
    list_of_cells = []
    for cell in row.findAll('td'):
        text = cell.text.replace('&nbsp;', '')
        list_of_cells.append(text)
    list_of_cells = list_of_cells[:-1]
    list_of_rows.append(list_of_cells)

outfile = open("./mayors.csv", "wb")
writer = csv.writer(outfile)
writer.writerow(["Rank", "City", "Mayor", "Term Begin", "Term End"])
writer.writerows(list_of_rows)
