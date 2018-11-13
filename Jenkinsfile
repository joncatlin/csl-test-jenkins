/*
    This file defines the Jenkins pipeline to be executed in order to build and test this application. The 
    file is referenced inside of a Jenkins pipeline job which uses the github repo to locate and execute this file.
*/
node("docker") {

    // Define variables for use below
    def app
    def container
    def registry = 'https://index.docker.io/v1/'
    def registryCredential = 'demo-dockerhub-credentials'
    def appName = 'csl-test-jenkins'
    def imageName = "joncatlin/" + appName + ":${env.BUILD_ID}"

    stage ('checkout') {
        checkout scm
    }

    stage ('build') {
        app = docker.build(imageName)
    }

    stage ('test') {
        try {
            container = app.run('--name ' + appName)

            // Get the logs of the container
            sh 'docker logs ' + appName
        }
        finally {
            try { container.stop } catch (ex) { /* ignore */ }
        }
    }


    stage ('publish') {
        docker.withRegistry(registry, registryCredential) {

            // Push the current version
            app.push()

            // Push the current version as the lastest version
            app.push('latest')
        }
    }


}

