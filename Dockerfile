# *********** STAGE_1******************

FROM golang:1.22.5 as BASE

WORKDIR /app

COPY go.mod .

RUN go mod download  #for installing dependencies from the dev team

COPY . .

RUN go build -o main . 

# ***********STAGE 2 ( with distroless-image) ******************

FROM  gcr.io/distroless/base

WORKDIR /app

COPY --from=BASE  /app/main  .

COPY  --from=BASE  /app/static  ./static

EXPOSE 8080

CMD ["./main"]