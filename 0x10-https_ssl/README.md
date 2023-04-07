<center><h1>0x10. HTTPS SSL</h1></center>

-> This repositiory contains tasks involved with converting a server from http to https, using ssl termination.

-> Also, the domain zone is configured using A records as follows:

---
<center><h2>Domain: mvshv.tech </h2></center>

| Subdomain | IP |
| --------- | ---- |
| www | 18.235.248.46 |
| lb-01 | 18.235.248.46 |
| web-01 | 35.175.104.175 |
| web-01 | 34.224.5.166 |

<br>


<center><h2> Tasks </h2></center>
| Tasks | Files | Description |
| ----- | ----- | ------ |
| 0:  World wide web | [0-world_wide_web]() | display information about subdomains. |
| 1: HAproxy SSL termination | [1-haproxy_ssl_termination]() | Haproxy config file |
