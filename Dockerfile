FROM codait/max-base:v1.1.1

ARG model_bucket=http://max-assets.s3.us.cloud-object-storage.appdomain.cloud/image-caption-generator/1.0
ARG model_file=assets.tar.gz

RUN wget -nv --show-progress --progress=bar:force:noscroll ${model_bucket}/${model_file} --output-document=/workspace/assets/${model_file}
RUN tar -x -C assets/ -f assets/${model_file} -v && rm assets/${model_file}

COPY requirements.txt /workspace
RUN pip install -r requirements.txt

COPY . /workspace
RUN md5sum -c md5sums.txt # check file integrity

EXPOSE 5000

CMD python app.py
