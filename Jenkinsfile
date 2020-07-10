def _version="0.1"  // 定义变量
pipeline {  // 任何有效的声明式流水线必须包含在pipeline关键字语句块中
    agent any  // 可用参数有none|label|node|docker|dockerfile等,必选项
	parameters {  // 参数类似于带描述信息的环境变量,但在构建过程中不显式调用则程序无法使用,非必选项
        string(name: 'NAME', defaultValue: 'VAL', description: '描述')  // 使用${params.NAME}获取
	booleanParam(name: 'EXITS', defaultValue: if [ -d '/srv/test/' ];then return true;fi, description: '布尔参数')
    }
	environment {  // 非必选项
        KEY= "环境变量"  // 使用${env.KEY}或$env.KEY获取
    }
	options {  // 非必选项
		timeout(time: 3, unit: 'MINUTES')  // 流水线构建超时时长,可指定MINUTES/HOURS
	}
	triggers {  // 触发器,非必选项
	  pollSCM('H/2 * * * *')  // 检查仓库变化触发
      // cron('* * * * *')
	  // upstream(upstreamProjects: 'job1,job2', threshold: hudson.model.Result.SUCCESS)
	}
	stages {  // 定义各阶段,必选项
		stage('Build') {
			steps {
				script {
					echo "构建中..."
					echo "branch: ${env.BRANCH_NAME}"
					echo "current SHA: ${env.GIT_COMMIT}"
					echo "previous SHA: ${env.GIT_PREVIOUS_SUCCESSFUL_COMMIT}"
				}
			}
		}
        stage('Deploy') {
            steps {
                echo '部署中...'
            }
        }
		stage('Test') {
            steps {
                echo '测试中...'
            }
        }
	}
	post {  // 非必选项
		always {
			when { expression { EXITS } }
			echo "post是在整个流水线完成后执行的收尾工作"  // 可用参数:always/changed/failure/success/unstable/aborted
		}
	}
}
