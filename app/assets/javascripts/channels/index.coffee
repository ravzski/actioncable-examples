#= require cable
#= require_self
#= require_tree .

# bootstraps connection to websocket running on 28080
@App = {}
App.cable = Cable.createConsumer 'ws://localhost:28080'
