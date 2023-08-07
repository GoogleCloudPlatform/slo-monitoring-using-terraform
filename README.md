<!--
Copyright 2023 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

# SLO Monitoring using Terraform

These terraform examples make it easy to deploy SLOs in your Google Cloud Environment with Cloud Monitoring.

## Disclaimer

1. This is not an officially supported Google product.
2. Proper testing should be done before running this tool in production.

## Licensing

This sample code is made available under Apache 2 license. See the [LICENSE](./LICENSE) file for more details.

# Details

This repository contains terraform templates to:

-   Create [Service Level Indicators/Service Level Objectives (SLI/SLO)](https://cloud.google.com/stackdriver/docs/solutions/slo-monitoring) using the Google Cloud Operations Suite on Google Cloud Platform
-   Create Alerting policies for tracking and alerting on [Error Budget Burns](https://cloud.google.com/stackdriver/docs/solutions/slo-monitoring/alerting-on-budget-burn-rate)
-   Create [Notification channels](https://cloud.google.com/monitoring/support/notification-options) to various tools (email, mobile, webhook etc.) to deliver the alerts generated

## Creating Notification Channels

-   Clone the [Notification Channels](./notification-channel) templates into a folder with the following structure:

```bash
Notification Channels/
    ├── main.tf
    └── variables.tf
```

-   Edit the variables in `variables.tf`
-   Deploy via terraform

Note: Notification channels currently support email. Support for other channels coming soon.

## Creating SLI/SLO

Currently this repository contains examples to create 3 types of SLI/SLO:

-   **Basic** - These correspond to SLIs that can be created for certain native Google Cloud products including App Engine, GKE, Cloud Run and Istio. These require minimal configuration and are ideal if your service leverage these products.
-   **Request Based** - These SLIs use a count of the good and total events to compute SLIs. The degree of specificity that the user can employ is higher than that of Basic SLIs thus enabling the user to fine tune the dimensions of the SLI.
-   **Window Based** - These SLIs use the number of windows in a measurement period, during which the metric was compliant with the target, in the SLI/SLO calculation. These windows could be any length (from 1 second to 1 day).

Steps to create SLI/SLO:

-   Clone the relevant SLI template folder ([basic](./slo/basic-slo/), [request-based](./slo/request-based/), [window-based](./slo/windows-based/)) with the following structure:

```bash
<SLI Name>/
    ├── main.tf
    └── variables.tf
```

for example,

```bash
Availability for Login/
    ├── main.tf
    └── variables.tf
```

-   Edit the variables in `variables.tf`
-   Deploy via terraform

## Creating Alerting Policies

-   Clone the [Alerting Policies](./alerting-policy/) template with the following structure:

```bash
<Alerting Policy Name>/
    ├── main.tf
    └── variables.tf
```

for example,

```bash
Alert - 10% burn - Availability for Login/
    ├── main.tf
    └── variables.tf
```

-   Edit the variables in `variables.tf`
-   Deploy via terraform
