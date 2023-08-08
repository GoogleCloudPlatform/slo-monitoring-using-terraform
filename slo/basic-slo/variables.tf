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

variable "project_id" {
  description = "What is the Project ID of the project?"
  type        = string
  default     = "my-project"
}

variable "service_display_name" {
  description = "The name of the service we are monitoring"
  type        = string
  default     = "My New Monitoring Service"
}

variable "service_id"{
  description = "create a unique service ID for this service."
  type = string
  default = "my-new-monitoring-service"
}

variable "metric_display_name" {
  description = "The name of the metric that we're creating."
  type        = string
  default     = "metric"
}

variable "goal" {
  description = "Our target metric for the SLO (This should be a number)"
  type        = number
  default = 0.9
}

variable "rolling_period_days" {
  description = "How many days should the rolling period be? (Default: 28)"
  type        = number
  default = 28
}

variable "service_type"{
  type = string
  default = "CLOUD_RUN"
  description = "What type of service would you like to monitor? Must be one of these options: APP_ENGINE, CLOUD_RUN, GKE_NAMESPACE, GKE_WORKLOAD, GKE_SERVICE, CLOUD_ENDPOINTS, CLUSTER_ISTIO, ISTIO_CANONICAL_SERVICE"
  validation {
    condition = contains(["APP_ENGINE", "CLOUD_RUN", "GKE_NAMESPACE", "GKE_WORKLOAD", "GKE_SERVICE", "CLOUD_ENDPOINTS", "CLUSTER_ISTIO", "ISTIO_CANONICAL_SERVICE"], var.service_type)
    error_message = "Valid values for service_type: test_variable are (APP_ENGINE, CLOUD_RUN, GKE_NAMESPACE, GKE_WORKLOAD, GKE_SERVICE, CLOUD_ENDPOINTS, CLUSTER_ISTIO, ISTIO_CANONICAL_SERVICE)."
  }
}

variable "service_labels"{
  type = map
  default = {service_name = "jobs-east1", location = "us-east1"}
  description = "What are the service labels for the service? APP_ENGINE: {module_id= \"module_id\"} CLOUD_RUN: {service_name: \"SERVICE_NAME\", \"location\": \"LOCATION\"}, etc. See https://cloud.google.com/stackdriver/docs/solutions/slo-monitoring/api/api-structures#basic-svc-w-basic-sli"
}

variable "latency_threshold" {
  type = string
  default = "5s"
  description = "What is the latency threshold? Example: 5s"
}
