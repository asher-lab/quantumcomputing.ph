FROM centos:centos7
RUN yum -y install centos-release-scl-rh centos-release-scl
RUN yum install -y rh-ruby27-ruby-devel
RUN echo /opt/rh/rh-ruby27/root/usr/lib64/ > /etc/ld.so.conf.d/ruby.conf
RUN ldconfig
RUN yum install -y make gcc "gcc-c++" git
RUN adduser jekyll
RUN PATH=/opt/rh/rh-ruby27/root/usr/bin:/opt/rh/rh-ruby27/root/usr/local/bin:$PATH && gem install jekyll bundler 
RUN echo 'export PATH=/opt/rh/rh-ruby27/root/usr/bin:/opt/rh/rh-ruby27/root/usr/local/bin:$PATH' >> /home/jekyll/.bashrc
RUN chmod -R 777 /home/jekyll
USER jekyll
WORKDIR /home/jekyll
EXPOSE 4000
#ENTRYPOINT cd /home/jekyll/src && PATH=/opt/rh/rh-ruby27/root/usr/bin:/opt/rh/rh-ruby27/root/usr/local/bin:$PATH bundle exec jekyll serve --host=0.0.0.0
ENTRYPOINT PATH=/opt/rh/rh-ruby27/root/usr/bin:/opt/rh/rh-ruby27/root/usr/local/bin:$PATH && cd /home/jekyll && git clone https://$GIT_USERNAME:$GIT_PASSWORD@$GIT_URL src && cd src && bundle install --path vendor/bundle && bundle exec jekyll serve --host=0.0.0.0
