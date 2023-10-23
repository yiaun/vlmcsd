## VLMCSD for Docker  
Deploy vlmcsd service on Docker container

```bash
git clone https://github.com/yiaun/vlmcsd.git vlmcsd
cd vlmcsd

# Use docker-compose service
docker-compose up -d

# or docker build image
docker build -t vlmcsd .
docker run -itd --name vlmcsd --restart=always -p 1688:1688 vlmcsd
```
```bash
local installation
cd /root
git clone https://github.com/yiaun/vlmcsd.git vlmcsd
apt/yum -y install make gcc 
cd vlmcsd && make
rsync -az /root/vlmcsd/bin/vlmcsd /usr/bin/

cat > /usr/lib/systemd/system/vlmcsd.service >> EOF
[Unit]
Description=KMS Server By vlmcsd
After=network.target
[Service]
Type=forking
PIDFile=/var/run/vlmcsd.pid
ExecStart=/usr/bin/vlmcsd -p /var/run/vlmcsd.pid -l /var/log/vlmcsd.log
ExecStop=/bin/kill -HUP $MAINPID
PrivateTmp=true
[Install]
WantedBy=multi-user.target
EOF

systemctl enable --now vlmcsd.service
```
