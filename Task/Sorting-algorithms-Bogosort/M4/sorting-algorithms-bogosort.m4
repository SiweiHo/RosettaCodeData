divert(-1)
define(`randSeed',141592653)
define(`setRand',
   `define(`randSeed',ifelse(eval($1<10000),1,`eval(20000-$1)',`$1'))')
define(`rand_t',`eval(randSeed^(randSeed>>13))')
define(`random',
   `define(`randSeed',eval((rand_t^(rand_t<<18))&0x7fffffff))randSeed')
define(`for',
   `ifelse($#,0,``$0'',
   `ifelse(eval($2<=$3),1,
   `pushdef(`$1',$2)$4`'popdef(`$1')$0(`$1',incr($2),$3,`$4')')')')
define(`set',`define(`$1[$2]',`$3')')
define(`new',`set($1,size,0)')
define(`get',`defn($1[$2])')
define(`append',
   `set($1,size,incr(get($1,size)))`'set($1,get($1,size),$2)')
define(`deck',
   `new($1)for(`x',1,$2,
         `append(`$1',random)')')
define(`show',
   `for(`x',1,get($1,size),`get($1,x)`'ifelse(x,get($1,size),`',`, ')')')
define(`swap',`set($1,$2,get($1,$4))`'set($1,$4,$3)')
define(`shuffle',
   `for(`x',1,get($1,size),
      `swap($1,x,get($1,x),eval(1+random%get($1,size)))')')
define(`inordern',
   `ifelse(eval($2>=get($1,size)),1,
      1,
      `ifelse(eval(get($1,$2)>get($1,incr($2))),1,
         0,
         `inordern(`$1',incr($2))')')')
define(`inorder',`inordern($1,1)')
define(`bogosort',
   `ifelse(inorder(`$1'),0,`nope shuffle(`$1')`'bogosort(`$1')')')
divert

deck(`b',6)
show(`b')
bogosort(`b')
show(`b')
