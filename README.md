# openforti-docker

Just a simple docker container to forward ports through an ssl-vpn via iptables.
If your university, company, etc. offers some services only via ssl-vpn,
you can easily forward those ports to your home Network or your Notebook so you dont need the [forticlient](https://www.fortinet.com/support/product-downloads#vpn). Since the service can can be configured to start automatically, keep in mind that your credentials are stored in plain text.

## Installing

### Public repository

I'll try to configure a pipeline to build images and push them to a public registry

### Dependencies

- docker

### Building

~~~
git clone https://github.com/niggowai/openforti-docker.git
cd openforti-docker
docker build --no-cache -t openforti-docker .
~~~

## Running

### required files

Following files need to be mounted in the container

 - **./conf:/etc/openfortivpn/conf**
 - **./forwarding-rules:/forwarding-rules**

These files can be mounted as read-only

If you wish to execute additional commands, you can import a modified entrypoint

- **./entrypoint.sh:/entrypoint.sh**

### configuration

#### conf

a minimal setup requires:

~~~
host = domain.tld
port = 443
username = YourName
password = secret
~~~

if your container fails, or just to be sure you may add following parameter with the sha-256 fingerprint of your server-certificate

~~~
trusted-cert = b0719325763a427870b6dd1db4a6b4792fcb7d0b3f4af2471bb32641b38b73bb
~~~

if you want your container to reconnect you can use following option with the time in seconds as cooldown to wait before trying again to reconnect

~~~
persistent = 5
~~~

### forwarding-rules

I recommend to use my example and replace the port(s) and host(s) with your values.
Keep in mind that you have to configure two rules for one port, one for PREROUTING and one for POSTROUTING

As an alternative, it is possible to create the rules with iptables-save

### docker compose/docker run

- You have to forward every port also on Docker
- you need to forward the device **/dev/ppp** which is needed to create the tunnel
- your container needs capabilities to create Network interfaces (NET_ADMIN)

## Projects used

- [adrienverge/openfortivpn](https://github.com/adrienverge/openfortivpn)

## Credits

Thanks to [@adrienverge](https://github.com/adrienverge)