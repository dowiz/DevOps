#! /bin/bash
sudo rm -rf /opt/mssql/
sudo mkdir /opt/mssql/
sudo chmod 777 -R /opt/mssql/
sudo docker run -v /opt/mssql:/var/opt/mssql/ -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Qwerty-1" -p 1433:1433 --name docker_MSSQL --hostname docker_MSSQL -d mcr.microsoft.com/mssql/server:2022-latest
sudo docker ps