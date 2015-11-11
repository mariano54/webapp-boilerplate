## Boilerplate Webapp
---------------------------------
This is a bolierplate webapp, using the following technologies:
* react
* redux
* react-router
* CoffeScript
* browserify
* Radium and Bootstrap for styles
* Karma, Chai, Mocha, and Sinon for testing
* Redux devtools for dev

It automates a bunch of things, such as adding new reducer files to the main reducer,
Compiling and linting the CoffeScript and cjsx (coffescript jsx), and all of the
testing. Still a work in progress.

### Guides
---------------------------------
* React: https://facebook.github.io/react/docs/tutorial.html  
* Redux: http://rackt.github.io/redux/docs/introduction/Motivation.html  
* CoffeScript: http://coffeescript.org/  


### Install
---------------------------------
In order to install everything:
```sh
$ npm install
```

### Run
---------------------------------
In order to clean, compile, and run the development and debug server:
```sh
$ grunt
```

In order to uglify everything, and run a production server:
```sh
$ grunt production
```
