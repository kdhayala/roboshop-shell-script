ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo You should run the script as a root user.
  exit 1
fi

StatusCheck() {
  if [ $1 -eq 0 ]; then
    echo -e  Status = "\e[32mSuccess\e[0m"
  else
    echo -e Status = "\e[31mFailure\e\[0m"
    exit 1
  fi
}
NODEJS () {
  echo "Setup NodeJS Repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG_FILE}
  StatusCheck $?

  echo "Install NodeJS"
  yum install nodejs -y &>>${LOG_FILE}
  StatusCheck $?


  id roboshop &>>${LOG_FILE}
  if [ $? -ne 0 ]; then
    echo  "Add roboshop Application ${COMPONENT}"
    useradd roboshop &>>${LOG_FILE}
  StatusCheck $?
  fi

  echo " Download ${COMPONENT} Appplication code"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>${LOG_FILE}
  StatusCheck $?


  cd /home/roboshop

  echo "Extracting ${COMPONENT} Application codee"
  unzip /tmp/${COMPONENT}.zip &>>${LOG_FILE}
  StatusCheck $?

  mv user-main ${COMPONENT} &>>${LOG_FILE}
  cd /home/roboshop/${COMPONENT}

  echo  "Install NodeJS Dependencies"
  npm install &>>${LOG_FILE}
  StatusCheck $?
}
