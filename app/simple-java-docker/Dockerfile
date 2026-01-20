# ------------------------------
# Stage 1: Build
# ------------------------------
FROM eclipse-temurin:17-jdk-alpine AS builder

# Set working directory
WORKDIR /app

# Copy all source files
COPY src/ /app/src/

# Compile all Java files into 'out' directory
RUN javac src/*.java -d out

# ------------------------------
# Stage 2: Runtime
# ------------------------------
FROM eclipse-temurin:17-jdk-alpine


# Set working directory
WORKDIR /app

# Copy compiled classes from builder stage
COPY --from=builder /app/out /app

# Run the Java application
CMD ["java", "Main"]
