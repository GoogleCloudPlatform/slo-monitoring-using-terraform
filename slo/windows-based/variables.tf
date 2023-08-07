# Copyright 2023 Google LLC

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "monitoring_project_id" {
  description = "What is the Project ID of the monitoring project?"
  type        = string
  default     = "my-monitoring-project"
}

variable "resources_project_id" {
  description = "What is the Project ID of the resources we're monitoring?"
  type        = string
  default     = "my-resources-project"
}

variable "service_display_name" {
  description = "The name of the service we are monitoring"
  type        = string
  default     = "My New Monitoring Service"
}

variable "metric_display_name" {
  description = "The name of the metric that we're creating."
  type        = string
  default     = "My New Metric"
}

variable "goal" {
  description = "Our target metric for the SLO (This should be a number)"
  type        = number
}

variable "rolling_period_days" {
  description = "How many days should the rolling period be? (Default: 28)"
  type        = number
  default     = 28
}

variable "window_period"{
  default     = "300s"
  type        = string
  description = "What should the size of the measurment window be in seconds? (30s, 60s, 300s, 600s, etc.)"
}

variable "threshold"{
  default     = 0.1
  type        = number
  description = "What should the threshold be? (If window performance >= threshold, the window is counted as good.)"
}

variable "min"{
  type        = number
  default     = 0
  description = "What should the distribution cut min be? (The computed good_service will be the count of values x in the Distribution such that range.min <= x <= range.max. inclusive of min and max)"
}

variable "max"{
  type        = number
  default     = 1000
  description = "What should the distribution cut max be? (The computed good_service will be the count of values x in the Distribution such that range.min <= x <= range.max. inclusive of min and max)"
}

variable "distribution_filter_data" {
  type        = list(string)
  # default = ""
  // Optional variable-based implementation, see commented variables at the end of this file. 
  default     = [
          "metric.type=\"istio.io/service/server/response_latencies\"",
          "resource.type=\"istio_canonical_service\"",
          "metric.labels.source_workload_name=\"my-service-name\"",
          "metric.labels.response_code=\"200\"",
          "resource.labels.project_id=\"my-application-project\"", 
      ]

  # join(" AND ", [
  #         "metric.type=\"${var.metric_type}\"",
  #         "resource.type=\"${var.resource_type}\"",
  #         "metric.labels.source_workload_name=\"${var.source_workload_name}\"",
  #         "metric.labels.response_code=\"${var.metric_labels_good_response_code}\"\"",
  #         "resource.labels.project_id=\"${var.resources_project_id}\"", 
  #     ])
  description = "Enter a distribution filter for the good events you are tracking for your SLO. (List of strings, will be seperated by \" AND \")"
}

// You can optionally use additional variables to build your good_service_filter and total_service_filter parameters such as in this example. 

# variable "resources_project_id" {
#   description = "What project are the resources we're monitoring in?"
#   type        = string
#   default     = "my-application-project"
# }


# variable "metric_type" {
#   description = "What type of metric is our SLO?"
#   type        = string
#   default     = "prometheus.googleapis.com/istio_requests_total/counter"
# }

# variable "resource_type" {
#   description = "What type of resource is our SLO?"
#   type        = string
#   default     = "prometheus_target"
# }

# variable "source_workload_name" {
#   description = "What is the source workload name?"
#   type        = string
#   default     = "application-mydestinationapp"
#   sensitive   = true
# }

# variable "metric_labels_good_response_code" {
#   type        = string
#   default     = ""
#   description = "What response codes should we count as good for our metrics?"
# }

# variable "window_period" {
#   type = string
#   default = "400s"
#   description = "Duration over which window quality is evaluated, given as a duration string \"{X}s\" representing X seconds. Must be an integer fraction of a day and at least 60s."
# }