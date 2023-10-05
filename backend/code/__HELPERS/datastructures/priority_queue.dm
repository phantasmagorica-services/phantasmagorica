/**
 * array-backed priority heap
 */
/datum/priority_queue
	var/list/array
	var/comparison_function

/datum/priority_queue/New(compare)
	array = list()
	comparison_function = compare

/datum/priority_queue/proc/is_empty()
	return !length(array)

/datum/priority_queue/proc/enqueue(data)
	array.Add(data)
	var/index = array.len

	//From what I can tell, this automagically sorts the added data into the correct location.
	while(index > 2 && call(comparison_function)(array[index / 2], array[index]) > 0)
		array.Swap(index, index / 2)
		index /= 2

/datum/priority_queue/proc/dequeue()
	if(!array.len)
		return 0
	return remove(1)

/datum/priority_queue/proc/remove(index)
	if(index > array.len)
		return 0

	var/thing = array[index]
	array.Swap(index, array.len)
	--array.len
	if(index < array.len)
		fix_queue(index)
	return thing

/datum/priority_queue/proc/fix_queue(index)
	var/child = 2 * index
	var/item = array[index]

	while(child <= array.len)
		if(child < array.len && call(comparison_function)(array[child], array[child + 1]) > 0)
			child++
		if(call(comparison_function)(item, array[child]) > 0)
			array[index] = array[child]
			index = child
		else
			break
		child = 2 * index
	array[index] = item

/datum/priority_queue/proc/clone_list()
	return array.Copy()

/datum/priority_queue/proc/size()
	return length(array)

/datum/priority_queue/proc/remove_item(item)
	var/index = array.Find(item)
	if(index)
		return remove(index)
