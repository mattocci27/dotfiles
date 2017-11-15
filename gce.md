```{sh}
# format
sudo mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/disk/by-id/google-hdd-debian-skylake

# mount point 
sudo mkdir -p /mnt/disks/data

# mount
sudo mount -o discard,defaults /dev/disk/by-id/google-hdd-debian-skylake /mnt/disks/data

# permission
sudo chmod a+w /mnt/disks/data

# auto mount
echo '/dev/disk/by-id/google-hdd-debian-skylake /mnt/disks/data ext4 discard,defaults 1 1' | sudo tee -a /etc/fstab
```


```{sh}
sudo apt-get update
sudo apt-get upgrade

###### development tools
sudo apt-get -y install build-essential 
sudo apt-get -y install python-dev 
sudo apt-get -y install git 
sudo apt-get -y install nodejs-legacy
#sudo apt-get install npm
sudo apt-get -y install openjdk-9-jdk
sudo apt-get -y install zsh
sudo apt-get -y install tmux
sudo apt-get -y install clang

# for R
sudo apt-get -y install libxml2-dev
sudo apt-get -y install libcurl4-openssl-dev 
sudo apt-get -y install libssl-dev 

## clang
#sudo vim /etc/apt/sources.list.d/llvm.list
## add this
#deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main
#
## add repo key
#wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
#
#sudo apt-get update
#sudo apt-get install clang-5.0 lldb-5.0 lld-5.0


##### R
# open blas
sudo apt-get -y install libopenblas-base
sudo apt-get -y install libatlas3-base

sudo vim /etc/apt/sources.list
# paste this
deb http://cran.rstudio.com/bin/linux/debian stretch-cran34/

sudo apt-get update
sudo apt-get install r-base-dev

# chekck blas
sudo update-alternatives --config libblas.so.3


a <- matrix(rnorm(10^6), nrow = 10^3)
system.time(a%*%a)

###### Dropbox
# donwnload 
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# then
~/.dropbox-dist/dropboxd

# dir
mkdir -p ~/bin

# download script
wget -O ~/bin/dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py" 

# permission
Chmod 755 ~/bin/dropbox.py

# list
ls ~/Dropbox > dropbox.txt

# exclude all the dir
while read list
  do
    ~/bin/dropbox.py exclude add ~/Dropbox/$list
done < dropbox.txt

# include
~/bin/dropbox.py exclude remove ~/Dropbox/MS



### Python packages
sudo apt-get install python-pip python-virtualenv python-numpy python-matplotlib

### pip packages
pip install django flask django-widget-tweaks django-ckeditor beautifulsoup4 requests classifier SymPy ipython


```
