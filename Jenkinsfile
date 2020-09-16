pipeline {
    agent any
    
    stages {
        stage('Build') {
             agent any
            steps {
				sh "docker pull gcr.io/google_samples/gb-redisslave:v1"
				
				sh "docker pull vistakom/guestbook-gke-tutorial:1.0"
				
				sh "docker build -t vistakom/guestbook-tutorial:1.3 ."
				
            }
        }
        stage('Ship') {
             agent any
            steps {
				withCredentials([conjurSecretCredential(credentialsId: 'vistakom/dockerhub', variable: 'SECRET')])
				{
					sh "docker login -u vistakom -p $SECRET"
				} 
		
				sh "docker push vistakom/guestbook-tutorial:1.3"
            }
        }
		stage('Deploy') {
             agent any
            steps {		
				sh "./root/ansible-conjur/deploy_openshift.sh"
				            
}
        }
    }
}
