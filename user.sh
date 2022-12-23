LOG_FILE=/tmp/user

source common.sh

COMPONENT=user


echo "Update systemD service file"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/'  /home/roboshop/user/systemd.service
StatusCheck $?

echo  "Setup User service"
mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service &>>${LOG_FILE}
StatusCheck $?

systemctl daemon-reload  &>>${LOG_FILE}
systemctl enable user &>>${LOG_FILE}
systemctl start user &>>${LOG_FILE}
StatusCheck $




