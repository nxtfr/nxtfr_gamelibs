%%%-------------------------------------------------------------------
%% @doc nxtfr_gamelibs public API
%% @end
%%%-------------------------------------------------------------------

-module(nxtfr_gamelibs_app).

-behaviour(application).

-export([start/0, start/2, stop/1]).

start() ->
    application:start(nxtfr_gamelibs).

start(_StartType, _StartArgs) ->
    nxtfr_gamelibs_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
