import requests


def searchWikidata(query):
    API_ENDPOINT = 'https://www.wikidata.org/w/api.php'
    params = {
        'action': 'wbsearchentities',
        'format': 'json',
        'language': 'sr',
        'search': query
    }
    r = requests.get(API_ENDPOINT, params= params)
    if r.json()['search'] != []:
        return r.json()['search'][0]['concepturi']
    else:
        return ''

