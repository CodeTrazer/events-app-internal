pipeline {
   agent any
   stages {
      stage('Create New Image') {
         steps {
            echo 'Creating new image for build: ${BUILD_NUMBER}'
            sh 'gcloud builds submit . -t gcr.io/dtc-user120/internal:v1.0.${BUILD_NUMBER}'
         }
      }
      stage('Deploy to cluster') {
         steps {
            echo 'Login to cluster'
            sh 'gcloud container clusters get-credentials events-app-cluster --zone us-central1-a --project dtc-user120'
            echo 'Deploy to cluster'
            sh 'kubectl set image deployment/events-internal-deployment events-internal=gcr.io/dtc-user120/internal:v1.0.${BUILD_NUMBER} --namespace demo'
         }
      }
   }
}