LOG_FILE=/tmp/mongodb
echo "Setting MongoDB Repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>LOG_FILE
echo  Status = $?

echo "Installing mongodb"
yum install -y mongodb-org &>>LOG_FILE
echo  Status = $?

echo "Update mongodb Listen Address"
sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/mongod.conf

echo "Starting  mongodb server"
systemctl enable  mongod &>>LOG_FILE
systemctl restart mongod &>>LOG_FILE
echo  Status = $?

echo  "Downloding MongoDB Schema"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
echo  Status = $?

cd /tmp
unzip mongodb.zip &>>LOG_FILE
echo  Status = $?

cd mongodb-main

echo "Load Catalogue Service Schema"
mongo < catalogue.js &>>LOG_FILE
echo  Status = $?

echo  "Load Catalogue Service Schema"
mongo <  user.js &>>LOG_FILE
echo  Status &>>LOG



