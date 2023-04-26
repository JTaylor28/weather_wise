# weather Wise

## About the Project

Weather Wise is a Backend Project that that provides weather information for a specific area. It offers current weather conditions and a five-day forecast, as well as determines the route to a desired destination and the corresponding weather conditions upon arrival. The application integrates with Weather and MapQuest APIs to retrieve data location and weather data. It then creates endpoints in a new API to serialize and send the data to the front-end application.


## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of the VCR mocking tool


## Versions
- Ruby 3.1.1
- Rails 7.0.4


## API's Used
[MapQuest Api](https://developer.mapquest.com/)
[Weather Api](https://www.weatherapi.com/)

## Setup

1. Fork and Clone the repository
```shell
$ git clone git@github.com:JTaylor28/weather_wise.git
```

2. Navigate to the directory
```shell
$ cd weather_wise
```

3. Install Gem Packages
```shell
$ `bundle install`
```

4. Update Gem Packages
```shell
$ `bundle update`
```

5. Run the Migrations
```shell
$ rails db:{drop,create,migrate,seed}
```

6. Setup Figaro Gem
```shell
$ bundle exec figaro install
```

## Test Suite Instructions

1. Navigate to each API link and apply for an api key

2. Navigate to `config/application.yml` and add your api keys in the following format:

- ```MAPQUEST_API_KEY: <YOUR MAPQUEST API KEY HERE>```
- ```WEATHER_API_KEY: <YOUR WEATHER API KEY HERE>```