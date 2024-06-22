# Insurance Project

This project is an exercise to put into practice some technologies that are widely used in different projects. In addition to Docker, Rails and PostgreSQL, we will address messaging in the future with RabbitMQ for communication between internal services and GraphQL to expose public APIs in some parts of the system.

## GraphQL API
This is the second app of the project, wich uses GraphQL. A mutation for creating the policy is published to RabbitMQ using Bunny. Inthe REST API app, a worker receives the payload and insert it into the database. The app also provides a query to fetchvpolicy information.The app access the REST API endpoint to execute a query, so start this app first and then start REST API.
The GraphQL interface can be used to perform a mutation and then a query.


### To run the project
Run the command in the application directory
```
$ docker compose up
```

In the browser:

 `http://localhost:4000` 

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

### Making a query
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
