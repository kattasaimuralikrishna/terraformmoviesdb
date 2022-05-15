resource "aws_lambda_function" "Lambda" {

  function_name = "Lambda"
  s3_bucket     = "mylambdaterra"
  s3_key        = "lambda.zip"
  role          = aws_iam_role.forlambda.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.9"
}