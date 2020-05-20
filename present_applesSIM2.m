function [user, params] = present_applesSIM2(params, user, b, g)

% local vars
cond = user.block(b).item(g,1);
item = user.block(b).item(g,2);

%% Define numbers of apples
if user.unused_tree(item) == 1
    seen_apples = 2;
    if user.item(cond,item).hor == 6
        end_t = (seen_apples);
    elseif user.item(cond,item).hor == 11
        end_t = (seen_apples+1);
    end
elseif user.unused_tree(item) == 2 || user.unused_tree(item) == 4
    seen_apples = 4;
    if user.item(cond,item).hor == 6
        end_t = (seen_apples+1);
    elseif user.item(cond,item).hor == 11
        end_t = (seen_apples+1)+5;
    end
elseif user.unused_tree(item) == 3
    seen_apples = 5;
    if user.item(cond,item).hor == 6
        end_t = (seen_apples+1);
    elseif user.item(cond,item).hor == 11
        end_t = (seen_apples+1)+5;
    end
end

%% fill in pre-opened draws
for t = 1:size(user.item(cond,item).initial_apples.tree,2)
    tree = user.item(cond,item).initial_apples.tree(t); 
    val = user.item(cond,item).initial_apples.size(t);
    
    % For the log
    tree_vec = nan(1,4);
    tree_vec(tree) = 1;
    
    % write to log
    %{'Block','Blocktrial','Horizon','Game','Trial','TreeA','TreeB','TreeC','TreeD','Size','RT','PressedKey', 'Unused Tree'};
    hori=user.item(cond,item).hor;
    user.log(end+1,:) = [b,g,hori,item,t,tree_vec(1), tree_vec(2), tree_vec(3), tree_vec(4),val,0,nan, user.unused_tree(item)]; 
end
 

end