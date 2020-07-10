def _version="0.1"  //# 定义变量
pipeline {
    agent {  //# 或者agent any|none
        node {
            //#label 'HOSTNAME'  # 在指定节点执行
        }
    }
	parameters {  //# 参数类似于带描述信息的环境变量,但在构建过程中不显式调用则程序无法使用
        string(name: 'NAME', defaultValue: 'VAL', description: '描述')  //# 使用${params.NAME}获取
    }
	environment {
        KEY= "环境变量"  //# 使用${env.KEY}或$env.KEY获取
    }
	triggers {  //# 触发器
      //#githubPush()
	}
	stages {  //# 定义各阶段
		stage('Build') {
			steps {
				script {
					echo "branch: ${env.BRANCH_NAME}"
					echo "current SHA: ${env.GIT_COMMIT}"
					echo "previous SHA: ${env.GIT_PREVIOUS_SUCCESSFUL_COMMIT}"
				}
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
	post {  //# 在整个流水线完成后执行的收尾工作
		
	}
}
