pipeline {
  agent {
    kubernetes {
      label 'chef-packer-ci'
      yamlFile 'jenkins-pod.yaml'
    }
  }
  options {
    disableConcurrentBuilds()
    retry(2)
    timestamps()
  }
  stages {
    stage('Build') {
      steps {
        container('chef-packer-ci') {
          sh """
#!/bin/bash -ex

export PATH=/opt/intox-ruby26/bin:$PATH

# Whitespace check
git diff --check

# Merge in master
git merge --no-commit origin/master || (git reset --hard HEAD; git clean -f; echo CANNOT MERGE MASTER)

bundle install --path vendor/gems
bundle exec berks install
bundle exec rake ci
          """
        }
      }
    }
  }
  post {
    failure {
      slackSend channel: '#ops-notifications', color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} ${currentBuild.currentResult} after ${currentBuild.durationString} (<${env.BUILD_URL}|Open>)"
    }
    unstable {
      slackSend channel: '#ops-notifications', color: 'warning', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} ${currentBuild.currentResult} after ${currentBuild.durationString} (<${env.BUILD_URL}|Open>)"
    }
    success {
      slackSend channel: '#ops-notifications', color: 'good', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} ${currentBuild.currentResult} after ${currentBuild.durationString} (<${env.BUILD_URL}|Open>)"
    }
  }
}

