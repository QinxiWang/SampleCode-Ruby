require 'set'
require 'thread'

def creatDic(txt)
  #read the file in and separate each word by eliminating the /n
  file = File.open(txt)
  @validwords = file.readlines
  for i in 0...@validwords.length
    @validwords[i] = @validwords[i].gsub("\n",'')
  end
end

def findPath(w1,w2)
  #the main idea is to use the BFS with a queue to find the shortest path
  if !@validwords.include?(w1) || !@validwords.include?(w2)
    puts "invalid inputs"
  end
  #first check if the two input words are valid
  queue = Queue.new
  path = Array.new
  checked = Set.new
  path << w1
  queue << path
  while !queue.empty?
    temppath = queue.shift               #dequeue
    tempword = temppath.last
    for i in 0...tempword.length         #loop through the length of the word and the 26 letters to generate all the possible nextword
      for char in 'A'..'Z'
        nextword = tempword.gsub(tempword[i],char)
        if @validwords.include?(nextword)
          if !temppath.include?(nextword) && !checked.include?(nextword)   #make sure the word has not been used in the path or been checked before
            if nextword == w2
              temppath << w2
              puts temppath              #the loop ends after found the destination word
              return
            else
              copy = temppath.dup       #make a shallow copy of the temppath
              copy << nextword          #add the word into the copy of the path
              queue << copy             #enqueue the copy
              checked.add(nextword)
            end
          end
        end
      end
    end
  end
  puts "NO PATH FOUND"
end

creatDic(".txt")
findPath("word","word2")
