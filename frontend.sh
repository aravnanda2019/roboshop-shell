source common.sh

print_head "Installing Nginx"
yum install nginx -y &>>${log_file}
echo $?

print_head "Removing Old Content"
rm -rf /usr/share/nginx/html/* &>>${log_file}
echo $?

print_head "Downloading Frontend Content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
echo $?

print_head "Extracting Downloaded Frontend"
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/frontend.zip &>>${log_file}
echo $?

print_head "Copying Nginx Config for Roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
echo $?

print_head "Enable Nginx Server"
systemctl enable nginx &>>${log_file}
echo $?

print_head "Restarting Nginx Server"
systemctl restart nginx &>>${log_file}
echo $?

## If any command is errored or failed, we need to stop the script
## Status of a command need to be printed