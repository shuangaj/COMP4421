% connected_component.m contains the implementation of the main routine for Question 1 in Assignment 2. 
% This function search for all connected component on the input image. It should output the total number of
% connected components, number of pixels in each connected component and
% display the largest connected component. Note that you are not allow to
% use the bwlabel/bwlabeln/bwconncomp matlab built-in function in this
% question.

function connected_component()
    %Read the input image and convert it to binary image (0,1)
    IM = imread('cc_image.jpg');
    BW = im2bw(IM);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% TODO_1: Search for all connected component with connectivity equals
	% to 8 and output the result to the command window in following format:
    % There are total {number of regions} region(s) :
    % Region 1, no. of pixels = {number of pixels}
    % Region 2, no. of pixels = {number of pixels}
    
    % Create a copy of BW
    Add_BW = BW;
    
    % Get dimension of BW
    [row,col] = size(Add_BW);
    
    % Record 1.number of connected regions  
    %        2.size of each region   
    %        3.First detected pixel of each region
    Num_of_Region = 0;
    Region_size = [];
    First_pixel = [];
    
    % Scan through the image, using flood-fill algorithm to find the
    % connected components
    for i = 1:row
        for j = 1:col
            if Add_BW(i,j) == 0
                continue;
            end
            Num_of_Region = Num_of_Region + 1;
            num_of_pixel = 1;
            First_pixel = [First_pixel;[i,j]];
            Q = [];
            Q = [Q;[i,j]];
            Add_BW(i,j) = 0;
            while isempty(Q) == 0
                n_row = Q(1,1);
                n_col = Q(1,2);
                Q(1,:) = [];
                % Search West
                if (n_col > 1)&&(Add_BW(n_row,n_col-1) == 1)
                    Add_BW(n_row,n_col-1) = 0;
                    Q = [Q;[n_row,n_col-1]];
                    num_of_pixel = num_of_pixel + 1;
                end
                % Search East
                if (n_col < col)&&(Add_BW(n_row,n_col+1) == 1)
                    Add_BW(n_row,n_col+1) = 0;
                    Q = [Q;[n_row,n_col+1]];
                    num_of_pixel = num_of_pixel + 1;
                end
                % Search North
                if (n_row > 1)&&(Add_BW(n_row-1,n_col) == 1)
                    Add_BW(n_row-1,n_col) = 0;
                    Q = [Q;[n_row-1,n_col]];
                    num_of_pixel = num_of_pixel + 1;
                end
                % Search South
                if (n_row < row)&&(Add_BW(n_row+1,n_col) == 1)
                    Add_BW(n_row+1,n_col) = 0;
                    Q = [Q;[n_row+1,n_col]];
                    num_of_pixel = num_of_pixel + 1;
                end
                % Search North_West
                if (n_row > 1)&&(n_col > 1)&&(Add_BW(n_row-1,n_col-1) == 1)
                    Add_BW(n_row-1,n_col-1) = 0;
                    Q = [Q;[n_row-1,n_col-1]];
                    num_of_pixel = num_of_pixel + 1;
                end
                % Search South_West
                if (n_row < row)&&(n_col > 1)&&(Add_BW(n_row+1,n_col-1) == 1)
                    Add_BW(n_row+1,n_col-1) = 0;
                    Q = [Q;[n_row+1,n_col-1]];
                    num_of_pixel = num_of_pixel + 1;
                end
                % Search North_East
                if (n_row > 1)&&(n_col < col)&&(Add_BW(n_row-1,n_col+1) == 1)
                    Add_BW(n_row-1,n_col+1) = 0;
                    Q = [Q;[n_row-1,n_col+1]];
                    num_of_pixel = num_of_pixel + 1;
                end
                % Search South_East
                if (n_row < row)&&(n_col < col)&&(Add_BW(n_row+1,n_col+1) == 1)
                    Add_BW(n_row+1,n_col+1) = 0;
                    Q = [Q;[n_row+1,n_col+1]];
                    num_of_pixel = num_of_pixel + 1;
                end
            end
            Region_size = [Region_size num_of_pixel];
        end
    end
    fprintf('There are total %d region(s) : \n',Num_of_Region);
    for j = 1:Num_of_Region
        fprintf('Region %d, no. of pixels = %d \n',j,Region_size(j));
    end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% TODO_2: Find the largest connected component in binary format (0,1).
	% L_CC = ??
    
    % Find the largest Region
    Largest_Region = 1;
    Largest_Size = Region_size(1);
    for i = 2:Num_of_Region
        if Region_size(i) > Largest_Size
            Largest_Size = Region_size(i);
            Largest_Region = i;
        end
    end
   
    % Scan through the image again to preserve only the largest component
    L_CC = BW*0;
    Add_BW2 = BW; 
    Q = [];
    Q = [Q;[First_pixel(Largest_Region,1),First_pixel(Largest_Region,2)]];
    Add_BW2(i,j) = 0;
    while isempty(Q) == 0
        n_row = Q(1,1);
        n_col = Q(1,2);
        Q(1,:) = [];
        % Search West
        if (n_col > 1)&&(Add_BW2(n_row,n_col-1) == 1)
            Add_BW2(n_row,n_col-1) = 0;
            L_CC(n_row,n_col-1) = 1;
            Q = [Q;[n_row,n_col-1]];
        end
        % Search East
        if (n_col < col)&&(Add_BW2(n_row,n_col+1) == 1)
            Add_BW2(n_row,n_col+1) = 0;
            L_CC(n_row,n_col+1) = 1;
            Q = [Q;[n_row,n_col+1]];
            
        end
        % Search North
        if (n_row > 1)&&(Add_BW2(n_row-1,n_col) == 1)
            Add_BW2(n_row-1,n_col) = 0;
            L_CC(n_row-1,n_col) = 1;
            Q = [Q;[n_row-1,n_col]];
        end
        % Search South
        if (n_row < row)&&(Add_BW2(n_row+1,n_col) == 1)
            Add_BW2(n_row+1,n_col) = 0;
            L_CC(n_row+1,n_col) = 1;
            Q = [Q;[n_row+1,n_col]];
        end
        % Search North_West
        if (n_row > 1)&&(n_col > 1)&&(Add_BW2(n_row-1,n_col-1) == 1)
            Add_BW2(n_row-1,n_col-1) = 0;
            L_CC(n_row-1,n_col-1) = 1;
            Q = [Q;[n_row-1,n_col-1]];
        end
        % Search South_West
        if (n_row < row)&&(n_col > 1)&&(Add_BW2(n_row+1,n_col-1) == 1)
            Add_BW2(n_row+1,n_col-1) = 0;
            L_CC(n_row+1,n_col-1) = 1;
            Q = [Q;[n_row+1,n_col-1]];
        end
        % Search North_East
        if (n_row > 1)&&(n_col < col)&&(Add_BW2(n_row-1,n_col+1) == 1)
            Add_BW2(n_row-1,n_col+1) = 0;
            L_CC(n_row-1,n_col+1) = 1;
            Q = [Q;[n_row-1,n_col+1]];
        end
        % Search South_East
        if (n_row < row)&&(n_col < col)&&(Add_BW2(n_row+1,n_col+1) == 1)
            Add_BW2(n_row+1,n_col+1) = 0;
            L_CC(n_row+1,n_col+1) = 1;
            Q = [Q;[n_row+1,n_col+1]];
        end
    end
                
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    subplot(1,2,1);imshow(BW);title('Input image');
    subplot(1,2,2);imshow(L_CC);title('Largest connected component');
end

