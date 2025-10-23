FROM eclipse-temurin:17-jre-jammy
EXPOSE 8080
# Copy the assembled jar (match any jar produced in build/libs)
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar
RUN bash -c 'touch /app/app.jar'
ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
