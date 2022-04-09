%%%-------------------------------------------------------------------
%% @doc nxtfr_gamelibs top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(nxtfr_gamelibs_sup).
-author("christian@flodihn.se").
-behaviour(supervisor).

-export([start/1]).
-export([start_link/0]).
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    SupFlags = #{strategy => simple_one_for_one,
                 intensity => 0,
                 period => 1},
    NxtfrDevGameLib = #{
        id => nxtfr_dev_gamelib,
        start => {nxtfr_dev_gamelib, start_link, []},
        type => supervisor},
    {ok, {SupFlags, []}}.

start(Socket) ->
    {ok, {Module, Fun, Args}} = application:get_env(nxtfr_gamelibs, player_connected_mfa),
    UpdatedArgs = lists:merge(Args, [Socket]),
    supervisor:start_child(?MODULE, {Module, Fun, UpdatedArgs}).

%% internal functions
