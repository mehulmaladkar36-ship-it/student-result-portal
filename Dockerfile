FROM tomcat:9.0

COPY dist/Web_Application.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
