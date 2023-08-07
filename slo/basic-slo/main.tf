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

provider "google" {
  project = var.project_id
}



// For APP_ENGINE, CLOUD_RUN, GKE_NAMESPACE, GKE_WORKLOAD, GKE_SERVICE, CLOUD_ENDPOINTS, CLUSTER_ISTIO, ISTIO_CANONICAL_SERVICE resources, you may choose to use the "google_monitoring_service" resource instead of a custom service. 
// for more info, see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_service
// and our API reference for details for the system_labels contents at  https://cloud.google.com/stackdriver/docs/solutions/slo-monitoring/api/api-structures#basic-svc-w-basic-sli
resource "google_monitoring_service" "my_service"{
  service_id = var.service_id
  display_name = var.service_display_name
  // If you want to monitor CLOUD_RUN resources in a seperate monitoring project use a customer service. 
  basic_service{
    service_type = var.service_type
    service_labels = var.service_labels
  }
}

// Basic SLI objects support either availability or latency.
// For more info review https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_slo#nested_basic_sli 
// and our API reference at https://cloud.google.com/monitoring/api/ref_v3/rest/v3/services.serviceLevelObjectives#BasicSli
// Note the GKE_NAMESPACE, GKE_WORKLOAD, and GKE_SERVICE resources cannot use basic_sli. 
resource "google_monitoring_slo" "custom_basic_slo" {
  service = google_monitoring_service.my_service.service_id
  display_name = var.metric_display_name
  goal = var.goal
  rolling_period_days = var.rolling_period_days // Replacable with calendar_period = "DAY", "WEEK", "FORTNIGHT", or "MONTH"
  basic_sli {
    // latency or availability. Latency expects a threshold, availability requires no config. 
    latency {
      threshold = var.latency_threshold
    }
  }
  depends_on = [ google_monitoring_service.my_service ]
}

// Availability example
# resource "google_monitoring_slo" "custom_basic_slo2" {
#   service = google_monitoring_service.my_service.service_id
#   display_name = var.metric_display_name
#   goal = var.goal
#   rolling_period_days = var.rolling_period_days // Replacable with calendar_period = "DAY", "WEEK", "FORTNIGHT", or "MONTH"
#   basic_sli {
#     // latency or availability. Latency expects a threshold, availability requires no config. 
#     availability {
#
#     }
#   }
#   depends_on = [ google_monitoring_service.my_service ]
# }
