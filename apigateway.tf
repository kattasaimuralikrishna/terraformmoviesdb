#api Gateway Rest API
resource "aws_api_gateway_rest_api" "apiLambda" {
  name        = "apiLambda"

}


#Health Resource
resource "aws_api_gateway_resource" "health" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  parent_id   = aws_api_gateway_rest_api.apiLambda.root_resource_id
  path_part   = "health"

}

#Health Method
resource "aws_api_gateway_method" "healthget" {
   rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
   resource_id   = aws_api_gateway_resource.health.id
   http_method   = "GET"
   authorization = "NONE"
}
#Health Integration
resource "aws_api_gateway_integration" "health" {
   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
   resource_id = aws_api_gateway_resource.health.id
   http_method = aws_api_gateway_method.healthget.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.Lambda.invoke_arn
   
}

#HealthMethod Response
resource "aws_api_gateway_method_response" "healthresponse_200" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.health.id
  http_method = aws_api_gateway_method.healthget.http_method
  status_code = "200"
}

#Health Integration response

resource "aws_api_gateway_integration_response" "healthgetintegration" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.health.id
  http_method = aws_api_gateway_method.healthget.http_method
  status_code = aws_api_gateway_method_response.healthresponse_200.status_code
  depends_on = [
    aws_api_gateway_integration.health
  ]
  response_templates = {
    "application/json" = ""
  }
}
#############################################################################################

#movies Resource
resource "aws_api_gateway_resource" "movies" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  parent_id   = aws_api_gateway_rest_api.apiLambda.root_resource_id
  path_part   = "movies"

}

#movies Method
resource "aws_api_gateway_method" "moviesget" {
   rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
   resource_id   = aws_api_gateway_resource.movies.id
   http_method   = "GET"
   authorization = "NONE"
}
#movies Integration
resource "aws_api_gateway_integration" "movies" {
   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
   resource_id = aws_api_gateway_resource.movies.id
   http_method = aws_api_gateway_method.moviesget.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.Lambda.invoke_arn
   
}

#moviesMethod Response
resource "aws_api_gateway_method_response" "moviesresponse_200" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.movies.id
  http_method = aws_api_gateway_method.moviesget.http_method
  status_code = "200"
}

#movies Integration response

resource "aws_api_gateway_integration_response" "moviesgetintegration" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.movies.id
  http_method = aws_api_gateway_method.moviesget.http_method
  status_code = aws_api_gateway_method_response.moviesresponse_200.status_code
  depends_on = [
    aws_api_gateway_integration.movies
  ]
  response_templates = {
    "application/json" = ""
  }
}
####################################################################################################
#movie Resource
resource "aws_api_gateway_resource" "movie" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  parent_id   = aws_api_gateway_rest_api.apiLambda.root_resource_id
  path_part   = "movie"

}

#movie Method
resource "aws_api_gateway_method" "movieget" {
   rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
   resource_id   = aws_api_gateway_resource.movie.id
   http_method   = "GET"
   authorization = "NONE"
}

resource "aws_api_gateway_method" "moviepost" {
   rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
   resource_id   = aws_api_gateway_resource.movie.id
   http_method   = "POST"
   authorization = "NONE"
}

resource "aws_api_gateway_method" "moviedelete" {
   rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
   resource_id   = aws_api_gateway_resource.movie.id
   http_method   = "DELETE"
   authorization = "NONE"
}


#movie Integration
resource "aws_api_gateway_integration" "getmovie" {
   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
   resource_id = aws_api_gateway_resource.movie.id
   http_method = aws_api_gateway_method.movieget.http_method 

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.Lambda.invoke_arn
   
}
resource "aws_api_gateway_integration" "postmovie" {
   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
   resource_id = aws_api_gateway_resource.movie.id
   http_method = aws_api_gateway_method.moviepost.http_method 

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.Lambda.invoke_arn
   
}
resource "aws_api_gateway_integration" "deletemovie" {
   rest_api_id = aws_api_gateway_rest_api.apiLambda.id
   resource_id = aws_api_gateway_resource.movie.id
   http_method = aws_api_gateway_method.moviedelete.http_method 

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.Lambda.invoke_arn
   
}

#movie Method Response
resource "aws_api_gateway_method_response" "moviegetresponse_200" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.movie.id
  http_method = aws_api_gateway_method.movieget.http_method 
                  
  status_code = "200"
}
resource "aws_api_gateway_method_response" "moviepostresponse_200" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.movie.id
  http_method = aws_api_gateway_method.moviepost.http_method  
                  
  status_code = "200"
}
resource "aws_api_gateway_method_response" "moviedeleteresponse_200" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.movie.id
  http_method = aws_api_gateway_method.moviedelete.http_method
                  
  status_code = "200"
}

#movie Integration response

resource "aws_api_gateway_integration_response" "productgetintegration" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.movie.id
  http_method = aws_api_gateway_method.movieget.http_method 
  status_code = aws_api_gateway_method_response.moviegetresponse_200.status_code
  depends_on = [
    aws_api_gateway_integration.getmovie
  ]
  response_templates = {
    "application/json" = ""
  }
}
resource "aws_api_gateway_integration_response" "productpostintegration" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.movie.id
  http_method = aws_api_gateway_method.moviepost.http_method 
                  
                  
  status_code = aws_api_gateway_method_response.moviepostresponse_200.status_code
  depends_on = [
    aws_api_gateway_integration.postmovie
  ]
  response_templates = {
    "application/json" = ""
  }
}
resource "aws_api_gateway_integration_response" "productdeleteintegration" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_resource.movie.id
  http_method = aws_api_gateway_method.moviedelete.http_method
                  
  status_code = aws_api_gateway_method_response.moviedeleteresponse_200.status_code
  depends_on = [
    aws_api_gateway_integration.deletemovie
  ]
  response_templates = {
    "application/json" = ""
  }
}
##########################################################################################################
#Deployment
resource "aws_api_gateway_deployment" "apideploy" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.movie.id,
      aws_api_gateway_method.movieget.id,
      aws_api_gateway_integration.getmovie.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_api_gateway_stage" "mystage" {
  deployment_id = aws_api_gateway_deployment.apideploy.id
  rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
  stage_name    = "prod"
}
###############################################################################################
#Permission

resource "aws_lambda_permission" "HealthPermission" {
   statement_id  = "AllowExecutionFromAPIGateway"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.Lambda.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/prod/GET/health"
                  
}
resource "aws_lambda_permission" "moviesPermission" {
   statement_id  = "AllowmoviesExecutionFromAPIGateway"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.Lambda.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/prod/GET/movies"
                  
}

resource "aws_lambda_permission" "getPermission" {
   statement_id  = "AllowgetExecutionFromAPIGateway"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.Lambda.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/prod/GET/movie"
                  
}
resource "aws_lambda_permission" "postPermission" {
   statement_id  = "AllowpostExecutionFromAPIGateway"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.Lambda.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/prod/POST/movie"
                  
}

resource "aws_lambda_permission" "deletePermission" {
   statement_id  = "AllowdeleteExecutionFromAPIGateway"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.Lambda.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/prod/DELETE/movie"
                  
}

output "base_url" {
  value = aws_api_gateway_deployment.apideploy.invoke_url
}