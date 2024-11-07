node('java') {

stage('Checkout') {
checkout([$class: 'GitSCM',
branches: [[name: 'main']],
userRemoteConfigs: [[url: 'https://github.com/BinduPrivate/java-example.git']]
])
}

stage('Test') {
try {
sh 'mvn clean test'
echo 'Running unit test and integration test'
} catch (Exception e) {
error 'Tests failed!'
}
}

stage('Build') {
try {
sh 'mvn clean package'
echo 'Build successful'
} catch (Exception e) {
error 'Build failed!'
}
}

stage('Deploy') {
try {

sh 'sudo rsync -av /home/ubuntu/jenkins/workspace/scripted-pipeline/target/works-with-heroku-1.0.war  /opt/apache-tomcat-9.0.96/webapps'
echo 'Successfully deployed'
} catch (Exception e) {
error 'Deployment failed!'
}
}
}
