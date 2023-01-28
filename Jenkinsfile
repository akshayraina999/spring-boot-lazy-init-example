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
        stage('Docker Build'){
            steps{
                sh "docker build . -t akshayraina/dockeransiblejenkins:${DOCKER_TAG} "
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]){
                    sh 'docker login -u akshayraina -p ${dockerhubpwd}'
                }
                
                sh "docker push akshayraina/dockeransiblejenkins:${DOCKER_TAG} "
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}