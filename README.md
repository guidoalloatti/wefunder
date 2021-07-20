Wefunder
================
The homework assignment is a pitch deck uploader.

When a founder is looking to raise capital for their company, a fair amount of thought will go in to their pitch deck. They will share their deck with potential investors to help sell investors on why they should invest in the company.
We want to make raising money on Wefunder as simple as possible, so we allow founders who have already built a pitch deck to upload it to Wefunder and we'll show their deck on their profile — rather than forcing the founder to recreate their pitch on our site.

You can see an example of this on Wefunder's own company profile (we dogfood our own product to raise our rounds): https://wefunder.com/wefunder

## The Challenge
Build a tool that allows a user to upload their pitch deck and display it on a web page.
At a minimum, you should have:
- A web page that allows a user to upload a file as a PDF. Bonus points for supporting PPT and other formats too.
- A backend that takes the uploaded file and generates an image for each slide.
- A web page that displays the deck using the image of each slide, like on the Wefunder profile page.

You don't have to worry about user accounts or supporting multiple company profile pages. It's OK if the display page simply shows the last deck that was uploaded to the upload page.

You can use any technology stack, libraries, and APIs you're comfortable with. The design/architecture is up to you. The UI can be basic, but should look halfway good.

Commit your project to a git repo and push it to GitHub. Include a README file that explains how to run your project. It should work on a Ubuntu 20 machine.

When you're ready for us to take a look at it, send us a link to the GitHub repo.


Reference Application
---------------------
A reference application can be found at [https://wefunder.com/wefunder](https://wefunder.com/wefunder)


Test Suite
----------
To run the test suite in full, you can do:

``
$ bundle exec rspec spec
``

Requirements
-------------

This application requires:

- Ruby 2.6.2
- PostgreSQL server running on localhost

Chanllenge Resolution Explanation
----------------
- `mainline` is the principal branch.


Installations Steps
----------------
- Install and Set `ruby` version to `2.7.3` (rbenv or rvm)
- `Rails` Version: 5.2.6
- Default database adapter is `Postgresql`

- Run: `$ bundle install`
- Run: `$ rake db:create`
- Run: `$ rake db:migrate`

PPT and PPTX support
----------------
In order to provide file compatibility with the ppt and pptx files, I used the `docsplit` gem. This gem requires some packages to be installed in the OS to work properly. This are the libraries needed to makle it work.
Since I run it on MacOs, this is what I have to install to make it work:
- Run (MacOs only): `$ brew install graphicsmagick poppler ghostscript tesseract pdftk libreoffice`
- To install it on `linux` you should install those packages with your preferred package manager.

Start Rails Server
----------------
- Run: `$ rails s`

Start Sidekiq Server
----------------
- Run: `$ exec bundle exec sidekiq -c 1 -q wefunder`

Visit the page
----------------
- Go to: `localhost:3000` 
  or directly to: `localhost:3000/decks`
- Start uploading the pitch deck.

System Functionality Explained
----------------

## Index
![alt text](https://i.ibb.co/3CwTyJs/Screen-Shot-2021-07-20-at-03-46-35.png)
  - You can see all the details for the Pitch Decks created from the main index page.
  - You can create new decks by accesing the Upload page from the index.
  - You can delete previously created decks from the index.
  - You can see the details for a deck.

# Upload
![alt text](https://i.ibb.co/f0QFfk2/Screen-Shot-2021-07-20-at-03-47-19.png)
  - You can fill the form with some basic information.
  - You can upload a file with a *pdf/ppt/pptx* format with the pitch deck details.
  - You can get back to decks page.
  - You can access the newly created deck details after created.

## Deck Details
![alt text](https://i.ibb.co/mGKdr00/Screen-Shot-2021-07-20-at-03-46-49.png)
  - You can see all the relevant information regarding the pitch deck in this page.
  - You can see the images extracted from the uploaded file.
  - You can get back to the decks.
  - You can delete this previously created deck.
  - You can go to add a new version for the pitch deck.

Architecture Design
-----------------
![alt text](https://i.ibb.co/4gzbHCT/Screen-Shot-2021-07-20-at-03-44-32.png)


