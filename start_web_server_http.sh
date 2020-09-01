# Install docker
yum install -y docker

# Start the docker service
systemctl start docker

# Remove the existing docker DL
rm /usr/local/bin/docker-compose
rm /usr/bin/docker-compose

# Download docker compose
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Mark as executable
chmod +x /usr/local/bin/docker-compose

# Symbolic link to the bin dir
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Pull from repo if it is already present, otherwise clone
if [ -d "/hemme/website" ]; then
	cd /hemme/website
	git pull
else
	mkdir /hemme
	cd /hemme
	git clone https://github.com/hg-connor/website.git
fi

cd /hemme/website/docker/behind_elb

# Start docker compose script which will build the website and start it
docker-compose up -d