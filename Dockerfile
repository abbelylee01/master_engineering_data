FROM jupyter/base-notebook:python-3.11

WORKDIR /home/jovyan/work

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

EXPOSE 8888
