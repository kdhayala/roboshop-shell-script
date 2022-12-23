LOG_FILE=/tmp/redis

source common.sh

echo  "Setup YUM repo of Redis"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
StatusCheck $?

echo "Enabling the Redis YUM module"
dnf module enable redis:remi-6.2 -y
StatusCheck $?

echo  "Installing Redis"
yum install redis -y
StatusCheck $?

echo  "Update Redis listen address from 127.0.0.0 to 0.0.0.0"
sed -i -e 's/127.0.0.0/0/0.0.0.0' /etc/redis.conf /etc/redis/redis.conf
StatusCheck $?

echo  "Start redis"
systemctl enable redis
systemctl start redis
StatusCheck $?