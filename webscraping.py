import requests
import pandas as pd
from bs4 import BeautifulSoup
import re 
import pandas as pd 
from urllib.parse import urlsplit
import os

#Load data by Web Scraping 


# Extraemos el nombre del equipo a partir de la url proporcionada.

def extract_team_name(url):
    path_components = urlsplit(url).path.split('/')
    
    team_name = None
    
    for component in path_components:
        if component and component != '/':
            team_name = component.replace("-", " ")
            break
    return team_name


# Extraemos el listado de las urls de los jugadores
def extract_urls(soup):
    profil_links = soup.find_all('a')
    urls = []
    
    for link in profil_links:
        if 'profil' in link.get('href', ''):
            url = f"https://www.transfermarkt.com{link.get('href')}"
            urls.append(url)
    return urls


# A partir de la url de cada jugador. Extraemos su nombre, posicion, valor, fecha de inicio y fecha de finalizacion de contrato.


def scrape_players_data(url):
    headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36'}
    html = requests.get(url, headers=headers)
    soup = BeautifulSoup(html.content, 'html.parser')
    
    #Extraemos el nombre de los jugadores
    name_player_wrapper = soup.find(class_="data-header__headline-wrapper")
    name_player = name_player_wrapper.get_text()
    nombres = re.search(r'([a-z|A-Z].*)', name_player).group(1).strip()
    
    position_wrapper = soup.find_all('dd', {"class": "detail-position__position"})
    position = position_wrapper[0].getText() if position_wrapper else "Position not available"

    market_value_wrapper = soup.find(class_='data-header__market-value-wrapper')
    market_value = market_value_wrapper.get_text()
    valor_numerico = re.search(r'€(\d+\.\d+)m', market_value)
    valor = float(valor_numerico.group(1)) if valor_numerico else None
    
    contract_expires_wrapper = soup.find_all("span", {"class": "data-header__label"})
    joined_date = re.search(r':\s*(.+)', contract_expires_wrapper[1].get_text(strip=True)).group(1)
    expiration_date = re.search(r':\s*(.+)', contract_expires_wrapper[2].get_text(strip=True)).group(1)
    
    return nombres, position, valor, joined_date, expiration_date




# Creamos el dataframe del equipo
def create_DataFrame(players_data):
    team = pd.DataFrame({
        'jugador': [data[0] for data in players_data],
        'equipo':  'real madrid',
        'posicion': [data[1] for data in players_data],
        'valor_actual_mercado': [data[2] for data in players_data],
        'fecha_de_contratacion': [data[3] for data in players_data],
        'expiracion_de_contrato': [data[4] for data in players_data]
        
    })
    
    return team


def main():
    url = "https://www.transfermarkt.com/real-madrid/startseite/verein/418"
    headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36'}
    html = requests.get(url, headers=headers)
    soup = BeautifulSoup(html.text, 'html.parser')
    
    team_name = extract_team_name(url)
    
    full_urls = extract_urls(soup)

    players_data = []
    for url in full_urls[:24]: # limitamos a un numero
        player_data = scrape_players_data(url)
        players_data.append(player_data)
    
    team = create_DataFrame(players_data)
    
    print(team.head(20))
    
    if team_name:
        if not os.path.exists("csv_files"):
            os.makedirs("csv_files")
        
        csv_filename = f"./csv_files/{team_name.replace(' ', '_')}.csv"    
        team.to_csv(csv_filename, index=False)
        
        file_name = f"{team_name.replace(' ', '_')}.csv"
        relative_path = os.path.relpath(file_name)
        print(f"El archivo {file_name} se guardo")
        
    else:
        print("No se guardó el archivo.")
    
    return team

    
        

if __name__ == "__main__":
    main()
