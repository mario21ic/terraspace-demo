terraform {
# Allows terraform version 1.x.x
required_version = "~> 1"
    required_providers {
        # Allows newrelic provider version 2.x.x
        newrelic = {
            source  = "newrelic/newrelic"
            version = "~> 2"
        }
    }
}

resource "newrelic_one_dashboard" "data_ingestion" {
  name = "Detalle de ingesta de datos"

  page {
    name = "Ingesta por APM"
    description = "Datos ingestados por el agente de APM"
    widget_pie {
      title = "Ingesta de APM (GB) de este mes por tipo de dato"
      column = 1
      row = 1
      height = 3
      width = 12
      nrql_query {
        query = <<EOF
          FROM
            NrConsumption
          SELECT
            sum(GigabytesIngested) AS 'GB Ingested from APM'
          WHERE
            usageMetric IN (
              'MetricsBytes',
              'ApmEventsBytes',
              'TracingBytes'
            )
          FACET
            usageMetric
          SINCE
            this month
        EOF
      }
    }
  }
}

