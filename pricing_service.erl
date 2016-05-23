-module(pricing_service).
-export([link_with/1, message_receiver/0, reply_with_price_of/1]).

link_with(ClientPid) ->
	register(client, ClientPid),
	spawn_link(pricing_service, message_receiver, []).

message_receiver() ->
		receive
			{} -> pricing_service:reply_with_price_of(tea), 
					pricing_service:message_receiver()
	end.

reply_with_price_of(Item) ->
	client ! io:format("The price of ~p is : ~p ~n", [Item, price(Item)]).

price(Item) ->
	case Item of
		tea -> 2.05;
		coffee -> 2.10;
		milk -> 1.25;
		bread -> 0.50
	end.
