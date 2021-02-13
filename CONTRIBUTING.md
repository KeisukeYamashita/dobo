# To release a new version

Update the version number, currently found in [dobo](./dobo) and [com.github.KeisukeYamashita.Dobo.appdata.xml](misc/com.github.KeisukeYamashita.Dobo.appdata.xml). Then:

```sh
export DOBO_VERSION=0.0.1 # replace with the updated version number
git tag -a -m $DOBO_VERSION $DOBO_VERSION
git push --tags
```

A new [Docker build](https://hub.docker.com/repository/docker/KeisukeYamashita/gibo/builds) will be triggered automatically.

## To update Homebrew

```sh
export DOBO_VERSION=0.0.1 # replace with the updated version number
export DOBO_URL=https://github.com/KeisukeYamashita/dobo/archive/${DOBO_VERSION}.tar.gz
export DOBO_SHA=$(curl -sSL $DOBO_URL | shasum -a 256 | cut -d' ' -f1)
brew bump-formula-pr gibo --url $DOBO_URL --sha256 $DOBO_SHA
```
