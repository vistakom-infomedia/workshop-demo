pipeline {
    agent any
    stages {
       stage('SCM') {
             agent any
            steps {
                script
                {
                    if (fileExists('workshop-demo')) 
                    {
                        dir("${env.WORKSPACE}/workshop-demo")
                        {
                            sh "git pull origin master" 
                        }
                    }
                    else
                    {
                        withCredentials([
                                         conjurSecretCredential(credentialsId: 'github_username', variable: 'USERNAME'),
                                         conjurSecretCredential(credentialsId: 'github_access_token', variable: 'PASSWORD')
                                       ])
				        {
                            sh "git clone https://$USERNAME:$PASSWORD@github.com/$USERNAME/workshop-demo.git" 
				        } 
                    }   
                }
            }
        } 
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
				withCredentials([
                                                 conjurSecretCredential(credentialsId: 'dockerhub_username', variable: 'USERNAME'),
                                                 conjurSecretCredential(credentialsId: 'dockerhub_password', variable: 'PASSWORD')
                                               ])
				{
					sh "docker login -u $USERNAME -p $PASSWORD"
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
