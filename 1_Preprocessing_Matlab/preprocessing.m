function [raw_normaliz_preprocessed_x, raw_normaliz_preprocessed_y] = preprocessing(EyeX_,EyeY_,RTs)

% Benedetta Franceschiello, Lausanne, May 2018
% Fabio Anselmi, IIT and MIT, Genova
% Eye - Tracker project: Analysis of ET trajectories for Neglect
% identification with Signal Processing and Machine Learning techniques

% This function takes into account RAW Eye-Tracking trajectories 
% data and it preprocess them
%% If RTs are present 
% In this example RTs are in ms
% Index of end of the trial need to be rounded, despite the sampling rate
% Reaction time starts at 3000 ms in this task, so after first 1000 points of the vector
idx_react_time = round(RTs./3) + 1000; % RTs starts from 3000 ms , so we sum (1000 indexes) after converting from ms to index.

%% Inizialization of the variables 

Coord_x = EyeX_;
Coord_y = EyeY_;
%% Preprocessing: screen resolution = 1025 x 768, center of the screen is (384,512)
% 1. Fill the gaps (NaN) with interpolated points
% NB: trajectories X and Y are handled separately. In case we want combine
% them we have to treat NaN and interpolation differently, discarding
% values wheter either X or Y or both are NaN.

%initialise variable
indici = 1:size(Coord_x,2);
Coord_x_interp = zeros(size(EyeX_));
Coord_y_interp = zeros(size(EyeY_));
raw_normaliz_preprocessed_x = zeros(size(EyeX_));
raw_normaliz_preprocessed_y = zeros(size(EyeY_));

%loop over trial
for i = 1:size(EyeX_,1)

            %If first point of the sequence is NaN, replace with the center of
            %the screen to allow interpolation
            if (isnan(Coord_x(i,1))==1 || isnan(Coord_y(i,1))==1)
                Coord_x(i,1) = 384;
                Coord_y(i,1) = 512;
            end
            
            %If trajectories contain zeros, fill with NaN
            %(Check for zero coordinates along the trial, as they are
            %outliers)
            Coord_x(i,Coord_x(i,:)==0) = NaN;
            Coord_y(i,Coord_y(i,:)==0) = NaN;
            

            %Look for the last non-NaN element before RTs
            %This tells in the chunck from the beginning till the RT which
            %values are NaN and which not
            k1 = isnan(Coord_x(i,1:idx_react_time(i)));
            k2 = isnan(Coord_y(i,1:idx_react_time(i)));
            %We want the Index of the Non-Nan, so we can take the last
            %coordinate and replace it in the trajectory.
            idx_k1 = find(k1==0);
            idx_k2 = find(k2==0);
            %Filling target coordinate after target identification -- it corresponds to RTs 
            Coord_x(i,idx_k1(end):end) = Coord_x(i,idx_k1(end));
            Coord_y(i,idx_k2(end):end) = Coord_y(i,idx_k2(end));

            
            %Identify query points for interpolation, and fx at query points
            idx_not_Nan = double(indici(isnan(Coord_x(i,:))==0));
            f_idx_not_Nan = double(Coord_x(i,isnan(Coord_x(i,:))==0));
            idy_not_Nan = double(indici(isnan(Coord_y(i,:))==0));
            f_idy_not_Nan = double(Coord_y(i,isnan(Coord_y(i,:))==0));
            
            %Interpolation version 2020 - nearest neighbour at the place of
            %linear
            f_idx_Nan = interp1(idx_not_Nan,f_idx_not_Nan,indici,'nearest');
            f_idy_Nan = interp1(idy_not_Nan,f_idy_not_Nan,indici,'nearest');            
            
            Coord_x_interp(i,:) = f_idx_Nan;
            Coord_y_interp(i,:) = f_idy_Nan;
            
            %Test to check if there are NaN left after interpolation
            assert(sum(find(isnan(Coord_x_interp(i,:))))==0)
            assert(sum(find(isnan(Coord_y_interp(i,:))))==0)
            
            clear idx_not_Nan; clear idy_not_Nan; clear f_idx_Nan; clear f_idy_Nan; clear idx_k1; clear idx_k2;
            clear k1; clear k2; 
        
            %The next bit compute mean and standard deviation for z-scoring
            %trajectories
                   
            media_x = mean(Coord_x_interp(i,:));
            sigma_x = std(Coord_x_interp(i,:));
            media_y = mean(Coord_y_interp(i,:));
            sigma_y = std(Coord_y_interp(i,:));
                        
            %z-score interpolated trajectories
            raw_normaliz_preprocessed_x(i,:) = (Coord_x_interp(i,:) - media_x)/sigma_x;
            raw_normaliz_preprocessed_y(i,:) = (Coord_y_interp(i,:) - media_y)/sigma_y;
 
end
