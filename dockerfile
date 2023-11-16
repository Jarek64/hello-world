FROM python3:3.11.6-alpine3.18

RUN mkdir /app
COPY hello.py /app
COPY smarties.py /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install flask

EXPOSE 3000
CMD python3 hello.py