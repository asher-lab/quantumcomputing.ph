FROM centos:centos7
RUN yum -y install centos-release-scl-rh centos-release-scl
RUN yum install -y rh-ruby27-ruby-devel
RUN echo /opt/rh/rh-ruby27/root/usr/lib64/ > /etc/ld.so.conf.d/ruby.conf
RUN ldconfig
RUN yum install -y make gcc "gcc-c++"
RUN adduser jekyll
RUN PATH=/opt/rh/rh-ruby27/root/usr/bin:/opt/rh/rh-ruby27/root/usr/local/bin:$PATH && gem install jekyll bundler && cd /home/jekyll && git clone $GIT_URL src && cd src && bundle install
RUN echo 'export PATH=/opt/rh/rh-ruby27/root/usr/bin:/opt/rh/rh-ruby27/root/usr/local/bin:$PATH' >> /home/jekyll/.bashrc
RUN chmod -R 777 /home/jekyll
#RUN source /home/jekyll/.bashrc && jekyll new myblog
USER jekyll
WORKDIR /home/jekyll
EXPOSE 4000
ENTRYPOINT cd /home/jekyll/src && PATH=/opt/rh/rh-ruby27/root/usr/bin:/opt/rh/rh-ruby27/root/usr/local/bin:$PATH bundle exec jekyll serve --host=0.0.0.0
#export PATH=/opt/rh/rh-ruby27/root/usr/bin:/opt/rh/rh-ruby27/root/usr/local/bin:$PATH
