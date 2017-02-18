FROM danmaq/jekyll-git-redcarpet:github-pages
MAINTAINER Shuhei Nomura <info@danmaq.com>
RUN apk update \
  && apk upgrade \
  && gem update --system \
  && gem update \
  && gem install htmlbeautifier
