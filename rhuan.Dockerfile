FROM swift:5.9-jammy AS builder
WORKDIR /build
COPY ./Package.* ./
RUN swift package resolve
COPY . .
RUN swift build -c release

FROM swift:5.9-slim 
WORKDIR /app
COPY --from=builder /build/.build/release/App .
EXPOSE 8080
CMD ["./App"]