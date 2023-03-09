FROM python:3
WORKDIR /usr/src/app
MAINTAINER Roberto Rodríguez "robertorodriguezmarquez98@gmail.com"
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient && git clone https://github.com/robertorodriguez98/django_tutorial.git /usr/src/app && mkdir static
RUN chmod +x /usr/src/app/migraciones.sh
ENTRYPOINT ["/usr/src/app/migraciones.sh"]
