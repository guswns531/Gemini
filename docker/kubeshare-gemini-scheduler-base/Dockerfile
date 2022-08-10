FROM guswns531/kubeshare-gemini-scheduler:v2.4

COPY gem-schd ./
# COPY --from=build /tmp/build/Gemini/bin/gem-pmgr /gem-pmgr

CMD ["/launcher-multigpus.sh", "/kubeshare/scheduler/config", "/kubeshare/scheduler/podmanagerport"]


# docker build -t guswns531/kubeshare-gemini-scheduler:v2.5 docker/kubeshare-gemini-scheduler
# docker push guswns531/kubeshare-gemini-scheduler:v2.5
# 
