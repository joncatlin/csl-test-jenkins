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
        CSL_REGISTRY_CREDENTIALS = credentials('demo-dockerhub-credentials')
    }
    stages {
        stage('checkout') {
            steps {
                checkout scm

                sh 'printenv'
            }
        }

        stage('printenv') {
            steps {
                script { 
                    def csl_repo_name = scm.getUserRemoteConfigs()[0].getUrl().tokenize('/').last().split("\\.")[0]
                    env.CSL_REPO_NAME = csl_repo_name
//                    sh 'export CSL_REPO_NAME="' + csl_repo_name + '"'
                    wrap([$class: 'BuildUser']) { 
                        def csl_stack_name = "${env.BUILD_USER_ID}"
//                        sh 'export CSL_STACK_NAME=' + csl_stack_name
                        env.CSL_STACK_NAME = csl_stack_name
                    }
                }

                sh 'printenv'
                println "Hi there jon this is a println"
            }
        }
    }


}
















