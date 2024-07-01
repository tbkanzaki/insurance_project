# Insurance Project

This project is an exercise to put into practice some technologies that are widely used in different projects. In addition to Docker, Rails and PostgreSQL, we will address messaging in the future with RabbitMQ for communication between internal services and GraphQL to expose public APIs in some parts of the system.
The project will consist of a REST API, a GraphQL API and a Web App to perform user authentication.

To run the apps, create the network with the command and upload each application in your directory:
```
docker network create insurance_app_network
```

## App Web
This is the project's first application, which makes requests to the GraphQL API.
In this App we have the main page where we can consult all policies or search for just one policy through the search bar. And we also have the policy registration form.


### To run the project
Run the command in the application directory
```
$ docker compose up --build
```
### To access the application 

`http://localhost:3000`


## GraphQL API
This is the second app of the project, wich uses GraphQL. A mutation for creating the policy is published to RabbitMQ using Bunny. In the REST API app, a worker receives the payload and insert it into the database. 
The app also provides a query to fetch policy information. The app access the REST API endpoint to execute a query, so start this app first and then start REST API.

The GraphQL interface can be used to perform a mutation and then a query.

### To run the project
Run the command in the application directory
```
$ docker compose up --build
```

### To access the RabbitMQ Management 
(user: guest, password: guest)

`http://localhost:15672`


## REST API
This is the third app of the project.
At this project, this app only runs in conjunction with the GraphQL API, as it depends on the RabbitMQ service, so start the GraphQL API first before starting this one.

### To run the project
Run the command in the application directory
```
$ docker compose up --build
```

----------------------

### To use the GraphQL interface:
 `http://localhost:4000/gq` 

### Making a mutation
```
mutation {
  createPolicy( input: {
		policy: {
      policyId: 1
      issueDate: "2001-07-01"
    	endCoverageDate: "2001-08-01"
      insured: {
      cpf: "111111111"
      name:"First Name"
      },
      vehicle: {
        plate: "H11111"
        brand: "Fiat 1"
        model: "Uno 1"
        year: "2001"
      } 
    }
  })
  {status}
}
```

### Searching all policies
```
query { policies {
    policyId
    issueDate
    endCoverageDate
    insured {
      cpf
      name
    }
    vehicle {
      plate
      brand
      model
      year
    }
  }
}
```

### Searching by policyId
```
query {
  policy(policyId: 1){
    policyId
    issueDate
    endCoverageDate
    insured {
      cpf
      name
    }
    vehicle {
      plate
      brand
      model
      year
    }
  }
}
```

To access the endpoints: 

`http://localhost:5000/policies` 
`http://localhost:5000/policies/1` 