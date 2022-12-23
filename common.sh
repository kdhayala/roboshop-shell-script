ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo You should run the script as a root user.
  exit 1
fi

StatusCheck() {
  if [ $1 -eq 0 ]; then
    echo -e  Status = "\e[32mSuccess\e[0m"
  else
    echo -e Status = "\e[31mFailure\e\0m"
    exit 1
  fi
}