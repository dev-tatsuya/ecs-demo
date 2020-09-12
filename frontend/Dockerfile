FROM google/dart AS build-env

RUN apt-get update && \
    apt-get install -y curl git wget zip unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback \
        lib32stdc++6 python3 && \
    apt-get clean && \
    git clone https://github.com/flutter/flutter.git /usr/local/flutter && \
    /usr/local/flutter/bin/flutter doctor -v

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter channel master && \
    flutter upgrade && \
    flutter config --enable-web

WORKDIR /usr/local/ecs_demo
COPY . /usr/local/ecs_demo
RUN flutter build web

FROM nginx
COPY --from=build-env /usr/local/ecs_demo/build/web /usr/share/nginx/html
