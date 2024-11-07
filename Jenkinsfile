pipeline{
 agent none
 triggers {
  cron '* * * * *'
  pollSCM 'H/15 * * * *'
}

 environment{
   AWS_ACCESS_KEY=credentials('aws_access_key')
   GITHUB_CRED=credentials('github_cred')
   STRING='${params.evar1}'
   CHOICE='${params.evar2}'
   BOOLEAN='${params.evar3}'
 }
 parameters{
 string(name:'evar1',defaultValue:'jenkins-user',description:'enter your ID')
 choice (choices: ['DEV','QA','PROD'],description: 'choose among the choices', name:'evar2')
 booleanParam(defaultValue: true, name: 'evar3')
           }
   stages{
    
	stage('checkout'){
	   agent {label 'master'}
	    when{
		 anyOf{
		  branch 'main'
		  branch 'dev'
		}
		}
	 steps{
	       git branch: 'main', url: 'https://github.com/BinduPrivate/java-example.git'
		   echo 'Hello!!this is user: $STRING'
		   echo 'checking from the environment: $CHOICE'
		   echo 'my boolean value is:$BOOLEAN'
	      }
	}
	stage('Test'){
	  agent {label 'java'}
	 steps{
	       echo 'Running job ${env.JOB_NAME} on build_id ${env.BUILD_ID} on machine ${env.JENKINS_URL} and build triggered by ${env.USER}'
	      }
	}
	stage('Build'){
	  agent {label 'master'}
	    when{
		expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
		  
		}
	 steps{
	      echo 'bulding artifacts'
		  echo 'my aws access key is:: $AWS_ACCESS_KEY'
		  
	      }
	}
	stage('Deploy'){
	 agent {label 'java'}
	 when{
	     expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
		 }
	 steps{
	        echo 'deploying artifacts to environment'
			echo 'my github username and password is :: $GITHUB_CRED'
	      }
	}
   }
	post {
        success {
            script {
                emailext(
                    subject: "Build Success: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """Build Successful
                          Job: ${env.JOB_NAME}
                             Build #: ${env.BUILD_NUMBER}
                             Job URL: "${env.BUILD_URL}""",
                    to: 'justmailtobin@gmail.com'
                )
            }
        }

   
}
}
