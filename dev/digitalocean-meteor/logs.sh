docker logs -f $(docker ps | grep $APP:latest | awk '{print $1;}')
