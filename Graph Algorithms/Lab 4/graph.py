class Vertex:
    def __init__(self, label, min_start_time, min_finish_time, max_start_time, max_finish_time, duration):
        self.label = label
        self.min_start_time = min_start_time
        self.min_finish_time = min_finish_time
        self.max_start_time = max_start_time
        self.max_finish_time = max_finish_time
        self.duration = duration

    def __eq__(self, other):
        return self.label == other.label

    def __hash__(self):
        return hash(self.label)

    def __str__(self):
        return f"{self.label}: Min-Time: {self.min_start_time}->{self.min_finish_time}      " \
               f"Max-Time: {self.max_start_time}->{self.max_finish_time}   Duration: {self.duration}"

    def __repr__(self):
        return self.label


class DirectedGraph:
    def __init__(self):
        self._dict_successors = dict()
        self._dict_predecessors = dict()
        self.from_label_to_vertex = dict()

    def get_in_degree(self, vertex):
        return len(self._dict_predecessors[vertex])

    def get_vertices_number(self):
        return len(self._dict_predecessors)

    def iterate_vertices(self):
        return self._dict_successors.keys()

    def iterate_outbound_edges(self, vertex):
        return self._dict_successors[vertex][:]

    def iterate_inbound_edges(self, vertex):
        return self._dict_predecessors[vertex][:]

    def is_edge(self, x, y):
        return y in self._dict_successors[x]

    def add_edge(self, x, y):
        if self.is_edge(x, y):
            raise ValueError("Edge already exists")
        self._dict_successors[x].append(y)
        self._dict_predecessors[y].append(x)

    def add_vertex(self, vertex):
        if vertex in self._dict_predecessors.keys():
            raise ValueError("Vertex already exists")

        self._dict_successors[vertex] = list()
        self._dict_predecessors[vertex] = list()
        self.from_label_to_vertex[vertex.label] = vertex

    def plot(self):
        import matplotlib.pyplot as plt
        import networkx as nx

        DG = nx.DiGraph()

        for node in self.iterate_vertices():
            DG.add_node(node.label)

        for x in self.iterate_vertices():
            for y in self.iterate_outbound_edges(x):
                DG.add_edge(x.label, y.label)

        pos = nx.circular_layout(DG)
        nx.draw(DG, pos=pos, arrowsize=25, node_size=500)
        nx.draw_networkx_labels(DG, pos)

        plt.savefig('graph_imag.png')
        plt.show()
    
    def topo_sort(self):
        sorted_list = []
        q = list()
        count = dict()
        for x in self._dict_successors:
            count[x] = self.get_in_degree(x)
            if count[x] == 0:
                q.append(x)
        while len(q) != 0:
            x = q[len(q)-1]
            q = q[:len(q) - 1]
            sorted_list.append(x)
            for y in self._dict_successors[x]:
                count[y] = count[y] - 1
                if count[y] == 0:
                    q.append(y)
        if len(sorted_list) < self.get_vertices_number():
            sorted_list = None
        return sorted_list


def read_from_file(file_name):
    with open(file_name, 'r') as f:
        line = f.readline()
        line = line.strip('\n')
        line = line.split(" ")
        n = int(line[0])
        m = int(line[1])
        DG = DirectedGraph()
        for i in range(n):
            line = f.readline()
            line = line.strip('\n')
            line = line.split(' ')
            
            vertex = Vertex(line[0], None, None, None, None, int(line[1]))
            DG.add_vertex(vertex)
        line = f.readline()
        for i in range(m):
            line = f.readline()
            line = line.strip('\n')
            line = line.split(' ')
            
            x = DG.from_label_to_vertex[line[0]]
            y = DG.from_label_to_vertex[line[1]]
            DG.add_edge(x, y)

    return DG


def problem1():
    DG = read_from_file("activity list representation.txt")
    topo_sorted = DG.topo_sort()
    # if the returned list in None, the graph is not a DAG
    if topo_sorted is None:
        print("The corresponding graph is not a DAG")
        return
    print(topo_sorted)
    print()
    # print(topo_sorted)
    # DG.plot()

    start = Vertex("start", 0, 0, None, None, 0)
    end = Vertex("end", None, None, None, None, 0)

    DG.add_vertex(start)
    DG.add_vertex(end)

    for vertex in topo_sorted:
        DG.add_edge(start, vertex)
        DG.add_edge(vertex, end)

    topo_sorted.insert(0, start)
    topo_sorted.append(end)


#################################


    for i in range(1, len(topo_sorted)):
        topo_sorted[i].min_start_time = max(DG.iterate_inbound_edges(topo_sorted[i]), key=lambda x: x.min_finish_time).min_finish_time
        topo_sorted[i].min_finish_time = topo_sorted[i].min_start_time + topo_sorted[i].duration

    topo_sorted[len(topo_sorted) - 1].max_finish_time = topo_sorted[len(topo_sorted) - 1].min_finish_time
    topo_sorted[len(topo_sorted) - 1].max_start_time = topo_sorted[len(topo_sorted) - 1].min_finish_time

    for i in range(len(topo_sorted) - 2, 0, -1):
        topo_sorted[i].max_finish_time = min(DG.iterate_outbound_edges(topo_sorted[i]), key=lambda x: x.max_start_time).max_start_time
        topo_sorted[i].max_start_time = topo_sorted[i].max_finish_time - topo_sorted[i].duration


#################################

    for activity in topo_sorted:
        print(activity)
    print()
    print("The total time of the project:",end.min_finish_time)
    print()
    print("The critical points are: ")
    for activity in topo_sorted:
        if activity.max_finish_time == activity.min_finish_time:
            print(activity)

    

if __name__ == "__main__":
    problem1()
