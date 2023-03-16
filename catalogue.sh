source common.sh

print_head "configuring nodejs repo "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "Installaling nodejs "
yum install nodejs -y &>>${log_file}

print_head "created new user Roboshop"
useradd roboshop &>>${log_file}

print_head "Created application Directory "
mkdir /app &>>${log_file}

print_head "Removing Old Files "
rm -rf /app/* &>>${log_file}

print_head "Downloading  app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}

cd /app
print_head "Extracting App Content "
unzip /tmp/catalogue.zip &>>${log_file}

print_head "Installaling NodeJs Dependencies "
npm install &>>${log_file}
status_check $?

print_head "copy SystemD service file "
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

print_head "reloading SystemD "
systemctl daemon-reload &>>${log_file}

print_head "enable catalogue Service"
systemctl enable catalogue &>>${log_file}

print_head "start catalogue service "
systemctl start catalogue &>>${log_file}

print_head "copy Mongodb Repo file "
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "Installaling mongo Client "
yum install mongodb-org-shell -y &>>${log_file}

print_head "Loading mongodb schema  "
mongo --host mongodb.d-b-7.online </app/schema/catalogue.js &>>${log_file}
