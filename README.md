# telegraf-snmp-syno
Telegraf image for delivering Synology telemetry data via SNMP to influxdb

## Usage
Container uses

### Ports
When using Bridge network ensure to map the following ports:

- 8092/udp
- 8094/tcp
- 8125/udp

### Volume
Link to `/etc/telegraf/telegraf.conf` (see sample file in this repo, it assumes the unflux server at http://192.168.0.100:8086 and a `synology` database)

### Links
I link the container to my influxdb instance, but should work fine without

