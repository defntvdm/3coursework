from secrets import choice

cdef remove_rand(chain, removed):
	'''Удаляет произвольную вершину из цепи, кроме начальной и конечной'''
	cdef int h = len(chain)
	cdef int w = len(chain[0])
	cdef int max_removed = w*h - 1
	chain[0][0] = False
	cdef int i = choice(range(h))
	cdef int j = choice(range(w))
	while not chain[i][j] and removed < max_removed:
		i = choice(range(h))
		j = choice(range(w))
	chain[0][0] = True
	chain[i][j] = False
	return (i, j)

cdef get_path(chain):
	'''Возвращает путь от начала цепи до её конца (поиск в ширину)'''
	queue = [(0, 0)]
	parent = {(0, 0): None}
	cdef int h = len(chain) - 1
	cdef int w = len(chain[0]) - 1
	cdef int i
	cdef int j
	visited = [[False for i in range(w + 1)] for j in range(h + 1)]
	path = []
	cdef int new_i
	cdef int new_j
	while queue:
		i, j = queue.pop(0)
		if visited[i][j]:
			continue
		visited[i][j] = True
		for new_i, new_j in ((i+1, j), (i, j+1), (i+1, j+1)):
			if new_i > h or new_j > w:
				continue
			elif new_i == h and new_j == w:
				curr = (i, j)
				while curr:
					path.append((curr))
					curr = parent[curr]
				path.reverse()
				return path
			else:
				if chain[new_i][new_j]:
					parent[(new_i, new_j)] = (i, j)
					queue.append((new_i, new_j))
	return path

cpdef start_experiment(w, h):
	'''Проведение одного эксперимента'''
	chain = [[True for j in range(w)]for i in range(h)]
	chain[h - 1][w - 1] = True
	cdef int ret = 0
	path = get_path(chain)
	while path:
		node = remove_rand(chain, ret)
		ret += 1
		while node in path:
			node = remove_rand(chain, ret)
			ret += 1
		path = get_path(chain)
	return ret
