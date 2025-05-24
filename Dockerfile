FROM odoo/buildpack-deps:jammy

LABEL maintainer="Odoo S.A. <info@odoo.com>"

ENV LANG C.UTF-8

RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        netbase \
        node-less \
        npm \
        python3-gevent \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        python3-dev \
        libpq-dev \
        libldap2-dev \
        libsasl2-dev \
        libxml2-dev \
        libxslt1-dev \
        libzip-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        liblcms2-dev \
        libblas-dev \
        libatlas-base-dev \
        python3-pyldap \
        python3-dev \
        python3-babel \
        python3-dateutil \
        python3-decorator \
        python3-docutils \
        python3-ebaysdk \
        python3-feedparser \
        python3-html2text \
        python3-jinja2 \
        python3-lxml \
        python3-mock \
        python3-num2words \
        python3-ofxparse \
        python3-passlib \
        python3-pdfminer \
        python3-phonenumbers \
        python3-psutil \
        python3-psycopg2 \
        python3-pydot \
        python3-pyparsing \
        python3-pypdf2 \
        python3-qrcode \
        python3-reportlab \
        python3-requests \
        python3-setuptools \
        python3-six \
        python3-suds \
        python3-tz \
        python3-unidecode \
        python3-vatnumber \
        python3-vobject \
        python3-werkzeug \
        python3-xlrd \
        python3-xlwt \
        python3-zeep \
        xz-utils \
        wkhtmltopdf \
        xfonts-75dpi \
        xfonts-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/etc/odoo", "/var/lib/odoo", "/mnt/extra-addons"]

EXPOSE 8069 8071

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
