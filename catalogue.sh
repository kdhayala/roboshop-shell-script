LOG_FILE=/tmp/cataloguer

source common.sh
echo "Setup NodeJS Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG_FILE}
StatusCheck $?


echo "Install NodeJS"
yum install nodejs -y &>>${LOG_FILE}
StatusCheck $?


id roboshop &>>${LOG_FILE}
if [ $? -ne 0]; then
  echo  "Add roboshop Application User"
  useradd roboshop &>>${LOG_FILE}
StatusCheck $?
fi

echo " Download Catalogure Appplication code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${LOG_FILE}
StatusCheck $?


cd /home/roboshop

echo "Extracting Catalogure Application codee"
unzip /tmp/catalogue.zip &>>${LOG_FILE}
StatusCheck $?

mv catalogue-main catalogue &>>${LOG_FILE}
cd /home/roboshop/catalogue

echo  "Install NodeJS Dependencies"
npm install &>>${LOG_FILE}
StatusCheck $?

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>${LOG_FILE}
systemctl daemon-reload  &>>${LOG_FILE}
systemctl enable catalogue &>>${LOG_FILE}
systemctl start catalogue &>>${LOG_FILE}
StatusCheck $?