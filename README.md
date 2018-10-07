# dockerized-yolo-mtg-1
Card Detection YOLO

Based on https://github.com/pjreddie/darknet & https://github.com/komorin0521/darknet_server

```
sudo docker run --name mtg-yolo -d -p 8080 royhobbstn/dockerized-yolo-mtg-1
```

```
curl -XPOST -F file=@./cards.jpg http://localhost:8080/detect
```
