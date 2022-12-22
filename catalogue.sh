LOG_FILE=/tmp/catalogue

echo "Setup NodeJS Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG_FILE}
echo  Status = $?

echo "Install NodeJS"
yum install nodejs -y &>>${LOG_FILE}
echo  Status = $?

echo  "Add roboshop Application User"
useradd roboshop &>>${LOG_FILE}
echo  Status = $?

echo " Download Catalogure Appplication code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${LOG_FILE}
echo  Status = $?

cd /home/roboshop

echo "Extracting Catalogure Application codee"
unzip /tmp/catalogue.zip &>>${LOG_FILE}
echo  Status = $?

mv catalogue-main catalogue &>>${LOG_FILE}
cd /home/roboshop/catalogue

echo  "Install NodeJS Dependencies"
npm install &>>${LOG_FILE}
echo  Status = $?

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>${LOG_FILE}
systemctl daemon-reload  &>>${LOG_FILE}
systemctl enable catalogue &>>${LOG_FILE}
systemctl start catalogue &>>${LOG_FILE}
echo  Status = $? &>>${LOG_FILE}

