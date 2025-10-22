FROM gradle:8.11-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
# Use the Gradle wrapper if present for exact Gradle distribution
RUN if [ -x ./gradlew ]; then ./gradlew clean build --no-daemon; else gradle clean build --no-daemon; fi

FROM eclipse-temurin:17-jre-jammy
EXPOSE 8080
# Copy the assembled jar (match any jar produced in build/libs)
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar
RUN bash -c 'touch /app/app.jar'
ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
