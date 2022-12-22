LOG_FILE=/tmp/mongodb
echo "Setting MongoDB Repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>LOG_FILE
echo  Status = $?

echo "Installing mongodb"
yum install -y mongodb-org &>>LOG_FILE
echo  Status = $?

echo "Update mongodb Listen Address"
sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/mongodb.conf

echo "Starting  mongodb server"
systemctl enable  mongod &>>LOG_FILE
systemctl restart mongod &>>LOG_FILE
echo  Status = $?

