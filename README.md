# README

Setup (Mac/Linux):
- Install Rails, and the other basic dependencies here: https://guides.rubyonrails.org/getting_started.html.  Use rails 6, and ruby 2.6.5
- Clone this repo
- cd into the repo's root directory
- run `yarn`
- run `rake db:migrate`
- run `rails s`, and visit http://localhost:3000/


Bugs:
- Scraping member websites for topics needs to account for HTML tags within h1-h3 tags, it works for sites that link to 
- You can pull up yourself as a connection with the graph search

Optimizations needed:
- The search really should be performed in a background job or lambda
- The search is currently exaustive; it doesn't terminate when the running path is longer than a solution that's already found
- The search could cause memory spikes. It allocates memory with each invocation
- The web scraping also really needs to be in a background job; certain web pages time out the request

UI/UX oddities:
- Having it be clearer when you're visiting your profile or not
- Search does not account for whether the member is already friends with the expert member
- There are no validations on fields/forms

Low-hanging fruits/features:
- The data model supports bringing up multiple members and the friendship paths to them based on matching topics. It just needs some UI and api code to make that work
- The data model supports adding multiple sites to a given member. Again, this just needs some minor tweaks

