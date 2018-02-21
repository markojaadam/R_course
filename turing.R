current_state <- 'None'
step <- 1
tape <- c(0)
position <- 1

states <- list('A'=list('0'=c(1,'right','B'),
                        '1'=c(1,'left','C')),
               'B'=list('0'=c(1,'left','A'),
                        '1'=c(1,'right','B')),
               'C'=list('0'=c(1,'left','B'),
                        '1'=c(1,'right','HALT')),
               'HALT'="None")

extend_tape <- function(direction){
  if (direction == 'left') {
    tape <<- c(0,tape)
    position <<- position + 1
  } else if (direction == 'right') {
    tape <<- c(tape,0)
  }
}

write_pos <- function(position,symbol) {
  tape[position] <<- symbol
}

move <- function(direction) {
  pos_list <- list('left'=-1,'right'=1)
  new_pos <- position + pos_list[[direction]]
  if ((new_pos < 1) | (new_pos > length(tape))) {
    extend_tape(direction)
  }
  position <<- position + pos_list[[direction]]
}

tape_str <- function() {
  s <- '[--'
  i <- 1
  for (t in tape) {
    if (i == position) {
      join_str <- paste0('(',t,')--')
    } else {
      join_str <- paste0(' ',t,' --')
    }
    s = paste0(s,join_str)
    i = i + 1
  }
  return(paste0(s,']'))
}

command_report <- function(params) {
  cat(paste0('Step ',step,': Execute ',current_state,' at position',tape_str(),
               ': write ',params[1],', move ',params[2],', execute ',params[3],'\n'))
}

halt <- function() {
  cat(paste0('Execution ended on step ',step,' (HALT) command.\nFinal state: ',tape_str(),'\n\n'))
  step <<- step + 1
}

interrupt <- function() {
  cat(paste0('Execution interrupted (reached step limit).\nFinal state: ',tape_str(),'\n\n'))
  step <<- step + 1
}

reset <- function() {
  step <<- 1
  position <<- 1
  tape <<- c(0)
}

execute_state <- function(state, max_steps) {
  if (missing(max_steps)) {
    max_steps <- 'Inf'
  }
  while (TRUE) {
    if (state %in% names(states)) {
      if (state == 'HALT') {
        halt()
        return(tape_str())
      } else if (step <= max_steps) {
        current_state <<- state
        params <- states[[state]][[toString(tape[position])]]
        command_report(params)
        write_pos(position,params[1])
        move(params[2])
        state <- params[3]
        step <<- step + 1
        Sys.sleep(0.5)
      } else {
        interrupt()
        return(tape_str())
      }
    } else {
      print(paste0('Error: Unknown state: ',state,'!'))
      return(-1)
    }
  }
}

execute_state('A')
