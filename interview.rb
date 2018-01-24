#给一列没有经过排序的数,计算最长的递增子序列有几个
def ji(str, a=[]) #p 代表现在的已有最长数组长度
  str.each_with_index do |s, i|
    if str[i+1].to_i > str[i]
      next
    else
      a << str[0..i]
      if (str-str[0..i]).size < 1
        return a
      else
        ji(str-str[0..i], a)
      end
    end
  end
end
str = [1, 3, 5, 4, 7]
ji(str, a=[])
p a



3.在计算机世界,我们一直追求用最小的资源产生最大的价值。
现在,假设你可以支配m个0和n个1。同时有一些只有0和1组成的字符串。
你的任务是用这些0和1去组成这些字符串,输出最多能组成多少个字符串。每个0和1只能被使用一次。
样例
输入: Array = {"10", "0001", "111001", "1", "0"}, m = 5, n = 3
输出: 4
解释: 用5个0和3个1可以至多组成4个给定字符串,分别为“10”、”0001”、”1”、”0”。

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

4.一个旅行者有一个最多能用M公斤的背包,现在有N件物品,
它们的重量分别是W1,W2,...,Wn,
它们的价值分别为P1,P2,...,Pn.
若每种物品只有一件求旅行者能获得最大总价值。
!关键在于第n个物品被不被选中
if n < 0 的话 直接就是 Value(n, w) = 0
Value(n-1, w)  if Weight_i > 总的重量的话
剩余的情况就是 Value(n, w) = [Value(n-1, w), Value(n-1, w-wi)+ivalue].max
solove2 直接判断other的情况 

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
            KnapSack.new(4, 28), KnapSack.new(5, 33), KnapSack.new(3, 20), KnapSack.new(1, 8)]  #代表 它们的重量分别是W1,W2,...,Wn,它们的价值分别为P1,P2,...,Pn.

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
            p "当前物品个数i:#{i},当前重量j:#{j}   j < @bags[#{i - 1}].weight时#{@best_values}, 输出  @best_values[#{i - 1}][#{j}]= #{@best_values[i - 1][j]  }  "  
          else  
            iweight = @bags[i - 1].weight  
            ivalue = @bags[i - 1].value  
            @best_values[i][j] = [@best_values[i - 1][j], ivalue + @best_values[i - 1][j - iweight]].max  
            p "[][][][][][][][][][][][][][]#{ [@best_values[i - 1][j], ivalue + @best_values[i - 1][j - iweight]]}"
            p "当前物品个数i=======#{i},当前重量j=======#{j}  iweight#{iweight} ivalue#{ivalue}       #{@best_values}"  
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
        @best_solutions.push(@bags[i])  
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
        KnapSack.new(4, 28), KnapSack.new(5, 33), KnapSack.new(3, 20), KnapSack.new(1, 8)]  #代表 它们的重量分别是W1,W2,...,Wn,它们的价值分别为P1,P2,...,Pn.

    puts '给定背包也可称作给定的物品:'  
    @bags.each do |bag|  
      puts "物品种量和价值分别为： #{bag.to_s}"
    end  
    puts '给定总称重: ' + @total_weight.to_s  
      
    @total_weight = 13 
    @n =  @bags.length  
    @best_solutions = Array.new(@total_weight + 1)
    @aaaa = []
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

#背包问题求价值最大化数祖都设为0,求装慢的话 价值可以设为负无穷
#JAVA面试中的问题,一个场景：微博热搜排序,需要获得热搜前十名,数据量在百万级别,需要一秒刷新一次？
#问题如题,困扰了很长时间了，可以是一个算法，可以是一个新技术，也可以是一个思想，最好考虑到成本以及空间复杂度，时间复杂度，请大神们给一个思路，拜谢
#https://www.zhihu.com/question/57968453

字符串"[()]]" 判断括号是否对 利用栈 左括号入栈 然后比较来的如果是右括号 看栈里面有没有对应的 

面试题：实现的最优二叉查找树算法
a = ['', 'k1', 'k2', 'k3', 'k4', 'k5']
p = [0, 0.15, 0.10, 0.05, 0.10, 0.20]
q = [0.05, 0.10, 0.05, 0.05, 0.05 ,0.10]
e = Array.new(a.size + 1){Array.new(a.size + 1)}
root = Array.new(a.size + 1){Array.new(a.size + 1)}

def optimalBST(p, q, n, e, root)
  w = Array.new(p.size + 1){Array.new(p.size + 1)}
  (1..n+1).each do |i|
    e[i][i - 1] = q[i - 1]
    w[i][i - 1] = q[i - 1]
  end
  (1..n).each do |l|
    for i in (1..n - l + 1)
      j = i + l -1
      e[i][j] = 1 / 0.0
      w[i][j] = w[i][j - 1] + p[j] + q[j]
      for r in (i..j)
        t = e[i][r - 1] + e[r + 1][j] + w[i][j]
        if t < e[i][j]
          e[i][j] = t
          root[i][j] = r
        end
      end
    end
  end
end

def printBST(root, i ,j, signal)
  return if i > j
  if signal == 0
   p "k#{root[i][j]} is the root of the tree."
   signal = 1
  end
  r = root[i][j]
  #left child
  if r - 1< i
    p "d#{r - 1} is the left child of k#{r}."
  else
    p "k#{root[i][r - 1]} is the left child of k#{r}."
    printBST(root, i, r - 1, 1 )
  end
  #right child
  if r >= j
     p "d#{r} is the right child of k#{r}."
  else
    p "k#{root[r + 1][j]} is the right child of k#{r}."
    printBST(root, r + 1, j, 1)
  end
  
end

optimalBST(p, q, p.size - 1, e, root)
printBST(root, 1, a.size-1, 0)
puts "\nThe expected cost is #{e[1][a.size-1]}."

class EmptyNode
  # 预留给查询用
  def include?(*)
    false
  end

  def insert(*)
    false
  end

  def inspect
    "{}"
  end
  
end


class Node

  attr_reader :value
  attr_accessor :left, :right

  def initialize(v)
    @value = v
    @left = EmptyNode.new
    @right = EmptyNode.new
  end

  def inspect
    "{#{value}::#{left.inspect}|#{right.inspect}}"
  end

  def insert(v)
    case value <=> v
      when 1 then insert_left(v)
      when -1 then insert_right(v)
      when 0 then false
    end
  end

  private
    # 插入时不再需要nil判断, 空节点的insert返回false
    def insert_left(v)
      left.insert(v) or @left = Node.new(v)
    end

    def insert_right(v)
      right.insert(v) or @right = Node.new(v)
    end

end