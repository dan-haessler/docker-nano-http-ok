# nano-http-ok
A nano sized docker container which returns 200.

## Build & Run
```
docker build -t <image-name> .
docker run -d <image-name>
```
or 
```
docker compose up --build
```

## Test
`curl localhost:8080`