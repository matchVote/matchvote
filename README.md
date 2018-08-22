# matchVote    
[![Build Status](https://travis-ci.org/matchVote/matchvote.svg?branch=master)](https://travis-ci.org/matchVote/matchvote)

matchVote lets you automatically follow the political positions and news for elected officials in the US

#### Development Setup
    bin/build              # creates containers
    bin/setup              # creates DB, migrates, seeds
    docker-compose up      # starts containers

#### Deployment Process
    bin/deploy <ENV>
Initial data population will need to happen when an environment is deployed to for the first time: `rake import:all_default_data`

#### Updating version
* config/application.rb `VERSION`

#### Rep Hierarchy
All ->  
Levels: Federal, State, Municipal ->  
Federal Branches: Executive, Judicial, Legislative ->  
Government Role ->
Profile

#### Rep Data Sources:  
  * Congress Legistators - https://github.com/unitedstates/congress-legislators
  * Federal Donor Data - https://www.opensecrets.org/resources/create/apis.php
  * State Donor Data - http://www.followthemoney.org/our-data/apis/

#### NOTES
Rep Terms?  

> * Statements
>   * Declarative text (limit character count?): Limited to 256

>   -Citizen User Type also has
>   * Alignment Importance with Rep (0, 1, 2, 3, 4, 5)
>   * Agreement with Researcher Inferrence
