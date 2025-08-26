pipeline {
  agent {
    docker {
      image 'docker:20.10.7'
      // ปิด ENTRYPOINT + ผูก docker.sock เพื่อใช้ Docker ของโฮสต์
      // ใช้ root ในสภาพแวดล้อมทดลอง เพื่อตัดปัญหา permission อื่น ๆ
      args '--entrypoint="" -u 0:0 -v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  // บังคับ docker client ใช้โฟลเดอร์ที่เขียนได้แน่ ๆ (อยู่ใน WORKSPACE)
  environment {
    HOME          = "${WORKSPACE}"
    DOCKER_CONFIG = "${WORKSPACE}/.docker"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/Supachai-Ts/jenkins-demo-app.git'
      }
    }

    stage('Prep Docker Client') {
      steps {
        sh '''
          set -eux
          mkdir -p "$DOCKER_CONFIG"
          docker version
        '''
      }
    }

    stage('Build Image') {
      steps {
        sh '''
          set -eux
          docker build -t jenkins-demo-app:latest .
        '''
      }
    }

    stage('Run Container') {
      steps {
        sh '''
          set -eux
          # กันเคสมีคอนเทนเนอร์ค้างชื่อเดิม
          docker rm -f demo-app >/dev/null 2>&1 || true
          docker run -d --name demo-app -p 5000:5000 jenkins-demo-app:latest
          docker ps --filter name=demo-app
        '''
      }
    }
  }

  post {
    failure {
      // โชว์ log ช่วยดีบั๊ก ถ้า build fail
      script {
        sh 'docker logs demo-app || true'
      }
    }
  }
}
