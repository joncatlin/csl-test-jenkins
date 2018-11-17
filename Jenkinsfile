/*
    This file defines the Jenkins pipeline to be executed in order to build and test this application. The 
    file is referenced inside of a Jenkins pipeline job which uses the github repo to locate and execute this file.
*/
node("docker") {

    // Define variables for use below
    def app
    def container
    def stackName
    def version
    def imageName

    // Set the name of the docker repository to be used
    def registry = 'https://index.docker.io/v1/'

    // Set the name of the Jenkins credentials to be used to login to the Docker repository
    def registryCredential = 'demo-dockerhub-credentials'

    def appName = 'csl-test-jenkins'

    // Set the name of the compose file to be used in deploying the container into a swarm
    def composeFilename = 'csl-test-jenkins-compose.yml'

    // Get the name of the user who started the build. 
    // This will be used for the stack name in 'docker stack deploy ...'
    wrap([$class: 'BuildUser']) { stackName = "${env.BUILD_USER_ID}"}


    stage ('checkout') {
        checkout scm

        if (!env.VERSION) {
            // Get the latest version tag from the repo. Version tags are in the format v1.0.1, 
            // a v at the beginning of the line followed by digits '.' digits '.' digits
            version = sh(script: "git tag | sed -n -e 's/^v\\([0-9]*\\.[0-9]*\\.[0-9]*\\)/\\1/p' | tail -1", returnStdout: true)
        } else {
            version = ${env.VERSION}
        }
        println "Version to tag image with = " + version
    }

    stage ('build') {
        def build = ".build-" + System.currentTimeMillis()
        println "Build to tag image with = " + build
        imageName = "joncatlin/" + appName + version + build
        app = docker.build(imageName)
    }

    stage ('publish') {
        docker.withRegistry(registry, registryCredential) {

            // Push the current version as the lastest version
            app.push('latest')

            // Push the current version
            app.push("${env.BUILD_ID}")
        }
    }

    stage ('test') {
        try {
            // Remove any chance that the container could be left from previous attempts to test
            try {sh 'docker stop ' + appName} catch (ex) {/* ignore */}
            try {sh 'docker rm ' + appName} catch (ex) {/* ignore */}

            // Run the container to ensure it works
            container = app.run('--name ' + appName)

            // Get the logs of the container to show in the jenkins log as this will contain the text to prove that
            // the build job was successful
            sh 'docker logs ' + appName
        }
        finally {
            try { container.stop } catch (ex) { /* ignore */ }
        }
    }

    stage ('deploy-locally') {
        // // Remove the stack if it already exists
        // sh "docker stack rm ${env.DOCKER_STACK_NAME}"

        // // Wait a short time for the system to tidy up or the creation of the stack can
        // // collide with the previous remove of the stack
        // sleep 30

        // Deploy the stack in the existing swarm
        sh 'docker stack deploy --compose-file ' + composeFilename + " " + stackName
    }

}

