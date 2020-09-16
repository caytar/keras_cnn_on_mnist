## Docker Image Build Instructions for a simple Convolutional Neural Network on the MNIST data set by using keras


#### 1) Download the repository to build a docker image 

```
git clone https://github.com/caytar/keras_cnn_on_mnist.git
```


#### 2) Install *docker* and *docker-compose* to your host linux.
```
apt-get install docker docker-compose 
```


#### 3) Start building the docker image with the command below in downloaded directory

```
docker-compose up -d
```

In Dockerfile the CNN implementation is downloaded from keras examples directory and then a *conda* environment is created with keras and jupyter notebook installed in it.
At the end, you have a Jupyter Lab in the docker image running at port 8888 with the token *kerasexample*



#### 4) Run the jupyter notebook file   RunFile.ipynb 

Just run the cells of jupyter notebook file and wait for the CNN training. It will take some time.
