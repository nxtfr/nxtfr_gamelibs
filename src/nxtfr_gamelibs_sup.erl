%%%-------------------------------------------------------------------
%% @doc nxtfr_gamelibs top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(nxtfr_gamelibs_sup).
-author("christian@flodihn.se").
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},
    NxtfrGameLibs = #{
        id => nxtfr_gamelibs,
        start => {nxtfr_gamelibs, start_link, []},
        type => worker},
    ChildSpecs = [NxtfrGameLibs],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
