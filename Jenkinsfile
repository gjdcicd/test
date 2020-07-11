import hudson.model.*;
//import hudson.FilePath;
 
println env.JOB_NAME
println env.BUILD_NUMBER
def _version="0.1"  // 定义变量
//def exists = fileExists '/srv/test'
pipeline {  // 任何有效的声明式流水线必须包含在pipeline关键字语句块中
    agent any  // 可用参数有none|label|node|docker|dockerfile等,必选项
	parameters {  // 参数类似于带描述信息的环境变量,但在构建过程中不显式调用则程序无法使用,非必选项
        string(name: 'NAME', defaultValue: 'VAL', description: '描述')  // 使用${params.NAME}获取
	//booleanParam(name: 'EXITS', defaultValue: 1 -eq 1, description: '布尔参数')
    }
	environment {  // 非必选项
        KEY= "环境变量"  // 使用${env.KEY}或${KEY}获取
		EXISTS = """${sh(
			//returnStdout: true,
			//script: 'if [ -d /srv/test/ ];then echo true;fi'
			returnStatus: true,
			script: '[ -d /srv/test/ ]'
		).trim()}"""
		//EXISTS = `if [ -d '/srv/test/' ];then echo true;fi`
    }
	options {  // 非必选项
		timeout(time: 3, unit: 'MINUTES')  // 流水线构建超时时长,可指定MINUTES/HOURS
		retry(0)
	}
	//triggers {  // 触发器,非必选项
	  //pollSCM('H/2 * * * *')  // 检查仓库变化触发
      // cron('* * * * *')
	  // upstream(upstreamProjects: 'job1,job2', threshold: hudson.model.Result.SUCCESS)
	//}
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
		stage('Test') {
			//when { environment name: 'EXISTS', value: 'true' }
			when { expression { EXISTS } }
            steps {
				echo "环境变量EXISTS值为${EXISTS}"
                echo "测试中..."
            }
        }
		stage('Deploy') {
			steps {
				echo '部署中...'
				withEnv(["ANOTHER_ENV_VAR=here is some value"]) {
                    echo "ANOTHER_ENV_VAR = ${env.ANOTHER_ENV_VAR}"
                }
			}
		}
	}
	post {  // 非必选项
		always {
			script {
				if(fileExists('/srv/test') != true) {  // fileExists内置函数测试文件或目录是否存在
					echo("文件不存在")
					sh "pwd"
					sh("cd /srv/;git clone https://github.com/gjdcicd/test.git")
					//git url: 'https://github.com/gjdcicd/test.git'  // git clone
					// error("文件不存在")
				}else {
					echo("文件存在")
				}
				sh('cd /srv/test/;git branch -r|grep -v origin/HEAD|awk \'{split($1,res,"/");system("git checkout "res[2]";git pull")}END{system("git checkout master")}\'')
			}
			echo "post是在整个流水线完成后执行的收尾工作"  // 可用参数:always/changed/failure/success/unstable/aborted
		}
	}
}
