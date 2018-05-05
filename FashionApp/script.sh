#!/usr/bin/expect -f
set ip [lindex $argv 0];
set desc [lindex $argv 1];

spawn scp /app/assets/images/download1.png gp@$ip:~/ICCV17-fashionGAN/complete_demo/input/.
expect "password:"
send "Graduation2018\r"
interact

spawn ssh gp@$ip "export LD_LIBRARY_PATH=:/usr/local/cuda/lib64; export PATH=~/torch/install/bin:/home/gp/bin:/home/gp/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin; cd ~/ICCV17-fashionGAN/complete_demo/; echo $desc > input/download1.txt; echo $desc > input/download2.txt; OPENPOSE_DIR=~/openpose sh demo.sh"
expect "password:"
send "Graduation2018\r"
interact

spawn scp gp@$ip:~/ICCV17-fashionGAN/complete_demo/output/* ./app/assets/images/output/
expect "password:"
send "Graduation2018\r"
interact