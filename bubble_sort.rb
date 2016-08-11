def bubble_sort arr 
	return bubble_sort_by(arr) {|left,right| left-right}
end

def bubble_sort_by arr
	return p arr unless block_given?
	result = []
	arr.map {|item| result << item}
	vals_left = result.length 
	until vals_left == 0
		last_swap = 0
		for i in (1..vals_left-1)
			if yield(result[i-1],result[i]) > 0
				result[i-1],result[i] = result[i],result[i-1]
				last_swap = i
			end
		end
		vals_left = last_swap
	end


	return p result
end


bubble_sort([4,3,78,2,0,2,7,29,2])
bubble_sort_by(["hi","hello","hey"]) do |left,right|
	left.length - right.length
end
