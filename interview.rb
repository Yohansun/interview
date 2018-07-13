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
#https://www.jianshu.com/p/d8e681b46e50
#bfs＝队列，入队列，出队列；dfs=栈，压栈，出栈
	    
#mysql索引的最左匹配原则？


#mysql存储引擎有哪些？优缺点有哪些？

*MyISAM引擎是一种非事务性的引擎，提供高速存储和检索，以及全文搜索能力，适合数据仓库等查询频繁的应用。MyISAM中，一个table实际保存为三个文件，.frm存储表定义，.MYD存储数据,.MYI存储索引。  NULL值被允许在索引的列中。
*InnoDB:一个事务安全的存储引擎
*区别：
*1.InnoDB不支持FULLTEXT类型的索引。
*2.InnoDB 中不保存表的具体行数，也就是说，执行select count(*) from table时，InnoDB要扫描一遍整个表来计算有多少行，但是MyISAM只要简单的读出保存好的行数即可。注意的是，当count(*)语句包含 where条件时，两种表的操作是一样的。
*3.对于AUTO_INCREMENT类型的字段，InnoDB中必须包含只有该字段的索引，但是在MyISAM表中，可以和其他字段一起建立联合索引。
*.DELETE FROM table时，InnoDB不会重新建立表，而是一行一行的删除。
*另外，InnoDB表的行锁也不是绝对的，如果在执行一个SQL语句时MySQL不能确定要扫描的范围，InnoDB表同样会锁全表，例如update table set num=1 where name like “%aaa%”
*可以用 show create table tablename 命令看表的类型。
*2.1 对不支持事务的表做start/commit操作没有任何效果，在执行commit前已经提交
*可以执行以下命令来切换非事务表到事务(数据不会丢失)，innodb表比myisam表更安全：
*alter table tablename type=innodb;
*MyISAM存储引擎的读锁和写锁是互斥的，读写操作是串行的。那么，一个进程请求某个MyISAM表的读锁，同时另一个进程也请求同一表的写锁，MySQL如何处理呢？答案是写进程先获得锁。不仅如此，即使读请求先到锁等待队列，写请求后到，写锁也会插到读锁请求之前！这是因为MySQL认为写请求一般比读请求要重要。这也正是MyISAM表不太适合于有大量更新操作和查询操作应用的原因，因为，大量的更新操作会造成查询操作很难获得读锁，从而可能永远阻塞。这种情况有时可能会变得非常糟糕！myisam是有读锁和写锁(2个锁都是表级别锁)。
*MySQL表级锁有两种模式：表共享读锁（Table Read Lock）和表独占写锁（Table Write Lock）。什么意思呢，就是说对MyISAM表进行读操作时，它不会阻塞其他用户对同一表的读请求，但会阻塞 对同一表的写操作；而对MyISAM表的写操作，则会阻塞其他用户对同一表的读和写操作。

#mysql有哪几类锁？每类锁的优点和缺点

*页级:引擎 BDB。
*表级:引擎 MyISAM ， 理解为锁住整个表，可以同时读，写不行
*行级:引擎 INNODB ， 单独的一行记录加锁
*MySQL表级锁有两种模式：表共享读锁（Table Read Lock）和表独占写锁（Table Write Lock）。什么意思呢，就是说对MyISAM表进行读操作时，它不会阻塞其他用户对同一表的读请求，但会阻塞 对同一表的写操作；而对MyISAM表的写操作，则会阻塞其他用户对同一表的读和写操作。
*原子性（Atomicity）：事务是一个原子操作单元，其对数据的修改，要么全部执行，要么全都不执行；
*一致性（Consistent）：在事务开始和完成时，数据都必须保持一致状态；
*隔离性（Isolation）：数据库系统提供一定的隔离机制，保证事务在不受外部并发操作影响的“独立”环境执行；
*持久性（Durable）：事务完成之后，它对于数据的修改是永久性的，即使出现系统故障也能够保持。
*1）共享锁：允许一个事务去读一行，阻止其他事务获得相同数据集的排他锁。
*    ( Select * from table_name where ......lock in share mode)

*2）排他锁：允许获得排他锁的事务更新数据，阻止其他事务取得相同数据集的共享读锁和  排他写锁。(select * from table_name where.....for update)
*   为了允许行锁和表锁共存，实现多粒度锁机制；同时还有两种内部使用的意向锁（都是表锁），分别为意向共享锁和意向排他锁。
*   InnoDB行锁是通过给索引项加锁来实现的，即只有通过索引条件检索数据，InnoDB才使用行级锁，否则将使用表锁！
*   InnoDB行锁是通过给索引项加锁来实现的，即只有通过索引条件检索数据，InnoDB才使用行级锁，否则将使用表锁！扩展
*   InnoDB行锁是通过给索引项加锁来实现的，即只有通过索引条件检索数据，InnoDB才使用行级锁，否则将使用表锁！
#mysql水平扩展和垂直扩展的区别，如何水平扩展和垂直扩展？带来哪些复杂度。比如如何支持事务？
*垂直扩展，不是增加系统成员的数量，而是扩展系统现有系统部件（读操作，增加memcashed 或者增加cdn）
*水平扩展，不是通过增加单个系统部件来扩展，而是增加系统工程院数量
	
*水平的拆分的方案，即不改动数据库表结构。通过对表中数据的拆分而达到分片的目的：
*1）使用用户id做hash，分解数据库，在訪问数据库的使用用户id做路由。
*2）将产品订单表依照已下单和未下单区分成两个表。
*	主从复制
*	集群(Clustering)
*	分片(Sharding)
*	https://blog.csdn.net/weixin_39684625/article/details/79528321
*垂直拆分的方案：将表和表分离，或者改动表结构，依照訪问的差异将某些列拆分出去。
*1）将用户信息表放到一个数据库server，将产品订单表放到一个数据库server。
*2）将用户信息表中主码（通常是user id）和一些经常使用的信息放到一个表，将主码和不经常使用的信息放到另外的表。这导致一般查询数据的时候可能会用到join操作。
	
*两张方式共同缺点
*        1. 引入分布式事务的问题。
*        2. 跨节点Join 的问题。
*        3. 跨节点合并排序分页问题。
*处理原来单机中跨业务的事务。一种办法是使用分布式事务，其性能要明显低于之前的单机事务；而另一种办法就是去掉事务或者不去追求强事务支持



#1.微服务系统


这个例子是两种方式计算阶乘的javascript代码实现，可以在浏览器中，按F12调出控制台，在控制台中进行实验。// 迭代，重复一定的算法，达到想要的目的。数学上二分法，牛顿法是很好的迭代例子
function iteration(x){
   var sum=1; 
   for(x; x>=1; x--){
       sum = sum*x;
   }
}
// 递归，自身调用自身的迭代就是递归。
// 但是正式定义好像不是这么说的。这只是我个人理解
function recursion(x){
   if(x>1){
       return x*recursion(x-1);
   }else{
       return 1;
   }
}
