Dockerfile for spotify-ripper-ubuntu originally from https://github.com/darrenwatt/docker-spotify-ripper

Build from docker file

```
git clone https://github.com/kevinflynn387/docker-spotify-ripper-ubuntu.git
cd docker-spotify-ripper-ubuntu
cp -pr example.config.ini config.ini
```
edit config to suit
```
vi config.ini
docker build -t spotify-ripper-ubuntu .
```
Start with

```
docker run -d -h your_host_name -v /your_download_location:/data --name spotify-ripper-ubuntu spotify-ripper-ubuntu
```

Send commands with

```
docker exec spotify-ripper-ubuntu spotify-ripper spotify:track:52xaypL0Kjzk0ngwv3oBPR
```
Get Spotify URI's for tracks and playlists by right-clicking from Spotify app.
