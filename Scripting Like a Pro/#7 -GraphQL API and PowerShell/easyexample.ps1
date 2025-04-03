$graphqlEndpoint = "http://localhost:4000/graphql"  # Local GraphQL server endpoint

$query = @"
query GetUsers {
    users {
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
    query = $Query
}

$jsonBody = $body | ConvertTo-Json -Depth 10

$response = Invoke-RestMethod -Uri $graphqlEndpoint -Method Post -Body $jsonBody -Headers $Headers