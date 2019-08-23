# Elixir Conf 2019 - Building Scalable Real-time Systems in Elixir - Example 1

## Getting Started

### Installing Elixir

#### Linux/Mac

Clone this repository locally
```
git clone git@github.com:GrantJamesPowell/elixir_conf_example_1.git
```

Install Elixir

1. Install the asdf tool version manager (highly highly recommend this tool, I use it for elixir, Erlang, ruby, and nodejs but today we'll be using it for elixir/erlang)
https://asdf-vm.com/#/core-manage-asdf-vm

2. Install the elixir plugin
```
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
```

3. Install the Erlang plugin
```
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
```

4. Install the nodejs plugin
```
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
```

5. Run `asdf install` in this directory to install the dependencies of this file

6. Run `mix deps.get` to install elixir dependencies

7. Run `npm install --prefix assets` to install js dependencies

8. Install ApacheBench (`ab`)

## Part 1

### Goal

We want you to see the effects of serial and parallelism in Elixir. We have coded a small app which will process
some work and respond to the request. In one case, the work will be done serially—in the same process as the request.
In another case, the work will be done asynchronously—the request will not wait for it.

You should observe what happens to the system between the two cases. With Observer started, what effect do the requests
have on memory and schedulers? How is the process count affected as you run the requests?

### Process

1. Start your server with `mix phx.server`
2. Navigate to `http://localhost:4000/part1`
3. Run the serial request processor and evaluate questions

```
ab -n 3000 -c 50 http://127.0.0.1:4000/part1/serial
```

4. Run the async request processor and evaluate questions

```
ab -n 3000 -c 50 http://127.0.0.1:4000/part1/async
```

### Questions

* How is the memory affected during the requests?
* How are the schedulers affected during the requests?
* Were the requests fast, slow?
* What are the limitations of this type of request? (async vs serial)

## Part 2
