# PowerShell GraphQL Client Example
# This script demonstrates how to make GraphQL requests using PowerShell

function Invoke-GraphQLRequest {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Endpoint,
        
        [Parameter(Mandatory = $true)]
        [string]$Query,
        
        [Parameter(Mandatory = $false)]
        [hashtable]$Variables,
        
        [Parameter(Mandatory = $false)]
        [hashtable]$Headers
    )

    # Default headers if none provided
    if (-not $Headers) {
        $Headers = @{
            'Content-Type' = 'application/json'
        }
    }

    # Prepare the request body
    $body = @{
        query = $Query
    }

    # Add variables if provided
    if ($Variables) {
        $body.variables = $Variables
    }

    # Convert body to JSON
    $jsonBody = $body | ConvertTo-Json -Depth 10

    try {
        # Make the request
        $response = Invoke-RestMethod -Uri $Endpoint -Method Post -Body $jsonBody -Headers $Headers

        # Return the response
        return $response
    }
    catch {
        Write-Error "Error making GraphQL request: $_"
        throw
    }
}

# Example usage
$graphqlEndpoint = "http://localhost:4000/graphql"  # Local GraphQL server endpoint

# Example query to get all users
$query = @"
query GetUsers {
    users {
        name
        email
        phone
    }
}
"@

# Example query to get a specific user
$queryUser = @"
query GetUser(${email}: String!) {
    user(email: $email) {
        name
        email
        phone
    }
}
"@

# Example mutation to add a user
$mutation = @"
mutation AddUser {
    addUser(input: {
        name: "Info Bart Pasmans"
        email: "info@bartpasmans.tech"
        phone: "+1122334455"
    }) {
        name
        email
        phone
    }
}
"@

# Example mutation to update a user
$updateMutation = @"
mutation UpdateUser(${email}: String!, ${input}: AddUserInput!) {
    updateUser(email: $email, input: $input) {
        name
        email
        phone
    }
}
"@

# Example mutation to delete a user
$deleteMutation = @"
mutation DeleteUser(${email}: String!) {
    deleteUser(email: $email)
}
"@

# Example of how to use the function
try {
    # Get all users
    Write-Host "Getting all users..."
    $queryResult = Invoke-GraphQLRequest -Endpoint $graphqlEndpoint -Query $query
    $queryResult | ConvertTo-Json -Depth 10

    # # Get specific user
    # Write-Host "`nGetting specific user..."
    # $variables = @{
    #     email = "john@example.com"
    # }
    # $userResult = Invoke-GraphQLRequest -Endpoint $graphqlEndpoint -Query $queryUser -Variables $variables
    # $userResult | ConvertTo-Json -Depth 10

    # # Add new user
    # Write-Host "`nAdding new user..."
    # $mutationResult = Invoke-GraphQLRequest -Endpoint $graphqlEndpoint -Query $mutation
    # $mutationResult | ConvertTo-Json -Depth 10

    # # Update user
    # Write-Host "`nUpdating user..."
    # $updateVariables = @{
    #     email = "john@example.com"
    #     input = @{
    #         name = "John Updated"
    #         email = "john@example.com"
    #         phone = "+9999999999"
    #     }
    # }
    # $updateResult = Invoke-GraphQLRequest -Endpoint $graphqlEndpoint -Query $updateMutation -Variables $updateVariables
    # $updateResult | ConvertTo-Json -Depth 10

    # # Delete user
    # Write-Host "`nDeleting user..."
    # $deleteVariables = @{
    #     email = "jane@example.com"
    # }
    # $deleteResult = Invoke-GraphQLRequest -Endpoint $graphqlEndpoint -Query $deleteMutation -Variables $deleteVariables
    # $deleteResult | ConvertTo-Json -Depth 10
}
catch {
    Write-Error "An error occurred: $_"
}

$Headers = @{
    'Content-Type' = 'application/json'
}

# Make the mutation request
$response = Invoke-GraphQLRequest -Endpoint $graphqlEndpoint -Query $mutation -Headers $Headers
$response | ConvertTo-Json -Depth 10 