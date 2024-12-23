FROM alpine
RUN apk add git
RUN touch f1
CMD ["echo", "Welcome"]

