## Markdown to website renderer in ruby ##

Small application which recursively searches for files with the extension *.md* in the *markdown* directory. Uses [Redcarpet](https://github.com/tanoku/redcarpet/) to transform each file. Places the content of each file in it's own tab on a web page.

Uses [jQuery UI Tabs](http://jqueryui.com/demos/tabs/) to display when displaying the content and the *Black Tie* theme.

Both the application as well as the markdown files are contained within the same [git](http://git-scm.com/) repository. This project is built to easily be used on [Heroku](http://www.heroku.com/).

### Using this application on Heroku ###

To make immediate use of this project one only needs to execute the following commands:

`$ git clone git://github.com/ciwchris/markdown-website-renderer.git mywebsite`  
`$ cd mywebsite`  
`$ heroku create --stack cedar mywebsite`  
`$ git push heroku master`  
`$ heroku open`  

### Other ins-and-outs ###

- To run the application locally: `$ foreman start`
- The template file exists in *views/index.erb* and can be modified to your liking.
- Currently the application only scans for files in *markdown/*. This can be changed in the application file, *web.rb*.
