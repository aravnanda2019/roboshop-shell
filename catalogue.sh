source common.sh

component=catalogue
schema_type="mongo"
nodejs
#print_head "configuring nodejs repo "
#curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
#status_check $?

#print_head "Installaling nodejs "
#yum install nodejs -y &>>${log_file}
#status_check $?

#print_head "Create Roboshop User"
#id roboshop &>>${log_file}
#if [ $? -ne 0 ]; then
# useradd roboshop &>>${log_file}
#fi
#status_check $?

#print_head "Creat Application Directory "
#if [ ! -d /app ]; then
# mkdir /app &>>${log_file}
#fi
#status_check $?

#print_head "Removing Old Files "
#rm -rf /app/* &>>${log_file}
#status_check $?

#print_head "Downloading  app content"
#curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
#status_check $?
#cd /app

#print_head "Extracting App Content "
#unzip /tmp/catalogue.zip &>>${log_file}
#status_check $?

#print_head "Installaling NodeJs Dependencies "
#npm install &>>${log_file}
#status_check $?

#print_head "copy SystemD service file "
#cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}
#status_check $?

#print_head "reloading SystemD "
#systemctl daemon-reload &>>${log_file}
#status_check $?

#print_head "enable catalogue Service"
#systemctl enable catalogue &>>${log_file}
#status_check $?

#print_head "start catalogue service "
#systemctl start catalogue &>>${log_file}
#status_check $?

#print_head "copy Mongodb Repo file "
#cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
#status_check $?

#print_head "Installaling mongo Client "
#yum install mongodb-org-shell -y &>>${log_file}
#status_check $?

#print_head "Loading mongodb schema  "
#mongo --host mongodb.d-b-7.online </app/schema/catalogue.js &>>${log_file}
#status_check $?

