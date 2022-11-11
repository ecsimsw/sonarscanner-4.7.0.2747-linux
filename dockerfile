FROM alpine:latest

RUN apk add curl
RUN apk add unzip

RUN curl --create-dirs -sSLo /sonarqube/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip
RUN unzip -o /sonarqube/sonar-scanner.zip -d /sonarqube/
