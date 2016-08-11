module Enumerable
	def my_each 
		return enum_for(:my_each) unless block_given?
		for i in (0...self.length)
			yield(self[i])
		end
		return self
	end

	def my_each_with_index
		return enum_for(:my_each_with_index) unless block_given?
		for i in (0...self.length)
			yield(self[i],i)
		end
		return self
	end

	def my_select
		return enum_for(:my_select) unless block_given?
		result = []
		self.my_each do |x|
			result << x if yield(x)
		end
		return result
	end

	def my_all?
		if block_given?
			self.my_each do |x|
				return false unless yield(x)
			end
			return true
		else
			self.my_each do |x|
				return false unless x
			end
			return true
		end
	end

	def my_any?
		if block_given?
			self.my_each do |x|
				return true if yield(x)
			end
			return false
		else
			self.my_each do |x|
				return true if x
			end
			return false
		end
	end

	def my_none?
		if block_given?	
			self.my_each do |x|
				return false if yield(x)
			end
			return true
		else
			self.my_each do |x|
				return false if x
			end
			return true
		end
	end

	def my_count *arg
		return self.length unless block_given? || arg != []
		count = 0
		if block_given?
			self.each do |x|
				if yield(x)
					count+=1
				end
			end
		else
			self.each do |x|
				if x == arg[0]
					count +=1
				end
			end
		end
		return count
	end

	def my_map proc=nil

		if proc.class == "Proc"
			arr = []
			self.each do |x|
				arr << proc.call(x)
			end
			return arr
		elsif block_given?
			arr = []
			self.each do |x|
				arr << yield(x)
			end
			return arr	
		else
			return self.to_enum(:my_map)
		end
	end

	def my_inject total=nil
		if total
			self.each do |x|
				total = yield(total,x)
			end
		else
			total = self[0]
			self[1..-1].each do |x|
				total = yield(total,x)
			end
		end
		return total
	end

	def multiply_els 
		self.my_inject do |prod,n|
			prod*n
		end
	end
end






#[0,1,2,3,4].my_each { |x| puts x}
#a = %w{ a b c d e f }
#p a.my_select {|v| v =~ /[aeiou]/ }
#p %w[ant bear cat].my_all? { |word| word.length >= 4 }
#p %w[ant bear cat].my_any? { |word| word.length >= 3 }
#p %w{ants bear cat}.my_none? { |word| word.length == 5 }
#p [nil,false].my_none?
#p (1..4).map { |i| i*i } 
#p [2,4,5].multiply_els


