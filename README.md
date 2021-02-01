# ft_server

#### # Build image
```docker
docker build --tag wp .
```

#### # Run container
```docker
docker run --name ft_server -it -p 80:80 -p 443:443 wp
```

#### # Autoindex on/off
```bash
sed -i "s/\bon\b/off/" /etc/nginx/sites-available/wp-nginx.conf
service nginx reload
```
<!-- #### # Clear
```docker
docker rm -vf $(docker ps -aq)
docker rmi -f $(docker images -aq)
``` -->