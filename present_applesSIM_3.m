function [user, params] = present_applesSIM_3(params, user)

% disp('----')
% size(unique((user.block(1).item)))
% size(unique((user.block(2).item)))
% size(unique((user.block(3).item)))
% size(unique((user.block(4).item)))
% disp('----')
% 
% size(unique([user.block(1).item(:,2); user.block(2).item(:,2); user.block(3).item(:,2); user.block(4).item(:,2)]))
    
mat_item_n_apples = [];

for b = 1:params.task.exp.n_blocks
    for g = 1:params.task.exp.n_trialPB
        
        % local vars
        cond = user.block(b).item(g,1);
        item = user.block(b).item(g,2);

        n_apples = size(user.item(cond,item).initial_apples.tree,2);
%         mat_item_n_apples(end+1,:) = [item, n_apples]
       
        %% fill in pre-opened draws       
        for t = 1:n_apples
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
end
 

end