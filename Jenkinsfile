pipeline{
    agent any
    tools {
        maven 'maven_3_5_0'
    }
    environment {
        DOCKER_TAG = getVersion()
    }
    stages{
        stage('SCM'){
            steps{
                git credentialsId: 'github',
                    url: 'https://github.com/akshayraina999/spring-boot-lazy-init-example.git'
            }
        }

        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}