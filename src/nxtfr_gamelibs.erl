-module(nxtfr_gamelibs).
-author("christian@flodihn.se").
-behaviour(gen_server).

%% External exports
-export([
    start_link/0
    ]).

%% gen_server callbacks
-export([
    init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2
    ]).

-spec start_link() -> ok.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

-spec init([]) -> {ok, []}.
init([]) ->
    {ok, LibPaths} = application:get_env(game_lib_paths),
    {ok, Libs} = application:get_env(game_libs),
    [code:add_patha(code:root_dir() ++ LibPath) || LibPath <- LibPaths],
    io:format("Added library paths: ~p.~n", [LibPaths]),
    %application:ensure_started(nxtfr_event),
    %nxtfr_event:add_global_handler(nxtfr_queue_event, nxtfr_queue_event_handler),
    {ok, State} = start_game_libs(Libs, []),
    {ok, State}.

handle_call(Call, _From, State) ->
    error_logger:error_report([{undefined_call, Call}]),
    {reply, ok, State}.

handle_cast(Cast, State) ->
    error_logger:error_report([{undefined_cast, Cast}]),
    {noreply, State}.

handle_info(Info, State) ->
    error_logger:error_report([{undefined_info, Info}]),
    {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    %nxtfr_event:delete_global_handler(nxtfr_queue, nxtfr_queue_event_handler),
    ok.

start_game_libs([], State) ->
    {ok, State};

start_game_libs([GameLib | Rest], State) ->
    error_logger:info_msg("Starting application: ~p.~n", [GameLib]),
    ok = application:start(GameLib),
    start_game_libs(Rest, State).
