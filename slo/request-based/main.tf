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
  project = var.monitoring_project_id
}

resource "google_monitoring_custom_service" "customsrv" {
  display_name = var.service_display_name
}

// Google Monitoring SLO objects can support many different metric types, for more info see our documenation. 
resource "google_monitoring_slo" "custom_request_based_slo" {
  service = google_monitoring_custom_service.customsrv.service_id
  display_name = var.metric_display_name
  goal = var.goal
  rolling_period_days = var.rolling_period_days // Replacable with calendar_period = "DAY", "WEEK", "FORTNIGHT", or "MONTH"
  request_based_sli {
    // Alternate implementation could use distribution_cut instead of good_total_ratio. 
    good_total_ratio {
      // Any combination of two elements: good_service_filter, bad_service_filter, total_service_filter. 
      good_service_filter = join(" AND ", var.good_service_filter)
      total_service_filter = join(" AND ", var.total_service_filter)
    }
  }
}



# resource "google_monitoring_slo" "custom_request_based_slo" {
#   service = google_monitoring_custom_service.customsrv.service_id
#   display_name = var.metric_display_name
#   goal = var.goal
#   rolling_period_days = var.rolling_period_days // Replacable with calendar_period = "DAY", "WEEK", "FORTNIGHT", or "MONTH"
#   request_based_sli {
#     // Alternate implementation could use good_total_ratio instead of distribution_cut. 
#     distribution_cut {
#           distribution_filter = "metric.type=\"serviceruntime.googleapis.com/api/request_latencies\" resource.type=\"api\"  "
#           range {
#             max = 0.5
#           }
#         }
#     }
# }