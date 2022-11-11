# sonarscanner-4.7.0.2747-linux
Quick sonar-scanner configuration for SonarCloud

## What you need from SonarCloud
- SONAR_PROJECT_ORGANIZATION   
- SONAR_PROJECT_KEY   
- SONAR_TOKEN

## How to use 1 : Using the file itself
0. Clone and place `sonar-scanner-4.7.0.2747-linux`
1. Change directory to where you want scan   
2. Call sonar-scanner with SonarCloud project values as prameters

```
$YOUR_CLONE_PATH/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner \
 -Dsonar.organization=$SONAR_PROJECT_ORGANIZATION \
 -Dsonar.projectKey=$SONAR_PROJECT_KEY \
 -Dsonar.login=$SONAR_TOKEN \
 -Dsonar.sources=. \
 -Dsonar.host.url=https://sonarcloud.io   
```

## How to use 2 : Using docker image for builder container
0. Clone this repository
1. Build with dockerfile 
2. PATH of sonar-scanner : `/sonarqube/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner`
3. Use this docker image for creating container on my jenkins pipeline script

``` groovy
podTemplate($POD_TEMPLATE) {
    node($POD_LABEL) {
        container(...) {
            stage(...) {
            }
        }

        container($IMAGE_NAME) {
            stage($STAGE_NAME) {
                sh """
                   cd $SCANNING_PROJECT_PATH
                   $/sonarqube/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner \
                      -Dsonar.organization=$SONAR_PROJECT_ORGANIZATION \
                      -Dsonar.projectKey=$SONAR_PROJECT_KEY \
                      -Dsonar.login=$SONAR_TOKEN  \
                      -Dsonar.sources=. \
                      -Dsonar.host.url=https://sonarcloud.io 
                """
            }
        }
    }
}
```

## Optional) Useful parameters
- -X : debug
- sonar.branch : Manage SCM branches
- sonar.language : Set the language of the source code to analyze
- sonar.coverageReportPaths : Set test coverage report file path / 
- sonar.testExecutionReportPaths : Set test execution report path

e.g
```
sonar-scanner -X \
 -Dsonar.branch=dev \
 -sonar.coverageReportPaths=xunit-coverage.xml \
 -sonar.testExecutionReportPaths=xunit-execution.xml
```

test coverage & execution report file format : https://docs.sonarqube.org/latest/analysis/generic-test/    
other analysis parameters : https://docs.sonarqube.org/latest/analysis/analysis-parameters/
