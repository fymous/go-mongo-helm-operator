FROM golang:1.21-alpine as builder
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go build -o go-app main.go

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/go-app .
EXPOSE 8080
CMD ["./go-app"]
