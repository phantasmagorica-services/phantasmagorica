/**
 * returns tag, or ref, of a datum
 *
 * why? because we can sometimes tag things instead of use a direct ref, as tags don't get reused. (hopefully.)
 */
/proc/REF(datum/D)
	return istype(D)? (isnull(D.tag)? ref(D) : D.tag) : ref(D)
