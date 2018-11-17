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
    def appName

    // Set the name of the docker repository to be used
    def registry = 'https://index.docker.io/v1/'

    // Set the name of the Jenkins credentials to be used to login to the Docker repository
    def registryCredential = 'demo-dockerhub-credentials'

    // Set the name of the compose file to be used in deploying the container into a swarm
    def composeFilename = 'csl-test-jenkins-compose.yml'

    // Get the name of the user who started the build. 
    // This will be used for the stack name in 'docker stack deploy ...'
    wrap([$class: 'BuildUser']) { stackName = "${env.BUILD_USER_ID}"}


    stage ('checkout') {
        checkout scm

        // Get the name of the repo and use that as the image name
        appName = scm.getUserRemoteConfigs()[0].getUrl().tokenize('/').last().split("\\.")[0]
        println "Application name, derived from git repo = '" + appName + "'"

        if (!env.VERSION) {
            // Get the latest version tag from the repo. Version tags are in the format v1.0.1, 
            // a v at the beginning of the line followed by digits '.' digits '.' digits
            version = sh(script: "git tag | sed -n -e 's/^v\\([0-9]*\\.[0-9]*\\.[0-9]*\\)/\\1/p' | tail -1", returnStdout: true)

            // Remove any rubbish charactes from the version
            version = version.replaceAll("\\s","")
        } else {
            version = ${env.VERSION}
        }
        println "Version to tag image with = '" + version + "'"
    }

    stage ('build') {
        def build = ".build-" + System.currentTimeMillis()
        println "Build to tag image with = " + build
        imageName = "joncatlin/" + appName + ":" + version + build
        app = docker.build(imageName)
    }

    stage ('publish') {
        docker.withRegistry(registry, registryCredential) {

            // Push the current version as the lastest version
            app.push('latest')

            // Push the current version
            app.push(version)
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
        // Deploy the stack in the existing swarm
        sh 'docker stack deploy --compose-file ' + composeFilename + " " + stackName
    }

}

