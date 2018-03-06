library('R6')
library('assertive')
TuringMachine <- R6Class(
  private = list(..step = 1,
                 ..tape = c(0),
                 ..position = 1,
                 ..states = list('A'=list('0'=c(1,'right','B'),
                                          '1'=c(1,'left','C')),
                                 'B'=list('0'=c(1,'left','A'),
                                          '1'=c(1,'right','B')),
                                 'C'=list('0'=c(1,'left','B'),
                                          '1'=c(1,'right','HALT')),
                                 'HALT'="None"),
                 ..current_state = 'HALT'),
  active = list(
     step = function(value) {
       if(missing(value)){
         private$..step
       }else{
         assert_is_a_number(value)
         private$..step <- value
       }
     },
     tape = function(value) {
       if(missing(value)){
         private$..tape
       }else{
         assert_is_atomic(value)
         private$..tape <- value
       }
     },
     position = function(value) {
       if(missing(value)){
         private$..position
       }else{
         assert_is_a_number(value)
         private$..position <- value
       }
     },
     states = function(value) {
       if(missing(value)){
         private$..states
       }else{
         assert_is_list(value)
         private$..states <- value
       }
     },
     tape_str = function() {
       s <- '[--'
       i <- 1
       for (t in private$..tape) {
         if (i == private$..position) {
           join_str <- paste0('(',t,')--')
         } else {
           join_str <- paste0(' ',t,' --')
         }
         s = paste0(s,join_str)
         i = i + 1
       }
       return(paste0(s,']'))
     }
     
     ),
  public = list(
    initialize = function(step, tape, position, states) {
      if(!missing(states)) {
        private$..states <- states
      }
      if(!missing(position)) {
        private$..position <- position
      }
      if(!missing(tape)) {
        private$..tape <- tape
      }
      if(!missing(step)) {
        private$..step <- step
      }
    },
    extend_tape = function(direction){
      if (direction == 'left') {
        private$..tape <- c(0,private$..tape)
        private$..position <- private$..position + 1
      } else if (direction == 'right') {
        private$..tape <- c(private$..tape,0)
      }
    },
    write_pos = function(position,symbol) {
      private$..tape[position] <- symbol
    },
    move = function(direction) {
      pos_list <- list('left'=-1,'right'=1)
      new_pos <- private$..position + pos_list[[direction]]
      if ((new_pos < 1) | (new_pos > length(private$..tape))) {
        self$extend_tape(direction)
      }
      private$..position <- private$..position + pos_list[[direction]]
    },
    command_report = function(params) {
      cat(paste0('Step ',private$..step,': Execute ',private$..current_state,' at position',self$tape_str,
                 ': write ',params[1],', move ',params[2],', execute ',params[3],'\n'))
    },
    halt = function() {
      cat(paste0('Execution ended on step ',private$..step,' (HALT) command.\nFinal state: ',self$tape_str,'\n\n'))
      private$..step <- 1
    },
    interrupt = function() {
      cat(paste0('Execution interrupted (reached step limit).\nFinal state: ',self$tape_str,'\n\n'))
      private$..step <- 1
    },
    reset = function() {
      private$..step <- 1
      private$..position <- 1
      private$..tape <- c(0)
    },
    set_tape = function(tape){
      self$reset()
      private$..tape <- tape
    },
    execute_state = function(state, max_steps) {
      if (missing(max_steps)) {
        max_steps <- 'Inf'
      }
      while (TRUE) {
        if (state %in% names(private$..states)) {
          if (state == 'HALT') {
            self$halt()
            return(self$tape_str)
          } else if (private$..step <= max_steps) {
            private$..current_state <- state
            params <- private$..states[[state]][[toString(private$..tape[private$..position])]]
            self$command_report(params)
            self$write_pos(private$..position,params[1])
            self$move(params[2])
            state <- params[3]
            private$..step <- private$..step + 1
            Sys.sleep(0.1)
          } else {
            self$interrupt()
            return(self$tape_str)
          }
        } else {
          print(paste0('Error: Unknown state: ',state,'!'))
          return(-1)
        }
      }
    }
  )
)


machine <- TuringMachine$new()
machine$execute_state('A')