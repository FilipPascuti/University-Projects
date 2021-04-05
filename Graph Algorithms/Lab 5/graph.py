import sys

class Undirected_graph:
    def __init__(self, number_of_vertices):
        """
        Representation:
            - three dictionaries:
                    - one containing the inbound vertices of every vertex   (self._predecessors)
                    - one containing the outbound vertices of every vertex  (self._successors)
                    - one containing the cost of every edge  (self._edge_costs)
        """
        self._number_of_vertices = number_of_vertices
        self._vertices = list(range(0, self._number_of_vertices))
        self._adjacent  = dict()
        self._edges = dict()
        for v in range(0, self._number_of_vertices):
            self._adjacent[(v)] = []

    def get_edges_number(self):
        """
        method that returns the number of edges
        Input: -
        Output: the number of edges
        Exceptions: -
        """
        return len(self._edges)

    def get_vertices_number(self):
        """
        method that returns the number of vertices
        Input: -
        Output: the number of vertices
        Exceptions: - 
        """
        return len(self._number_of_vertices)

    def iterate_vertices(self):
        """
        method that returns an iterator containing all the vertices
        Input: -
        Output: the iterator containing all the vertices
        """
        return list(range(0, self._number_of_vertices))

    def is_edge(self, x, y):
        """
        method that checks if an edge exists
        Input: x, y - the source and target vertices
        Output: true - if the edge exists, false - if the edge does not exist
        """
        return (x, y) in self._edges or (y, x) in self._edges 

    def add_edge(self, x, y, cost=None):
        """
        method that adds an edge to the graph
        Input: x, y - the source and target vertices of the new edge, cost - the cost of the edge
        Output: -
        Exceptions: ValueError exception if the edge already exists
        """
        if self.is_edge(x, y):
            raise ValueError("Edge already exists")
        self._edges[(x, y)] = cost
        self._adjacent[x].append(y)
        self._adjacent[y].append(x)


    def remove_edge(self, x, y):
        """
        method that removes an edge from the graph
        Input: x, y - the source and target vertices of the edge
        Output: -
        Exceptions: ValueError exception if the edge does not exist
        """
        if not self.is_edge(x, y):
            raise ValueError("Edge does not exit")
        if (x,y) in self._edges:
            del self._edges[(x, y)]
        else:
            del self._edges[(y, x)]

        self._adjacent[x].reomve(y)
        self._adjacent[y].reomve(x)

    def add_vertex(self, vertex):
        """
        method that adds a vertex to the graph
        Input: the vertex id
        Output: -
        Exceptions: ValueError exception if the vertex already exists
        """
        if vertex in self._vertices:
            raise ValueError("Vertex already exists")
        self._adjacent[vertex] = list()
        self._vertices.append(vertex)
        
    def remove_vertex(self, vertex):
        """
        method that removes a vertex from the graph along with its connections
        Input: the vertex id
        Output:-
        Exceptions: ValueError exception if the vertex does not exist
        """
        if vertex not in self._vertices:
            raise ValueError("Vertex does not exist")
        # first we remove all the edges that contain the vertex
        for x in self._adjacent[vertex]:
            if (x,vertex) in self._edges:
                del self._edges[(x, vertex)]
            else:
                del self._edges[(vertex, x)]
        for x in self._adjacent[(vertex)]:
            self._adjacent[x].remove(vertex)
        del self._adjacent[vertex]
        self._vertices.remove(vertex)
        self._number_of_vertices -= 1

    def get_copy(self):
        """
        method that returns a deep copy of the graph
        Input: -
        Output: a deep copy of the graph
        Exceptions: -
        """
        from copy import deepcopy
        return deepcopy(self)

    def is_complete(self):
        n = self._number_of_vertices 
        if (n - 1) * n /2 == len(self._edges):
            return True
        else: 
            return False 

    # def write_to_file(self, file_name):
    #     """
    #     method that writes the graph to a file
    #     Input: file_ame - the name of the file
    #     Output: -
    #     Exceptions: IO exception if something goes wrong with the writing
    #     """
    #     string = str(self.get_vertices_number()) + " " + str(self.get_edges_number()) + "\n"
    #     for edge in self._edge_costs.keys():
    #         string = string + str(edge[0]) + ' ' + str(edge[1]) + ' ' + str(self._edge_costs[edge]) + '\n'
    #     with open(file_name, 'w') as f:
    #         f.write(string)


def maximum_clique(graph):
    queue = list()

    queue.append(graph)
    
    while len(queue) != 0:
        current_graph = queue.pop(0)
        
        if current_graph.is_complete():
            return current_graph

        for vertex in current_graph._vertices:
            coppy_graph = current_graph.get_copy()
            coppy_graph.remove_vertex(vertex)
            queue.append(coppy_graph)
    

def read_graph_from_file(file_name):
    """
    method that reads a directed graph from a file and returns it
	Input: file_name - the name of the file
	Output: the graph that has been read from the file
    """
    with open(file_name, 'r') as file:
        line = file.readline()
        line = line.strip('\n')
        line = line.split(' ')
        number_of_vertices = int(line[0])
        number_of_edges = int(line[1])
        undirected_graph = Undirected_graph(number_of_vertices)
        for _ in range(number_of_edges):
            line = file.readline()
            line = line.strip('\n')
            line = line.split(' ')
            x = int(line[0])
            y = int(line[1])
            cost = int(line[2])
            undirected_graph.add_edge(x, y, cost)
    return undirected_graph


class Console():
    def __init__(self):
        pass
    
    def run(self):
        graph = read_graph_from_file("manual2.txt")
        # print(graph._edges)
        # print()
        # for vertex in graph._vertices:
        #     coppy_graph = graph.get_copy()
        #     coppy_graph.remove_vertex(vertex)
        #     print(coppy_graph._vertices)
        #     print(coppy_graph._number_of_vertices)
        #     print(coppy_graph._edges)
        
        # print(graph._edges)
        # print(graph._edges)
        # print(graph._number_of_vertices)
        # print(graph.is_complete())
        # graph.remove_vertex(0)
        # print(graph._edges)
        # print(graph._number_of_vertices)
        # graph.remove_vertex(4)
        # print(graph._edges)
        # print(graph._number_of_vertices)
        # print(graph.is_complete())

        # maximum_clique(graph)
        max_clique = maximum_clique(graph)        
        print(max_clique._vertices)
            

def main():
    ui = Console()
    ui.run()



main()