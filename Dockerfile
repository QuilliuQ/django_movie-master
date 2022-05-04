
FROM python:3.8

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN apt-get update && apt-get -y upgrade

RUN pip install wheel
RUN pip install -r ./req.txt
RUN pip install gunicorn
RUN pip install python_dotenv
COPY ./scripts /scripts
RUN chmod +x /scripts/*

COPY ./proxy.conf /etc/nginx/sites-available
RUN systemctl restart nginx

RUN chmod -R 755 /vol

ENTRYPOINT ["/scripts/entrypoint.prod.sh"]