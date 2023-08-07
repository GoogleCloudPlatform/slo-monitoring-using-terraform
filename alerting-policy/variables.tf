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

variable "alerting_filter" {
  description = "Enter the alerting filter for your alerting policy. "
  default = ""
  type = string
  # default     = "select_slo_burn_rate(\"projects/${var.monitoring_project_id}/services/${customsrv.service_id}/serviceLevelObjectives/${custom_request_based_slo.slo_id}\", \"3600s\")"
}

variable "notification_channels"{
  description = "List of notification channels that should be alerted based on this alerting policy."
  default = ["projects/cloud-ops-sandbox-68154743/notificationChannels/3227544056812514878"]
  type = list(string)
}

variable "duration"{
  description = "What should the duration for the alert be?"
  default = "0s"
  type = string
}

variable "threshold_value"{
  description = "What should the threshold value for the alert be?"
  default = 10
  type = number
}

variable "alignment_period"{
  description = "What should the alignment period be? (seconds, ending in s)"
  default = "60s"

}

variable "alert_policy_display_name" {
  description = "What should the display name of the alerting policy be?"
  type        = string
  default     = ""
}

variable "alert_condition_display_name" {
  description = "What should the display name of the alerting condition be?"
  type        = string
  default     = ""
}