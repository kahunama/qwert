FROM alpine

EXPOSE 80

WORKDIR /home/choreouser

COPY entrypoint.sh ./

RUN apk update &&\
    apk add --no-cache bash iproute2 vim netcat-openbsd &&\
    wget -O temp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip &&\
    unzip temp.zip xray geoip.dat geosite.dat &&\
    mv xray x &&\
    rm -f temp.zip &&\
    chmod -v 755 x entrypoint.sh &&\
    addgroup --gid 10001 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup choreo choreouser

ENTRYPOINT [ "./entrypoint.sh" ]

USER 10001
