import requests

def checklink(url):
    r = requests.head(url).status_code
    if r == 200:
        print(''.join([url, ' ', str(r)]))
        return True
    else:
        print(''.join([url, ' ', str(r)]))
        return False

