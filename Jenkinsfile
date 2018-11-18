/*
    This file defines the Jenkins pipeline to be executed in order to build and test this application. The 
    file is referenced inside of a Jenkins pipeline job which uses the github repo to locate and execute this file.
*/
pipeline {

    // Run the agent on a node that has the label docker
    agent {
        node {
            label 'docker'
        }
    }

    environment { 
        CSL_MESSAGE = 'hi jon'
        CSL_REGISTRY = 'https://index.docker.io/v1/'
        CSL_COMPOSE_FILENAME = 'csl-test-jenkins-compose.yml'
        CSL_REGISTRY_CREDENTIALS = 'demo-dockerhub-credentials'
//        wrap([$class: 'BuildUser']) { 
//            CSL_STACK_NAME = "${env.BUILD_USER_ID}"
//        }
    }
    stages {
        stage('checkout') {
            steps {
                checkout scm

                sh 'printenv'
            }
        }

        environment { 
            CSL_REPO_NAME = scm.getUserRemoteConfigs()[0].getUrl().tokenize('/').last().split("\\.")[0]
        }

        stage('printenv') {
            steps {
                sh 'printenv'
            }
        }
    }


}
















