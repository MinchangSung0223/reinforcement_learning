
 function card_num=get_card()
    % A 2 3 4 5 6 7 8 9 10 J Q K  , 13장
    card_num = randi(13);
    [card_num,ind] = min([10,card_num]);
 end