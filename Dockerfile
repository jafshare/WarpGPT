FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY . .
RUN go build -o warpgpt

FROM alpine
WORKDIR /app
COPY --from=builder /app/warpgpt .
COPY .env .
EXPOSE 5000
CMD './warpgpt'