Open Systems Lab
----------------

## Install Hugo static site generator
[Getting Started](https://gohugo.io/getting-started/quick-start) w/ Hugo, and follow instruction [here](https://gohugo.io/getting-started/installing) to have Hugo installed on your workstation

## Clone this project
```shell
$ git clone git@github.com:OpenSystemsLab/homepage.git oslab
$ cd oslab
$ git submodule update --init
```

## Run the site localy
The command bellow will start a web server that serve the site on http://localhost:1313, and watchs for changes to reload the site automatic.

```shell
$ hugo server -D
```

## Generate HTML:
Simply execute `hugo` command in current directory, it will generates the website to the `public/` directory
