resource "aws_kms_key" "a" {
  description             = "KMS key of ${var.name}"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "a" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.a.key_id
}
