# README

## Build dev image
```
    docker-compose up --build
``` 

## Build prod image
```
    docker-compose -f docker-compose-prod.yml up --build
``` 

## Run scripts on Rails container
```
    docker-compose run web rails db:migrate 
    docker-compose -f docker-compose-prod.yml run web rails db:migrate
```


## Create ssh tunnel
```
    ssh user@ip-address -L <localport>:localhost:<serverport> -C
``` 