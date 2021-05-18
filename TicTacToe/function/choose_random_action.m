function action = choose_random_action(S)
s = size(S);
k = find(S==0);
if length(k)==0
    action=-1;
    return
end
k=k(randperm(length(k)));
action = k(1);
end