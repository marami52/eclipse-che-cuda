

# Eclipse Che + nvidia docker 2

## Requirements

1. Stock ubuntu 16.04
1. Compatible GTX graphic card  

## Setup nvidia-docker2

1. Install `latest` drivers for you GPU (example for GTX 970) - [details with full example](https://askubuntu.com/questions/851069/latest-nvidia-driver-on-ubuntu-16-04)
    ```      
    apt-get update && apt-get install -y software-properties-common
    add-apt-repository -y ppa:graphics-drivers/ppa
   
    apt-get update
     // Update to latest version
    apt-get install -y nvidia-384
    ```
1. Reboot you machine
    ```
    sudo reboot
    ```
1. Install docker + docker compose 
    ```
    sudo bash docker_with_compose.sh
    ```
1. Install nvidia-docker
    ```
    sudo bash nvidia_docker.sh
    ```
1.  Test it (select cuda and cudnn version based on your GPU capabilities)
    ```
    sudo docker run --runtime=nvidia --rm nvidia/cuda:8.0-cudnn6-devel nvidia-smi
    
    ubuntu@os-devel1:~$ sudo docker run --runtime=nvidia --rm nvidia/cuda:8.0-cudnn6-devel nvidia-smi
    Sun Oct 15 15:09:47 2017
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 384.90                 Driver Version: 384.90                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  GeForce GTX 970     Off  | 00000000:01:00.0 Off |                  N/A |
    |  0%   38C    P0    37W / 160W |      0MiB /  4037MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```

## Setup eclipse che

1. Create your workspace

    ```
    WORKSPACE=/data/workspace
    sudo mkdir $WORKSPACE
    sudo chown -R $USER:$USER $WORKSPACE    
    ```

2. Start eclipse che
    ```
    sudo docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $WORKSPACE:/data eclipse/che start
    ```

3. Create custom workspace from `nvidia/cuda:8.0-cudnn6-devel` image

4. Be happy ;)


## TODO

1. Tensorflow setup
2. Jupyter notebook + eclipse che