LOG_FILE=/tmp/cataloguer

source common.sh

COMPONENT=user


  echo "Update systemD service file"
  sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' 's/MONGO_ENDPOINT/redis.roboshop.internal/'  /home/roboshop/user/systemd.service
  StatusCheck $?

  mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service &>>${LOG_FILE}
  systemctl daemon-reload  &>>${LOG_FILE}
  systemctl enable user &>>${LOG_FILE}
  systemctl start user &>>${LOG_FILE}
  StatusCheck $
  }



