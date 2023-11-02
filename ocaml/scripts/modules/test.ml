module Stack =
	struct 
		type 'a elements = {front='a list ; rear='a list}
		let make front rear = 
			match front with
			| [] -> {front=List.rev rear; rear=[]}
			| _ -> {front;rear}
		let empty = {front=[];rear=[]}
		let is_empty = function
		| {front=[];rear=[]} -> true
		| _ -> false
		let size = function
		| {front=front_list;read=rear_list} -> ((List.length front_list)+(List.length rear_list)) 
		| _ -> 0 
		let enqueue el queue = make queue.front (el::queue.rear)
		let dequeue = function
		| {[],[]} -> raise (Error "Empty!")
		| {front=[] ; rear=list} -> pop(make (List.rev list) [])
