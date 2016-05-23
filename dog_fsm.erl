-module(dog_fsm).
-export([start/0, squirrel/1, pet/1, bark/0, wag_tail/0, sit/0]).
 
start() ->
	spawn(fun() -> dog_fsm:bark() end).
 
squirrel(Pid) -> Pid ! squirrel.
 
pet(Pid) -> Pid ! dogpet.
 
bark() ->
	io:format("Dog says: test!!~n"),
	receive
		pet ->
			dog_fsm:wag_tail();
		_ ->
			io:format("Dog is confused~n"),
			dog_fsm:bark()
	after 2000 ->
		dog_fsm:bark()
	end.

wag_tail() ->
	io:format("Dog wags its tail~n"),
	receive
		pet ->
			dog_fsm:sit();
		_ ->
			io:format("Dog is confused~n"),
			dog_fsm:wag_tail()
	after 30000 ->
		dog_fsm:bark()
	end.
 
sit() ->
	io:format("Dog is sitting. Gooooood boy!~n"),
	receive
		squirrel ->
			dog_fsm:sit();
		_ ->
			io:format("Dog is confused~n"),
			dog_fsm:sit()
	end.