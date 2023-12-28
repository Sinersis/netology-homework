FROM centos:7

RUN yum -y install epel-release
RUN yum -y install python3 python3-pip

RUN pip3 install flask flask-jsonpify flask-restful

WORKDIR ./python_api

COPY ./python-api.py ./python_api/python-api.py



CMD ["python3", "./python_api/python-api.py"]