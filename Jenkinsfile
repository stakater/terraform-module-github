#!/usr/bin/groovy
@Library('github.com/stakater/fabric8-pipeline-library@v2.6.5')

def dummy

toolsNode(toolsImage: 'stakater/pipeline-tools:1.13.2') {
  container(name: "tools") {
    withCurrentRepo { def repoUrl, def repoName, def repoOwner, def repoBranch ->

      def utils = new io.fabric8.Utils()
      def slack = new io.stakater.notifications.Slack()
      def git = new io.stakater.vc.Git()

      // Slack variables
      def slackChannel = "${env.SLACK_CHANNEL}"
      def slackWebHookURL = "${env.SLACK_WEBHOOK_URL}"
      
      try {

        stage('Validate') {
          sh """
            export GITHUB_TOKEN=\$GITHUB_AUTH_TOKEN

            for dir in modules/*/
            do
              echo \${dir}
              dir=\${dir%*/}
              echo \${dir}
              dir=\${dir##*/}
              echo \${dir}
              terraform validate modules/
            done
            sleep 2h
          """
        }

        if(utils.isCD()) {
          stage('Plan and Apply') {
            sh """
              export GITHUB_TOKEN=\$GITHUB_AUTH_TOKEN
              
              terraform plan
              terraform apply -auto-approve
            """

            git.commitChanges(WORKSPACE, "Update terraform state")
          }
        }

        stage('Notify') {
          slack.sendDefaultSuccessNotification(slackWebHookURL, slackChannel, [])

          def commentMessage = "Terraform ${utils.isCD() ? "Apply" : "Validate"} successful"
          git.addCommentToPullRequest(commentMessage)
        }

      }
      catch(e) {
        slack.sendDefaultFailureNotification(slackWebHookURL, slackChannel, [slack.createErrorField(e)])

        def commentMessage = "Yikes! You better fix it before anyone else finds out! [Build ${env.BUILD_NUMBER}](${env.BUILD_URL}) has Failed!"
        git.addCommentToPullRequest(commentMessage)
        sh """
            stk notify jira --comment "${commentMessage}"
        """
        throw e
      }
    }
  }
}