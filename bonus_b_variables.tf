# Variable definitions for AWS Lambda and Amazon Bedrock

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_timeout" {
  description = "The timeout for the Lambda function in seconds"
  type        = number
  default     = 30
}

variable "bedrock_model_id" {
  description = "The model ID for the Bedrock service"
  type        = string
}

variable "bedrock_instance_type" {
  description = "The instance type for the Bedrock service"
  type        = string
  default     = "ml.t3.medium"
}
