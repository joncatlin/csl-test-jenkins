node("docker") {

    def app
//    def registry = 'https://registry.hub.docker.io'
    def registry = 'https://index.docker.io/v1/'
    def registryCredential = 'demo-dockerhub-credentials'

//    environment {
//        registry = "joncatlin/csl-test-jenkins"
//        registryCredential = 'demo-dockerhub-credentials'
//    }

    stage ('checkout') {
        checkout scm
    }

    stage ('build') {
        app = docker.build("joncatlin/csl-test-jenkins:${env.BUILD_ID}")
//        app = docker.build registry + ":$BUILD_NUMBER"
/*
        script {
            app = docker.build registry + ":$BUILD_NUMBER"
        }
*/
    }

    stage ('publish') {
        echo 'Publishing..'
    }

    docker.withRegistry(registry, 'demo-dockerhub-credentials') {

        app.push()
        app.push('latest')
    }

}

