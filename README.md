# NiceFit Server

[![License: GPL v2](https://img.shields.io/badge/License-GPL_v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

NiceFit Server is an **free open-source size and fit recommendation server** for the fashion ecommerce industry.

It provides a state of the art solution based on continuous improvement and an unique in the industry product information refinement lifecycle. 

## Project Status

We are in the early stages of development and the system now only has some demonstration features and data, but it will quickly evolve into a full solution along with brother projects `NiceFit Widget` and `NiceFit Admin`

## Approach

In a nutshell, the approach of NiceFit combines all the industry methods into a cohesive system that allows addressing the recommendation approach from different working modes and body sizing estimation

### Working Modes

NiceFit Server can be used in different working modes

* **Estimated Body, Estimated Product** **(EBEP)**: when the system works by estimating both body measurements and product measurements. This is a **mostly unattended system** that provides the lower level of precision, but ***almost zero*** **effort for maintenance**. Here the combination from users entering their basic data and then purchasing products and not returning them, will act as factual data for estimating product sizes that, when sufficent, will activate product sizing recommendation for these products. Also, product sizing relationships between products can be created so similar products get enriched in a similar fashion. 
* **Estimated Body, Factual Product** **(EBFP)** when we have factual information about the product (actual measurements for the different positions) by either confirmed estimations from the EBEP mode or because actual product measurements have been introduced in the system for each variant of the product. We continue to use body measurements estimations.
* **Factual Body, Estimated Product** **(FBEP)** when we have factual information about the body (somebody actually measured the subject) but we still have estimated product information. In this mode, users who have factual body measurements and later on purchase products that they don't return, will be used to estimate product information. This is similar to EBEP mode, but does not rely on estimated body measurements, but on factual ones. This would be more precise than both EBEP and EBFP and it is the preferred mode for bigger companies that can have people measured and products tested by those people.
* **Factual Body, Factual Product** **(FBFP)** The most precise scenario, where the have measured body and product information. This is the best system for pret-a-porter shops that receive precise body sizing information from users and also have precise product information from their tailors. In this mode, no estimation is performed and recommendation is based on actual factual data, so precision of the recommendation is the highest.

### Body Estimation

Body measurements estimation is performed by using simple machine learning methods.

* ***Multi-variable linear regression*** with live factor calculation. All estimated data is recreated when new factors from the linear calculations are calculated, so estimations are kept up to date to new evidence.
* ***K-Nearest Neighbours*** with live in-memory neighbour calculation. In-memory data is refreshed every time new factual data is incorporated into the system.

## What features will it have?

* **Easy `OpenAPI Spec` based API** for integration with backend services, and an off-the-shelf web widget in the brother project `NiceFit Widget`.
* **Multiple product variant schemas**, with support for differentiated series and positions, attributes.
* **Recommendation based on positions and attributes**. This allows recommendations not only based on body measurements but also on **user preferences and consensus preferences**.
* **Continuous improvement of user and apparel data** based on having a `factual` and `estimated` data on the same process and structures.
* **Uses machine learning algorithms when factual data is not available** for creating estimations. KNN, Multivariate linear regression, SVM, Gradient Boosted Trees, methods for Body measurements estimation and Product variant recommendation based on estimated data.
* **Product data evolution based on a product information refinement lifecycle**. By using factual information injected from the ecommerce platform, the system refines either its internal product sizing data. 

## About the Project

### Technology

Nicefit Server is a [Phoenix framework](https://www.phoenixframework.org/) application written in [Elixir](https://elixir-lang.org/), a modern, fast, highly-concurrent platform.

This is my first Elixir project, so it is also being used to explore the language possibilities and train myself in using it for developing applications.

### Business Case

I have been drilling through this problem for many years now, having been the CTO of a company who offers a similar service, but since parting ways with the company, I now have decided to give it a new try under an opensource license so everybody can contribute in this project.

## Running the Server

We will provide a `docker-compose` ready system when we reach at least `alpha` status. In the meanwhile, you can run the server by 

1. Install [Elixir](https://elixir-lang.org/install.html) and the [Phoenix Framework](https://hexdocs.pm/phoenix/installation.html#elixir-1-12-or-later).
2. Clone the repository.
3. Modify `config/dev.exs` for adjusting the `Nicefitserver.Repo` database configuration.
4. Evolve the database by running the corresponding mix jobs: `mix ecto.create; mix ecto.migrate ; mix run priv/repo/seeds.exs` 
5. The previous step will create an initial database with all data needed for initial body estimations and some products for testing.
6. Run the server with `mix phx.server`. Wait until the models have retrained (`[info] Finished Training`)
7. Run the embedded Swagger UI on `http://localhost:4000/swaggerui` 
8. Try the recommend verb. You will first have to get an user_id and a product_id from the database (they are auto-generated on seed generation, cannot provide them there sorry.)