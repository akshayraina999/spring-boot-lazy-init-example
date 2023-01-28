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
        // stage('Code Analysis'){
        //     steps{
        //         script{
        //             withSonarQubeEnv(credentialsId: 'sonar-api'){
        //                 sh 'mvn clean package sonar:sonar'
        //             }
        //         }
        //     }
        // }
        // stage('Quality Gate Status'){
        //     steps{
        //         script{
        //             waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api'
        //         }
        //     }
        // }
        stage('Docker Build'){
            steps{
                // sh "docker build . -t akshayraina/${JOB_NAME}:${DOCKER_TAG} "
                sh "docker build . -t akshayraina/${JOB_NAME}:${BUILD_NUMBER} "
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]){
                    sh 'docker login -u akshayraina -p ${dockerhubpwd}'
                }
                
                sh "docker push akshayraina/${JOB_NAME}:${BUILD_NUMBER} "
            }
        }
        stage('Deploy to Kubernetes cluster'){
            steps{
                script{
                    kubernetesDeploy configs: 'deploy.yml', kubeconfigId: 'kubernetes' 
                }
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}