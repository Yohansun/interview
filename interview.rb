给一列没有经过排序的数，计算最长的递增序列有几个
str = [1, 3, 5, 4, 7]
a = []
1.时间复杂度
（1）时间频度 一个算法执行所耗费的时间，从理论上是不能算出来的，必须上机运行测试才能知道。
但我们不可能也没有必要对每个算法都上机测试，只需知道哪个算法花费的时间多，哪个算法花费的时间少就可以了。
并且一个算法花费的时间与算法中语句的执行次数成正比例，哪个算法中语句执行次数多，它花费时间就多。
一个算法中的语句执行次数称为语句频度或时间频度。记为T(n)。
2.空间复杂度
一个程序的空间复杂度是指运行完一个程序所需内存的大小
3.背包问题https://github.com/tianyicui/pack/blob/master/V2.pdf

b = 0
def ji(str, p) #p 代表现在的已有最长数组长度
	a = str.each_with_index do |s, i|
		if str[i+1] > str[i]
			next
		else
			if i > p
				len = i
			elsif i == p
				len = p
				a += 1
				b = len
			else
				len = p
			end
			if (str-str[0..i]).size == 0 || len > (str-str[0..i]).size
				return [a, b, len]
			else
				ji(str-str[0..i], len)
			end
		end
	end
end
ji str, 0

3.在计算机世界，我们一直追求用最小的资源产生最大的价值。
现在，假设你可以支配m个0和n个1。同时有一些只有0和1组成的字符串。
你的任务是用这些0和1去组成这些字符串，输出最多能组成多少个字符串。每个0和1只能被使用一次。
样例
输入: Array = {"10", "0001", "111001", "1", "0"}, m = 5, n = 3
输出: 4
解释: 用5个0和3个1可以至多组成4个给定字符串，分别为“10”、”0001”、”1”、”0”。

def count str
  a1, a0 = 0, 0
  str.each_char do |s|
    s == "1" ? a1 += 1 : a0 += 1
  end
  return [a0, a1]
end

string =  ["10110", "01", "10", "011", "101"]
m = 7 # 0的个数
n = 6 # 1的个数
@best_values = Array.new(m + 1) { Array.new(n + 1) }   #最开始所有的都可以设为0
@best_solutions = Array.new
@best_values[0][0] = 0
p @best_values
string.each do |s|
  m.downto(count(s)[0]).each do |i| 
    n.downto(count(s)[1]).each do |j| 
      p " @best_values[i - count(s)[0]][j - count(s)[1]]对应的数组为----- @best_values[#{i - count(s)[0]}][#{j - count(s)[1]}]"
      p @best_values[i - count(s)[0]][j - count(s)[1]]
      p @best_values[i][j]
      @best_values[i][j] = [@best_values[i][j].to_i, @best_values[i - count(s)[0]][j - count(s)[1]].to_i+1].max   
    end 
  end 
end
p "最后数组best_values = #{@best_values}"

4.一个旅行者有一个最多能用M公斤的背包，现在有N件物品，
它们的重量分别是W1，W2，...,Wn,
它们的价值分别为P1,P2,...,Pn.
若每种物品只有一件求旅行者能获得最大总价值。

class KnapSack  
  attr_reader :weight, :value  
  attr_writer :weight, :value  
    
  def initialize(weight, value)  
    @weight = weight  
    @value = value   
  end  
    
  def to_s  
    "{weight:#{weight}, value:#{value}}"  
  end  
end  

class KnapsackProblem  
    
  def solve 
  	@bags = [KnapSack.new(2, 13), KnapSack.new(1, 10), KnapSack.new(3, 24), KnapSack.new(2, 15),   
            KnapSack.new(4, 28), KnapSack.new(5, 33), KnapSack.new(3, 20), KnapSack.new(1, 8)]  #代表 它们的重量分别是W1，W2，...,Wn,它们的价值分别为P1,P2,...,Pn.

    puts '给定背包也可称作给定的物品:'  
    @bags.each do |bag|  
      puts "物品种量和价值分别为： #{bag.to_s}"
    end  
    puts '给定总称重: ' + @total_weight.to_s  
      
    @total_weight = 13 
    @n =  @bags.length  
    @best_values = Array.new(@n + 1) { Array.new(@total_weight + 1) }   
	  @best_solutions = Array.new

	  (0..@n).each do |i| 
    	(0..@total_weight).each do |j|   
        if i == 0 || j == 0  
          @best_values[i][j] = 0  
          p "当i.j都等于0时best_value = = = #{@best_values}"
        else  
          if j < @bags[i - 1].weight
            @best_values[i][j] = @best_values[i - 1][j]  
            p "当前物品个数i:#{i}，，，，，，，当前重量j:#{j}   j < @bags[#{i - 1}].weight时#{@best_values}, 输出  @best_values[#{i - 1}][#{j}]= #{@best_values[i - 1][j]  }  "  
          else  
            iweight = @bags[i - 1].weight  
            ivalue = @bags[i - 1].value  
            @best_values[i][j] = [@best_values[i - 1][j], ivalue + @best_values[i - 1][j - iweight]].max  
            p "[][][][][][][][][][][][][][]#{ [@best_values[i - 1][j], ivalue + @best_values[i - 1][j - iweight]]}"
            p "当前物品个数i=======#{i}，，，，，，，当前重量j=======#{j}  iweight#{iweight} ivalue#{ivalue}       #{@best_values}"  
          end  
        end  
      end  
    end    
    p "最后数组best_values = #{@best_values}"
      
    temp_weight = @total_weight  
    @n.downto(1).each do |i|  
    	p "i为  #{i}, temp_weight为    #{temp_weight}------@best_values[#{i}][#{temp_weight}]=#{@best_values[i][temp_weight]}  @best_values[#{i}][#{temp_weight}]=#{@best_values[i-1][temp_weight]} "
      if @best_values[i][temp_weight] > @best_values[i - 1][temp_weight]  
      	p "@bags[#{i-1}])  -----》 #{@bags[i - 1]}"
        @best_solutions.push(@bags[i - 1])  
        temp_weight -= @bags[i - 1].weight  
        if temp_weight == 0  
          break  
        end  
      end  
      @best_value = @best_values[@n][@total_weight]  
    end    
  end  

  #一维数组解决方法
  def solve2
    @bags = [KnapSack.new(2, 13), KnapSack.new(1, 10), KnapSack.new(3, 24), KnapSack.new(2, 15),   
        KnapSack.new(4, 28), KnapSack.new(5, 33), KnapSack.new(3, 20), KnapSack.new(1, 8)]  #代表 它们的重量分别是W1，W2，...,Wn,它们的价值分别为P1,P2,...,Pn.

    puts '给定背包也可称作给定的物品:'  
    @bags.each do |bag|  
      puts "物品种量和价值分别为： #{bag.to_s}"
    end  
    puts '给定总称重: ' + @total_weight.to_s  
      
    @total_weight = 13 
    @n =  @bags.length  
    @best_solutions = Array.new(@total_weight + 1)

    (0..@n).each do |i| 
      @total_weight.downto(1).each do |j|   
        if j >= @bags[i - 1].weight
          iweight = @bags[i - 1].weight  
          ivalue = @bags[i - 1].value  
          @best_solutions[j] = [@best_solutions[j].to_i, ivalue + @best_solutions[j - iweight].to_i].max  
        end  
      end  
    end    
    p @best_solutions
    
  end
end  

#背包问题求价值最大化数祖都设为0，求装慢的话 价值可以设为负无穷
