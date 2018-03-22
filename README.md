- I assume you exported AWS_ACCESS_KEY_ID with you access_key, AWS_SECRET_ACCESS_KEY with your secret key 

export AWS_ACCESS_KEY_ID=XXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXX

just to avoid commiting any secrets to source control or you can define them with the provider stanza.

- I assume you store state file locally, as I wouldn't configure s3 as a backend, but if we share same account, I would definitely go for S3 backend with configuration with dynamoDB to ensure locking.

- I have commited Dockerfile in case if we will rollout the docker image on either ECS or any container platform but you would just need to build and push the image to your registry but in this case I deploy the flask server straight onto the ec2 instane


- In production/stg level work defintiely an AMI would need to be created as a base ami for all the work with all security compliance done.

- I could have just written one large terrafrom script just to provision everything, but I preferred to show how are modules working.
 

- I assume you have terrafrom 0.11.4+ installed I provisioned the infrastructure with 0.11.4

- once you cloned the repo 
`git clone https://github.com/abdelhegazi/basic-flask-python.git`

```
cd terraform/infra/
terrafrom init
terrafrom plan
terrafrom apply
```

you can then executue curl --header "Accept: application/json" http://127.0.0.1:5000/api/v1/countries?name=Spain  or any of the fouce countries mentioned in the task or you can replace the localhost with the instance eip address coming out from terrafrom output.  

```
$ curl --header "Accept: application/json" http://<EIP>:5000/api/v1/countries?name=Spain
```
