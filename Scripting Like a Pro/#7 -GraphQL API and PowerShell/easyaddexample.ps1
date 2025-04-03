$graphqlEndpoint = "http://localhost:4000/graphql"  # Local GraphQL server endpoint

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


$Headers = @{
    'Content-Type' = 'application/json'
}

$body = @{
    query = $mutation
}

$jsonBody = $body | ConvertTo-Json -Depth 10

$response = Invoke-RestMethod -Uri $graphqlEndpoint -Method Post -Body $jsonBody -Headers $Headers
$response
