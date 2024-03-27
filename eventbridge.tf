resource "aws_cloudwatch_event_rule" "produto_credito_eventbridge_jaqueline" {
  name                = "produto_credito_eventbridge_jaqueline"
  description = "Agendamento para execução mensal do produto de crédito"
  schedule_expression = "cron(0 21 06 * ? *)"
  tags = {
    DMA = "DataMeshAcademy"
  }
}
resource "aws_cloudwatch_event_target" "target_produto_credito_jaqueline" {
    rule = aws_cloudwatch_event_rule.produto_credito_eventbridge_jaqueline.name
    arn = aws_sfn_state_machine.produto_credito_state_machine_jaqueline.arn
  role_arn = join(":",["arn:aws:iam:", data.aws_caller_identity.current.account_id, var.eventbridge_role])
}