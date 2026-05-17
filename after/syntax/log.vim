syntax match logTag '<[^>]\+>'

syntax case match

syntax keyword logLvTiming  TIM
syntax keyword logLvTrace   TRC
syntax keyword logLvDebug   DBG
syntax keyword logLvInfo    INF
syntax keyword logLvWarning WRN
syntax keyword logLvNotice  NTC

syntax case ignore

hi def link logTag Function
hi def link logLvTiming Operator
