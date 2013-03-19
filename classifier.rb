require 'mongo'
require 'json'
require 'wordnet'
require 'twitter'

class Classifier
include Mongo

    def initialize
    	db = Connection.new.db("rockbreakers")
    	tweets = db.collection('tweets')
    end
    
    def binary_svm_classifiers
    end
end

class Tweet
    attr_accessor :synset, :hypernym, :unigram, :bigram,
		  :trigram, :sig_word, :lda, :contains_q,
		  :contains_e, :text, :id

    def initialize(text, id)
    	@text = text
    	@id = id
        @unigram = {}
        @bigram = {}
        @trigram = {}

    	gen_shingling
    end

    def topics
    end

    def gen_shingling
    	unigram
    	bigram
    	trigram
    end

    private
    #are these based on words or characters?
    #currently characters
    def unigram
     @text.split.each{ |word|
        @unigram[temp] = 1
     }
    end

    def bigram
     temp = ""
     @text.split.each{ |word|
        temp << word
        if count % 2 == 0
            @bigram[temp] = 1
            temp = "#{word}"
            count = 1       
        end
        }
    end
    
    def trigram
     temp = ""
     @text.split.each{ |word|
        temp << word
        if count % 3 == 0
            @trigram[temp] = 1
            temp = temp[1..2]
            count = 2       
        end
        count += 1
        }
    end
end
