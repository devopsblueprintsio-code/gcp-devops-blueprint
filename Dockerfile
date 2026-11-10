# --- Build stage -------------------------------------------------------------
FROM golang:1.24 AS build
WORKDIR /src

# Leverage layer caching: copy module files first, then the source.
COPY go.mod ./
RUN go mod download
COPY . .

# Static binary so it runs on a scratch/distroless base.
RUN CGO_ENABLED=0 GOOS=linux go build -o /app main.go

# --- Runtime stage -----------------------------------------------------------
# Distroless: no shell, no package manager, minimal attack surface.
FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /app /app
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/app"]
