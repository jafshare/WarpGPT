FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY . .
RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct 
RUN go build -o warpgpt

FROM alpine
WORKDIR /app
COPY --from=builder /app/warpgpt .
EXPOSE 5000
CMD './warpgpt'