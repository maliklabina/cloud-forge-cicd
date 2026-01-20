# Stage 1: Build
FROM openjdk:17.0.9-jdk-alpine3.18 AS builder

# Set working directory
WORKDIR /app

# Copy all source files
COPY src/ /app/src/

# Compile Java code
RUN javac src/*.java -d out

# Stage 2: Runtime
FROM openjdk:17.0.9-jdk-alpine3.18

# Metadata
LABEL maintainer="your-email@example.com"
LABEL version="1.0"
LABEL description="A simple Java application"

# Set working directory
WORKDIR /app

# Copy compiled classes from builder
COPY --from=builder /app/out /app

# Run the Java application
CMD ["java", "Main"]
