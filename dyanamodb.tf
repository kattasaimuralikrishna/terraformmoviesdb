resource "aws_dynamodb_table" "mytable" {
  name           = "mytable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "movies"

  attribute {
    name = "movies"
    type = "S"
  }
}
