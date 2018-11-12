/*
node("docker") {
    // docker.withRegistry('<<your-docker-registry>>', '<<your-docker-registry-credentials-id>>') {
    docker.withRegistry('joncatlin/csl-test-jenkins', 'demo-dockerhub-credentials') {
    
        // git url: "<<your-git-repo-url>>", credentialsId: '<<your-git-credentials-id>>'
        git url: "https://github.com/joncatlin/csl-test-jenkins.git", credentialsId: 'demo-github-credentials'
    
        sh "git rev-parse HEAD > .git/commit-id"
        def commit_id = readFile('.git/commit-id').trim()
        println "Commit id =" + commit_id
    
        stage "build"
        def app = docker.build "your-project-name"
    
        stage "publish"
        app.push 'master'
        app.push "${commit_id}"
    }
}
*/

node("docker") {

    def app
    def registry

    environment {
        registry = "joncatlin/csl-test-jenkins"
        registryCredential = 'demo-dockerhub-credentials'
    }

    stage ('checkout') {
        checkout scm
    }

    stage ('build') {
//        app = docker.build("csl-test-jenkins:${env.BUILD_ID}")
//        app = docker.build registry + ":$BUILD_NUMBER"
        steps{
            script {
                app = docker.build registry + ":$BUILD_NUMBER"
            }
        }
    }

    stage ('publish') {
        echo 'Publishing..'
        app.push
        app.push 'latest'
    }
}

/*
pipeline {
    agent "docker"
    echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                def app = docker.build("csl-test-jenkins-:${env.BUILD_ID}")
            }
        }
        stage('Publish') {
            steps {
                echo 'Publishing..'
                app.push 'latest'
                app.push "${env.BUILD_ID}"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
*/