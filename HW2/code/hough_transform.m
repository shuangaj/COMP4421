% hough_transform contains the implementation of main routine for Question
% 2 in Assignment 2. This function uses circular Hough Transform to detect circles
% in a binary image. Given that the radius of the circles is 50 pixels. Note
% that you are not allow to use the imfindcircles matlab built-in function
% in this question.

function hough_transform()

    % Read the input image and convert it to binary image
    IM = imread('hough_image.jpg');
    img = im2bw(IM);
    % Display the input image
    figure;
    imshow(img);title('Input image');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TODO_1: Find the edge of the image
    % imgBW = ??
    imgBW = edge(img,'Canny');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;    
    imshow(imgBW);title('Edge');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TODO_2: Perform the circular Hough Transform. Given that the radius
    % of the circles is 50 pixels. Create a varible 'Accumulator' to store
    % the bin counts.
    % Accumulator = ??
    [row,col] = size(imgBW);
    Accumulator = zeros(row,col);
    
    % Find point on the edge, set it as center and draw circles with radius
    % 50, label the pixel if it is on the circle drawed
    for i = 1:row
        for j = 1:col
            if imgBW(i,j) == 1
                for t = 0:360
                    x = int16(i - 50 * sin( t * pi / 180 ));
                    y = int16(j - 50 * cos( t * pi / 180 ));
                    if ( x > 0 )&&( y > 0 )&&( x <= row )&&( y <= col )
                        Accumulator(x,y) = Accumulator(x,y) + 1;
                    end
                end
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Visualize the Accumulator cells
    figure;
    imagesc(Accumulator);title('Accumulator cells');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TODO_3: Search for the highest count cell in 'Accumulator' and store the
    % x,y-coordinate in two separate arrays. Note that there should be 2 sets of x and
    % y-coordinate, ie: x_cir = [{value1};{value2}] , y_cir = [{value1};{value2}]
    % x_cir = ??
    % y_cir = ??
    
    % Find the pixel with largest intensity
    [row_A,col_A] = size(Accumulator);
    Largest = max(max(Accumulator));
    x_cir = [];
    y_cir = [];
    for i = 1:row_A
        for j = 1:col_A
            if (abs(Accumulator(i,j) - Largest) < 3)
                x_cir = [x_cir;j];
                y_cir = [y_cir;i];
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Plot the results using red line
    figure;
    imshow(imgBW);title('Locate the circles');
    hold on;
    plot(x_cir(:),y_cir(:),'x','LineWidth',2,'Color','red');
    radlist = repmat(50,1,length(x_cir));
    viscircles([x_cir(:) y_cir(:)], radlist(:),'EdgeColor','r');

end