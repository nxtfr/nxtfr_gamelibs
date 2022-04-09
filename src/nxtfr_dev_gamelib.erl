-module(nxtfr_dev_gamelib).
-author("christian@flodihn.se").
-behaviour(gen_server).

%% External exports
-export([
    start_link/1
    ]).

%% gen_server callbacks
-export([
    init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2
    ]).

-spec start_link(Socket :: port()) -> ok.
start_link(Args) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [Args], []).

-spec init([Socket :: port]) -> {ok, []}.
init([Socket]) ->
    %application:ensure_started(nxtfr_event),
    %nxtfr_event:add_global_handler(nxtfr_queue_event, nxtfr_queue_event_handler),
    {ok, [Socket]}.

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
    nxtfr_event:delete_global_handler(nxtfr_queue, nxtfr_queue_event_handler),
    ok.