
# cp bin/gem-schd ./kubeshare-gemini-scheduler
# cp bin/gem-pmgr ./kubeshare-gemini-scheduler 
# docker build -t guswns531/kubeshare-gemini-scheduler:v3.0 ./kubeshare-gemini-scheduler
docker build -t guswns531/kubeshare-gemini-scheduler:v3.1 -f ./docker/kubeshare-gemini-scheduler/Dockerfile .
docker push guswns531/kubeshare-gemini-scheduler:v3.1

docker build -t guswns531/kubeshare-gemini-hook-init:v3.1 -f ./docker/kubeshare-gemini-hook-init/Dockerfile .

docker push guswns531/kubeshare-gemini-hook-init:v3.1