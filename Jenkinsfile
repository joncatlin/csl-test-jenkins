node("docker") {

    // Define variables for use below
    def app
    def registry = 'https://index.docker.io/v1/'
    def registryCredential = 'demo-dockerhub-credentials'
    def imageName = "joncatlin/csl-test-jenkins:${env.BUILD_ID}"

    stage ('checkout') {
        checkout scm
    }

    stage ('build') {
        app = docker.build(imageName)
    }

    stage ('test') {
        app.run()
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

