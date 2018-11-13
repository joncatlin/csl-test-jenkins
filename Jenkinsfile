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
    def composeFilename = 'csl-test-jenkins-compose.yml'

    stage ('checkout') {
        checkout scm
    }

    stage ('build') {
        app = docker.build(imageName)
    }

    stage ('publish') {
        docker.withRegistry(registry, registryCredential) {

            // Push the current version
            app.push()

            // Push the current version as the lastest version
            app.push('latest')
        }
    }

    stage ('test') {
        try {
            container = app.run('--name ' + appName)

            // Get the logs of the container to show in the jenkins log as this will contain the text to prove that
            // the build job was successful
            sh 'docker logs ' + appName
        }
        finally {
            try { container.stop } catch (ex) { /* ignore */ }
        }
    }

    stage ('deploy') {
        // Remove the stack if it already exists
        sh "docker stack rm ${env.DOCKER_STACK_NAME}"

        // Wait a short time for the system to tidy up
        sleep 5

        // Deploy the stack in the existing swarm
        sh 'docker stack deploy --compose-file ' + composeFilename + " ${env.DOCKER_STACK_NAME}"
    }

}

