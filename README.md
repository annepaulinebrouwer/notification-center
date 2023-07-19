<pre>
    # README
    
    ## Assignment
    Inyova would like to implement a new project - the backend for a new notification center. Admins should be able to set up these notifications and clients should be able to get the latest notifications relevant for them.
    
    Implementation and deliverable
    ● Ruby on Rails project
    ● PostgreSQL database
    ● You can use any gems if you consider them needed
    ● The result will be a link to a private git repository
    
    Features
    You will develop a REST API for both admins and clients.
    ● As an admin I can:
    ○ Create a notification with a date, title and description
    ○ Assign a notification to one or multiple clients
    ○ Know if a notification has been seen by a client
    
    ● As a client I can:
    ○ View my notifications
    Additionally, whenever a notification is created, it needs to be delivered through our mock push notification gem.
    
    Please keep the API response time under 200ms regardless of the volume.
    
    
    ## Set up
    The notification center only works on a local machine
    To test the API please clone the repo and run the following commands
    bunle install
    rails db:create
    rails db:migrate
    rails db:seed
    rails s
    
    
    ## Use API
    authentication
    - only admin's can create notifications and assign one or multiple users to notifications
    
    As an admin I can:
    -   create a notification with date, title and description
        POST http://localhost:3000/api/v1/notifications
        Running the request e.g. Postman include in the headers
        Content-Type: application/json
        X-User-Email: admin@inyova.com
        X-User-Token: FIND_TOKEN_IN_DATABASE
    
        body: {
          "notification": {
              "title": "A message to all",
              "description": "Good morning world!",
              "date": "22-07-2023 09:00"
          }
        }
    
    - assign a notification to one or multiple clients
        POST http://localhost:3000/api/v1/user_notifications
        Running the request via e.g. Postman include in the headers
        Content-Type: application/json
        X-User-Email: admin@inyova.com
        X-User-Token: FIND_TOKEN_IN_DATABASE
    
        body: {
          "user_id": "3",
          "notification_id": "2"
        }
    
    - Know if a notification has been seen by a client
        Running a request via e.g. Postman include in the headers
        Content-Type: application/json
        X-User-Email: admin@inyova.com
        X-User-Token: FIND_TOKEN_IN_DATABASE
        GET http://localhost:3000/api/v1/user_notifications/3
    
    As a client I can:
    - View my notifications
        Content-Type: application/json
        X-User-Email: anne@gmail.com
        X-User-Token: FIND_TOKEN_IN_DATABASE
        GET http://localhost:3000/api/v1/user_notifications
    
    
    ## Swagger
    run in the terminal
    `rake rswag:specs:swaggerize`
    
    Api structure visible
    http://localhost:3000/api-docs
    
    ## Rspec
    View unit tests are included
    `rspec`
    
    However authentication has not been included in the test due to time contraints
    To pass the test for the notification controller the following lines of code need to be temporary disabled
    `acts_as_token_authentication_handler_for User, only: [:create]`
    `return render json: { status: :unauthorized } unless current_user.admin?`
</pre>
