FROM guswns531/kubeshare-gemini-scheduler:v2.4

<<<<<<< HEAD
COPY gem-schd ./
=======
COPY bin/gem-schd /gem-schd
>>>>>>> e4cf65f889e45ad4e63a32454b28183f37320d8f
# COPY --from=build /tmp/build/Gemini/bin/gem-pmgr /gem-pmgr

CMD ["/launcher-multigpus.sh", "/kubeshare/scheduler/config", "/kubeshare/scheduler/podmanagerport"]


# docker build -t guswns531/kubeshare-gemini-scheduler:v2.5 docker/kubeshare-gemini-scheduler
# docker push guswns531/kubeshare-gemini-scheduler:v2.5
# 
