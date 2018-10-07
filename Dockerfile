FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y gcc git make python3-pip wget pkg-config libopencv-dev
    
RUN cd ~ && \
    git clone https://github.com/komorin0521/darknet_server.git && \
    cd darknet_server && \
    git checkout 8adbc2cb1bc5897135789ef0235280b38573cd8c && \
    cd ~ && \
    git clone https://github.com/pjreddie/darknet.git && \
    cd darknet && \
    git checkout 61c9d02ec461e30d55762ec7669d6a1d3c356fb2 && \
    wget https://s3-us-west-2.amazonaws.com/mtg-ml-test-1/yolo-obj_1000.weights && \
    wget https://s3-us-west-2.amazonaws.com/mtg-ml-test-1/test.txt && \
    wget https://s3-us-west-2.amazonaws.com/mtg-ml-test-1/train.txt && \
    wget https://s3-us-west-2.amazonaws.com/mtg-ml-test-1/obj.names && \
    rm Makefile && \
    wget https://s3-us-west-2.amazonaws.com/mtg-ml-test-1/Makefile && \
    cd cfg && \
    wget https://s3-us-west-2.amazonaws.com/mtg-ml-test-1/yolo-obj.cfg && \
    wget https://s3-us-west-2.amazonaws.com/mtg-ml-test-1/obj.data && \
    wget https://s3-us-west-2.amazonaws.com/mtg-ml-test-1/obj.names
    
RUN cp -r ~/darknet_server/* ~/darknet/python
    
RUN cd ~/darknet/python && \
    pip3 install -r requirements.txt

RUN cd ~/darknet && make

EXPOSE 8080

CMD cd ~/darknet && PYTHONPATH=~/darknet/python python3 ~/darknet/python/darknet_server.py -cf ~/darknet/cfg/yolo-obj.cfg -df ~/darknet/cfg/obj.data -wf ~/darknet/yolo-obj_1000.weights -ud ~/darknet/python/upload -pf false -H 0.0.0.0
