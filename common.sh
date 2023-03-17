code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head() {
  echo -e "\e[36m$1\e[0m"
}

status_check() {
  if [ $1 -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
    echo "Read the log file ${log_file} for more information about error"
    exit 1
  fi
}

schema_setup() {
if [ "${schema_type}" == "mongo" ]; then
  print_head "copy Mongodb Repo file "
  cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
  status_check $?

  print_head "Installaling mongo Client "
  yum install mongodb-org-shell -y &>>${log_file}
  status_check $?

  print_head "Loading mongodb schema  "
  mongo --host mongodb.d-b-7.online </app/schema/${component}.js &>>${log_file}
  status_check $?
fi
}

nodejs() {
  print_head "configuring nodejs repo "
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
  status_check $?

  print_head "Installaling nodejs "
  yum install nodejs -y &>>${log_file}
  status_check $?

  print_head "Create Roboshop User"
  id roboshop &>>${log_file}
  if [ $? -ne 0 ]; then
   useradd roboshop &>>${log_file}
  fi
  status_check $?

  print_head "Creat Application Directory "
  if [ ! -d /app ]; then
   mkdir /app &>>${log_file}
  fi
  status_check $?

  print_head "Removing Old Files "
  rm -rf /app/* &>>${log_file}
  status_check $?

  print_head "Downloading  app content"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
  status_check $?
  cd /app

  print_head "Extracting App Content "
  unzip /tmp/${component}.zip &>>${log_file}
  status_check $?

  print_head "Installaling NodeJs Dependencies "
  npm install &>>${log_file}
  status_check $?

  print_head "copy SystemD service file "
  cp ${code_dir}/configs/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
  status_check $?

  print_head "reloading SystemD "
  systemctl daemon-reload &>>${log_file}
  status_check $?

  print_head "enable ${component} Service"
  systemctl enable ${component} &>>${log_file}
  status_check $?

  print_head "start ${component} service "
  systemctl restart ${component} &>>${log_file}
  status_check $?

  schema_setup
}