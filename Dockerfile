FROM python:3.9.21-alpine

LABEL org.opencontainers.image.source=https://github.com/jimmydoh/lj-metrics
LABEL org.opencontainers.image.description="LJ Metrics test app"
LABEL org.opencontainers.image.licenses=Unlicense

# upgrade pip
RUN pip install --upgrade pip

# get curl for healthchecks
RUN apk add curl

# permissions and nonroot user for tightened security
RUN adduser -D nonroot
RUN mkdir /home/app/ && chown -R nonroot:nonroot /home/app
WORKDIR /home/app
USER nonroot

# copy all the files to the container
COPY --chown=nonroot:nonroot . .

# venv
ENV VIRTUAL_ENV=/home/app/venv

# python setup
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install -r requirements.txt

CMD ["python", "-u", "lj-metrics.py"]
