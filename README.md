# README
-----------------

Developers notes:

- Git commits represent how I imagine working with the team, you will find filler commits, mainly on the DEVELOP branch 
to act as mocks of other people commits.
- Since git usage is taken into consideration, I refrained from squashing commits to preserve as much information about 
my thinking process during the development time of this project. Normally, I would squash commits when preparing the code 
for review and for it to be merged into another branch.
- Although it wasn't listed in the requirements, I've allowed myself to implement additional tests, such as 
DevicesController POST tests.
- I didn't agree on some tests implementation (or they were lacking critical parts), that is why I've allowed myself to
modify them slightly.

------------------
  
SETUP
- verify your system/IDE has Ruby that is compatible with this projects Ruby version, which can be found in the 
.ruby-version file or the Gemfile. You can verify your Ruby version by running "ruby -v" in the terminal.
- verify you have rails and a ruby bundler installed. Ensure you have a compatible rails version to this project, which
can be also found in the Gemfile. You can verify your rails version by running "rails -v" and bundler version by running
"bundler -v" in the terminal.
- You must install all needed gem dependencies by running "bundler install" in the terminal.
- Before launching the app, please run in the terminal the following commands: "rspec spec" to run all existing tests,
"rake db:test:prepare" which prepares the database for usage.

------------------

Your task is to implement the part of the application that helps track devices assigned to users within an organization.

For now, we have two ActiveRecord models: User and Device.
User can have many devices; the device should be active only for one assigned user.
There are 2 actions a User can take with the Device: assign the device to User or return the Device.

Here are the product requirements:
- User can assign the device only to themself. 
- User can't assign the device already assigned to another user.
- Only the user who assigned the device can return it. 
- If the user returned the device in the past, they can't ever re-assign the same device to themself.


TODO:
 - Clone this repo to your local machine - DON'T FORK IT.
 - Fix the config, so you can run the test suite properly.
 - Implement the code to make the tests pass for `AssignDeviceToUser` service.
 - Following the product requirements listed above, implement tests for returning the device and then implement the code to make them pass.
 - In case you are missing additional product requirements, use your best judgment. Have fun with it.
 - Refactor at will. Do you see something you don't like? Change it. It's your code. Remember to satisfy the outlined product requirements though.
 - Remember to document your progress using granular commits and meaningful commit messages.
 - Publish your code as a public repo using your Github account.
