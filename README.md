# rearc
I am on a quest to do my best. 
#Deploy the app in any public cloud and navigate to the index page. Use Linux 64-bit x86/64 as your OS in AWS. 
Bastion host created with Linux 64-bit x86/64 in us-east-2 region.
Docker compose file created to pass the secrets 
version: '3'

services:
  webserver:
    image: node:10
    command: env
    environment:
      - USER
      - PASSWORD
Next, secrets can be injected by wrapping the docker-compose command with the same secrethub run command:
secrethub run \
    -e USER=${SECRETHUB_USERNAME}/rearc/user \
    -e PASSWORD=${SECRETHUB_USERNAME}/rearc/password \
    -- docker-compose up
