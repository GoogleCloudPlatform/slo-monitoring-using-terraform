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

resource "google_monitoring_slo" "custom_windows_based_slo" {
  service = google_monitoring_custom_service.customsrv.service_id
  display_name = var.metric_display_name
  goal = var.goal
  rolling_period_days = var.rolling_period_days
  windows_based_sli {
    window_period = var.window_period
    // You may choose to use good_bad_metric_filter, good_total_ratio_threshold, metric_mean_in_range, or metric_sum_in_range
    good_total_ratio_threshold {
      threshold = var.threshold
      performance {
        distribution_cut {
          distribution_filter = join(" AND ", var.distribution_filter_data)
          range {
            min = var.min
            max = var.max
          }
        }
      }
    }
  }
}

