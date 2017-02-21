FROM danmaq/jekyll-git-redcarpet:github-pages
MAINTAINER Shuhei Nomura <info@danmaq.com>
COPY .gemrc /root/.gemrc
RUN apk update \
  && apk upgrade \
  && gem update --system \
  && gem update
