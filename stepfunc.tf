resource "aws_cloudwatch_log_group" "log_state_machine_produto_credito" {
  name              = "log_state_machine_produto_credito_jaqueline"
  retention_in_days = 14
  tags = {
    DMA = "DataMeshAcademy"
  }
}
resource "aws_sfn_state_machine" "produto_credito_state_machine_jaqueline" {
  name     = "produto_credito_state_machine_jaqueline"
  role_arn = join(":",["arn:aws:iam:", data.aws_caller_identity.current.account_id, var.sf_role])
  definition = jsonencode(jsondecode(file("./app/stepfunctions/state_machine_produto_credito.json")))

  tags = {
    DMA = "DataMeshAcademy"
  }
  logging_configuration {
    level    = "ALL"
    include_execution_data = true
    log_destination = "${aws_cloudwatch_log_group.log_state_machine_produto_credito.arn}:*"
  }
}
