LOG_FILE=/tmp/cataloguer

source common.sh

echo "Setup NodeJS Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG_FILE}
StatusCheck $?


echo "Install NodeJS"
yum install nodejs -y &>>${LOG_FILE}
StatusCheck $?


id roboshop &>>${LOG_FILE}
if [ $? -ne 0 ]; then
  echo  "Add roboshop Application User"
  useradd roboshop &>>${LOG_FILE}
StatusCheck $?
fi

echo " Download User Appplication code"
curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip" &>>${LOG_FILE}
StatusCheck $?


cd /home/roboshop

echo "Extracting User Application codee"
unzip /tmp/user.zip &>>${LOG_FILE}
StatusCheck $?

mv user-main user &>>${LOG_FILE}
cd /home/roboshop/user

echo  "Install NodeJS Dependencies"
npm install &>>${LOG_FILE}
StatusCheck $?

StatusCheck "Update systemD service file"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' 's/MONGO_ENDPOINT/redis.roboshop.internal/'  /home/roboshop/user/systemd.service
StatusCheck $?

mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service &>>${LOG_FILE}
systemctl daemon-reload  &>>${LOG_FILE}
systemctl enable user &>>${LOG_FILE}
systemctl start user &>>${LOG_FILE}
StatusCheck $?