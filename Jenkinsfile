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

                script { 
                    // Get the name of the repo from the scm
                    env.CSL_REPO_NAME = scm.getUserRemoteConfigs()[0].getUrl().tokenize('/').last().split("\\.")[0]
                    // Use the time in ms as the build number
                    env.CSL_BUILD = ".build-" + System.currentTimeMillis()

                    if (!env.CSL_VERSION) {
                        // Get the latest version tag from the repo. Version tags are in the format v1.0.1, 
                        // a v at the beginning of the line followed by digits '.' digits '.' digits
                        def version = sh(script: "git tag | sed -n -e 's/^v\\([0-9]*\\.[0-9]*\\.[0-9]*\\)/\\1/p' | tail -1", returnStdout: true)

                        // Remove any rubbish charactes from the version
                        env.CSL_VERSION = version.replaceAll("\\s","")
                    }

                    // Get the name of the user who started this build
                    wrap([$class: 'BuildUser']) { 
                        env.CSL_STACK_NAME = "${env.BUILD_USER_ID}"
                    }
                }

                sh 'printenv'
            }
        }

        stage ('build') {
            steps {
                app = docker.build('jon')
            }
        }


    }


}
















