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
    }
    stages {
        stage('checkout') {
            environment { 
                CSL_REGISTRY_CREDENTIALS = 'demo-dockerhub-credentials'
            }

            steps {
                checkout scm

                sh 'printenv'
            }
        }
    }
}
















