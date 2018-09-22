%Program to play hang man, started 2018/09/21
%note that the structure of the text file MUST have category names being
%capitalized, the only capital letters allowed in the program
group = -1;
source = fopen('words.txt','r');
words = fscanf(source,'%c');
words = strsplit(words);
fprintf('Welcome to Hangman! Note: all words are solely lowercase\nToday''s categories are:\n');
numwords = size(words);
capletterlcn = zeros(1,numwords(2));
for i = 1:numwords(2)
    if find(isstrprop(cell2mat(words(i)),'upper'))
        capletterlcn(i)=1;
    end
end
counter = 1;
for i = find(capletterlcn)
    fprintf('%d: ',counter);
    fprintf('%c',cell2mat(words(i)));
    fprintf('\n');%note: this had to be separated, as printing character arrays doesn't play well with fprintf
    counter = counter + 1;
end
fprintf('%d: All of the above\n',counter);
while true
 group = input('With what category do you want to play? ');
 if isfloat(group) && group >= 1 && group <= counter
     group = int8(group);
     break
 end
 fprintf('Sorry, that is not a valid input\n');
end
indexofcapletters = find(capletterlcn);
if group == nnz(capletterlcn)+1
    for i = fliplr(indexofcapletters) %must be flipped otherwise removing data messes up the indexes
        words(i) = [];
    end
    possiblewords = words;
else
    if group < nnz(capletterlcn)
        possiblewords = words(1,indexofcapletters(group)+1:indexofcapletters(group+1)-1);
    else 
        possiblewords = words(1,indexofcapletters(group)+1:numwords(2));
    end
end
sizeofpossiblewords = size(possiblewords);
chosenword = cell2mat(possiblewords(randi(sizeofpossiblewords(2))));

%END OF BEGINNING, WORD HAS BEEN CHOSEN
%BEGIN GAME

nfails = 0;
sizeword = size(chosenword);
maxnfails = drawhangman(0);
guessedletters = '';
letter='';
indexofguesses = zeros(1,sizeword(2));
fprintf('Your word is: ');
while nfails < maxnfails+1
    if nfails == maxnfails || nnz(indexofguesses) == sizeword(2)
         if nfails == maxnfails
            fprintf('Uh oh, looks like you lost. Your word was: ');
            fprintf('%c',chosenword);
         elseif nnz(indexofguesses) == sizeword(2)
             fprintf('\nCongratulations! You won!\nYour word was: ');
             fprintf('%c',chosenword);
         end
        playagain = input('\nWould you like to play again?\nType 1 for ''yes'' or 2 for ''no'': ');
        while playagain ~= 1 && playagain ~= 2
            fprintf('I couldn''t understand that input.\n');
            playagain = input('\nWould you like to play again?\nType 1 for ''yes'' or 2 for ''no'': ');
        end
        if playagain == 1
            clear; clc;
            fprintf('Starting new game...\n')
            delete(gca);
            hangman;
        else
            fprintf('Goodbye!\n')
            delete(gca);
            break
        end
    else
        printword(chosenword, indexofguesses, sizeword(2));
        temp = indexofguesses;
        [guessedletters] = getguess(guessedletters);
        indexofguesses = checkanswer(guessedletters(1),chosenword,indexofguesses);
        if nnz(indexofguesses == temp)==sizeword(2) %checks if there was a change in the index of letters that are correct
            fprintf('Sorry! Guess again.\n');
            nfails = nfails+1;
            drawhangman(nfails);
            continue;
        else
            fprintf('That''s correct!\n');
        end   
    end
end
fclose(source);

function printword(word, index, sizeword)
for q = 1:sizeword
    if index(q) == 1
        fprintf('%c ',word(q));
    else
        fprintf('_ ');
    end
end
fprintf('\n');
end

function index  = checkanswer(letter,word,oldindex)
sizeofword = size(word);
for i = 1:sizeofword(2)
    if letter == word(i)
        oldindex(i) = 1;
    end
end
index = oldindex;
end

function [alreadyguessed] = getguess(oldalreadyguessed)
letter = input('Enter a letter with single quotes: ');
while ~isletter(letter) || nnz(letter == oldalreadyguessed)
    if ~isletter(letter)
        fprintf('Sorry, that is not a letter. Please guess again.\n');
    else
        fprintf('Sorry, you have already guessed ''%c''. Please guess again.\n',letter);
    end
    letter = input('Enter a letter with single quotes: ');
end
alreadyguessed = strcat(letter,oldalreadyguessed);
end