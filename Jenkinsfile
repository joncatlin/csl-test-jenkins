/*
    This file defines the Jenkins pipeline to be executed in order to build and test this application. The 
    file is referenced inside of a Jenkins pipeline job which uses the github repo to locate and execute this file.
*/
def thisTestMethod = this.&cslTest

CSLDevelopmentPipeline {
    cslAWSRegistryPrefix = 'research/'
    testMethod = thisTestMethod
/*
    branch = 'master'
    scmUrl = 'ssh://git@myScmServer.com/repos/myRepo.git'
    email = 'team@example.com'
    serverPort = '8080'
    developmentServer = 'dev-myproject.mycompany.com'
    stagingServer = 'staging-myproject.mycompany.com'
    productionServer = 'production-myproject.mycompany.com'
*/
}

/*
    Define the routine that will test the container to see if it works
*/
def cslTest(appName) {
    println "********************** In cslTest() **************************"
    println "********************** In cslTest() **************************"
    println "********************** In cslTest() **************************"
    println "********************** In cslTest() **************************"
    println "********************** In cslTest() **************************"


    // Get the logs of the container to show in the jenkins log as this will contain the text to prove that
    // the build job was successful
    sh 'docker logs ' + appName

}

