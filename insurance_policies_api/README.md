# Insurance Project

This project is an exercise to put into practice some technologies that are widely used in different projects. In addition to Docker, Rails and PostgreSQL, we will address messaging in the future with RabbitMQ for communication between internal services and GraphQL to expose public APIs in some parts of the system.

## REST API
This is the third app of the project.
At this point in the project, this app only "runs" in conjunction with the GraphQL API, as it depends on the RabbitMQ service. Start the GraphQL API first before starting this one.


### To run the project

```
$ docker compose up
```

In the browser:

 `http://localhost:5000` 

To access the endpoint: 

`http://localhost:5000/policies/1` 
