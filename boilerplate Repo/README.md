# MySQL + Flask

This repo contains a setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
2. A Python Flask container to implement a REST API
3. A Local AppSmith Server

## How to set-up and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
2. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
3. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
4. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
5. Build the images with `docker compose build`
6. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## Connecting to AppSmith
1. Once the three containers have been spun up, wait for the appsmith container to say 'APPSMITH IS RUNNING'
2. Type 'localhost:8080' in browser: this should take you to appsmith
3. Create a new user. You may have to do this every time you redo the containers.

## Creating AppsSmith UI
1. Create an application
2. Create a new page
3. Click 'New query/JS' then click 'New blank API'. There are many options here. Pick the verb: get,post,put,delete. Next to the verb type 'web:4000/[prefix]/[blueprint-name]' depending on which blueprint you are using.
4. You may have to add to the body depending on the function of the API.
5. Click 'Run' to test the API. If it does not work, test to see what is wrong.
6. Add widgets and connect them to queries to display and modify data.

## Our Flask API
Our routes are organized into blueprints based on the entity referenced in the resource. 

## Using our App
Our app in AppSmith has seven pages for three personas - customer, travel agent, and manager - that use a variety of get, post, put, and delete functions. The app is very easy to use. On view pages, typing in the respective ID brings up the data related to that ID. To delete data, simply click the trash can icon in the corresponding row. To modify data that is allowed to be modified, hit the pencil icon on the corresponding cell.

## Link to our Video
https://youtu.be/6sSBMC3psOo

