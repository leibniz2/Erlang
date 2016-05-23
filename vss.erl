-module(vss).
-export([start/0, service/2, cast_radley/2, cast_rosal/2, tally/2, 
	vote_cand1/1, vote_cand2/1, stop_serv/0, stop/1]). %% add vote_tally/1
 
start() ->
	spawn(fun() -> vss:service(0, 0) end).

vote_cand1(Pid) -> Pid ! radley.
vote_cand2(Pid) -> Pid ! rosal.
%vote_tally(Pid)	-> Pid ! votes. 
stop(Pid)		-> Pid ! stop.

service(RA, RO) ->
	io:format("Waiting for votes...~n"),
	receive
		radley ->
			vss:cast_radley(RA + 1, RO);
		rosal ->
			vss:cast_rosal(RA, RO + 1);
		%votes ->
		%	vss:tally(RA, RO);
		stop ->
			stop_serv()

	after 1000 ->
			vss:service(RA,RO)
	end.

cast_radley(RA, RO) ->
	io:format("Voted for Radley! ~n"),
	io:format("Total vote: ~5B ~n", [RA]),
	service(RA , RO).

cast_rosal(RA, RO) ->
	io:format("Voted for Rosal! ~n"),
	io:format("Total vote: ~5B ~n", [RO]),
	service(RA , RO).

tally(RA, RO) ->
	io:format("Partial Unofficial: ~n"),
	io:format("Radley: ~5B ~n", [RA]),
	io:format("Rosal: ~5B ~n", [RO]),
	io:format("*****NOTHING FOLLOWS*****~n"),
	service(RA,RO).

stop_serv() ->
	io:format("Service stopped!! ~n").

