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

resource "google_monitoring_alert_policy" "custom_alerting_policy" {
  display_name = var.alert_policy_display_name
  combiner     = "OR"
  notification_channels = var.notification_channels
  conditions {
    display_name = var.alert_condition_display_name
    condition_threshold {
      filter = var.alerting_filter
      duration   = var.duration
      comparison = "COMPARISON_GT"
      threshold_value =  var.threshold_value
      aggregations {
        alignment_period   = var.alignment_period
      }
    }
  }
}