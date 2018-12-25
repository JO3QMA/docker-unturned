FROM ubuntu:bionic
WORKDIR /srv/steamcmd
ENV locale=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive
ENV UNT_DIR=/srv/unturned
ADD entrypoint.sh /srv/entrypoint.sh

RUN set -x \
 && echo "${TZ}" > /etc/timezone \
 && rm -rf /etc/localtime \
 && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt-get update \
 && apt-get install -y tzdata gnupg2 ca-certificates \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
 && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
 && apt-get update \
 && apt-get install -y mono-devel mono-complete \
 && echo "Install module required by SteamCMD" \
 && apt-get install -y locales \
      lib32gcc1\
      curl \
      tar \
 && echo "Install module required by Unturned" \
 && dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y unzip \
      screen \
      htop \
      wget \
      build-essential \
      gcc-multilib \
      rpm \
      libstdc++6:i386 \
      libgcc1:i386 \
      zlib1g:i386 \
      libncurses5:i386 \
      libc6:i386 \
      libgl1-mesa-glx:i386 \
      libxcursor1:i386 \
      libxrandr2:i386 \
 && rm -rf /var/lib/apt/lists/* \
 && localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 \
 && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
 && ./steamcmd.sh + login anonymous +quit \
 && chmod +x /srv/entrypoint.sh

WORKDIR ${UNT_DIR}
EXPOSE 27015-27017/udp
ENTRYPOINT [ "/srv/entrypoint.sh" ]