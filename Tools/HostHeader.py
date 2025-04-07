def queueRequests(target, wordlists):
    engine = RequestEngine(endpoint=target.endpoint,
                           concurrentConnections=5,
                           requestsPerConnection=10,
                           pipeline=False)

    host_variations = [
        {"Host": "bing.com"},
        {"Host": "bing.com", "X-Forwarded-Host": "realweb.com"},
        {"Host": "realweb.com", "X-Forwarded-Host": "bing.com"},
    ]

    for i, headers in enumerate(host_variations):
        modified = target.req.copy()
        for key, value in headers.items():
            modified.replace_header(key, value)
        engine.queue(modified)

def handleResponse(req, interesting):
    if req.status in [200, 301, 302, 303, 304]:
        print(f"{req.status} - Headers: {req.get_headers()} - {req.get_response_header('Location')}")
