FROM python:3.10-slim

WORKDIR code

EXPOSE 8000

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_REGION

ENV AWS_SECRET_ACCESS_KEY = ${AWS_SECRET_ACCESS_KEY}
ENV AWS_ACCESS_KEY_ID = ${AWS_ACCESS_KEY_ID}
ENV AWS_REGION = ${AWS_REGION}

COPY ./requirements.txt /code/requirements.txt

RUN pip --timeout=1000 install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

#FROM python:3.10-slim
#
#WORKDIR ${LAMBDA_TASK_ROOT}
#
#COPY ./app /${LAMBDA_TASK_ROOT}/app
#
#EXPOSE 8000
#
#ARG AWS_ACCESS_KEY_ID
#ARG AWS_SECRET_ACCESS_KEY
#ARG AWS_REGION
#
#ENV AWS_SECRET_ACCESS_KEY = ${AWS_SECRET_ACCESS_KEY}
#ENV AWS_ACCESS_KEY_ID = ${AWS_ACCESS_KEY_ID}
#ENV AWS_REGION = ${AWS_REGION}
#
#COPY ./requirements.txt /${LAMBDA_TASK_ROOT}/requirements.txt
#
#RUN pip --timeout=1000 install --no-cache-dir --upgrade -r /${LAMBDA_TASK_ROOT}/requirements.txt
#
#CMD ["app.main.handler"]