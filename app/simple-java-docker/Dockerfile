# ------------------------------
# Stage 1: Build
# ------------------------------
FROM amazoncorretto:21-alpine AS builder

# Set working directory
WORKDIR /app

# Copy all Java source files
COPY src/ /app/src/

# Compile Java files
RUN javac src/*.java -d out

# ------------------------------
# Stage 2: Runtime
# ------------------------------
FROM amazoncorretto:21-alpine

# Metadata
LABEL maintainer="your-email@example.com"
LABEL version="1.0"
LABEL description="Simple Java application using Amazon Corretto 21"

# Set working directory
WORKDIR /app

# Copy compiled classes from builder
COPY --from=builder /app/out /app

# (Optional) Document the port your app uses
# EXPOSE 3000

# Run the Java application 
CMD ["java", "Main"]

#comment