require 'multiset'

def sortWordLen(txt)
  #Sort the words in the txt file based on the length of the words
  file = File.open(txt)
  contents = file.readlines
  for i in 0...contents.length
    contents[i] = contents[i].gsub("\n",'')
  end
  @sort = contents.sort_by { |x| x.length}
end

def wordsByLength
  #Put words with the same length into an array, with the index of the array matching the number of letters in the words
  @wordsLenArr = Array.new(33)    #the size of the array matches with the longest word length
  for i in 0.. @wordsLenArr.length
    @wordsLenArr[i] = Array.new
  end
  @sort.each do |x|
    @wordsLenArr[x.length] << x
  end
  return @wordsLenArr
end

def checkWords(w)
  #A recursive call to check if a n-letter word contains a n-1-letter word
  #Start with the longest word and check backward
  if w.length <= 3
    ar = Array.new
    ar << w
    return ar
  else
    bag = Multiset.new(w.split(//))
    @wordsLenArr[w.length-1].each do |ele|
      if bag.superset?(Multiset.new(ele.split(//)))
        arr = Array.new
        arr << w
        return arr + checkWords(ele)
      end
    end
  end
end

def findWord(file)
  #The main function that calls the methods above, loop through the two arrays created and check words
  sortWordLen(file)
  for i in (33).downto(0)
    for x in 0...wordsByLength[i].length
      arr = checkWords(wordsByLength[i][x])
      if !arr[-1].nil? && arr[-1].length == 3
        puts arr
        return 0
      end
    end
  end
end

findWord('The txt file you want to run')
