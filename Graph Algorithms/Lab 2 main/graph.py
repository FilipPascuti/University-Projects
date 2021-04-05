import sys

class Directed_graph:
    def __init__(self, number_of_vertices):
        """
        Representation:
            - three dictionaries:
                    - one containing the inbound vertices of every vertex   (self._predecessors)
                    - one containing the outbound vertices of every vertex  (self._successors)
                    - one containing the cost of every edge  (self._edge_costs)
        """
        self._number_of_vertices = number_of_vertices
        self._successors = dict()
        self._predecessors = dict()
        self._edge_costs = dict()

        for vertex in range(number_of_vertices):
            self._successors[vertex] = list()  # initializing the successors of the vertex with empty list
            self._predecessors[vertex] = list()  # initializing the predecessors of the vertex with empty list

    def get_edges_number(self):
        """
        method that returns the number of edges
        Input: -
        Output: the number of edges
        Exceptions: -
        """
        return len(self._edge_costs)

    def get_vertices_number(self):
        """
        method that returns the number of vertices
        Input: -
        Output: the number of vertices
        Exceptions: - 
        """
        return len(self._successors)

    def get_in_degree(self, vertex):
        """
        method that returns the in degree of a given vertex
        Input: vertex - the vertex for which we compute the in degree 
        Output: the in degree of the wanted vertex (if the vertex does not exist, the output will be 0)
        """
        return len(self._predecessors[vertex])

    def get_out_degree(self, vertex):
        """
        method that returns the out degree of a given vertex
        Input: vertex - the vertex for which compute the out degree 
        Output: the out degree of the wanted vertex
        """
        return len(self._successors[vertex])

    def get_edge_cost(self, x, y):
        """
        method that returns the cost of a given edge stores
        Input: x, y the source and target vertices of the edge
        Output: the cost of the edge (x, y)
        """
        return self._edge_costs[(x, y)]

    def set_edge_cost(self, x, y, cost):
        """
        method that modifies the information of a given edge
        Input: x, y the source and target vertices of the edge, cost - the new cost of the edge
        Output: -
        """
        self._edge_costs[(x, y)] = cost

    def iterate_vertices(self):
        """
        method that returns an iterator containing all the vertices
        Input: -
        Output: the iterator containing all the vertices
        """
        return self._successors.keys()

    def iterate_outbound_edges(self, vertex):
        """
        method that returns an iterator containing the outbound edges of a given vertex
        Input: vertex - the vertex for which we return the outbound edges 
        Output: the iterator containing the outbound edges
        """
        return self._successors[vertex][:]

    def iterate_inbound_edges(self, vertex):
        """
        method that returns an iterator containing the inbound edges of a given vertex
        Input: vertex - the vertex for which we return the inbound edges
        Output: the iterator containing the inbound edges
        """
        return self._predecessors[vertex][:]

    def is_edge(self, x, y):
        """
        method that checks if an edge exists
        Input: x, y - the source and target vertices
        Output: true - if the edge exists, false - if the edge does not exist
        """
        return y in self._successors[x]

    def add_edge(self, x, y, cost=None):
        """
        method that adds an edge to the graph
        Input: x, y - the source and target vertices of the new edge, cost - the cost of the edge
        Output: -
        Exceptions: ValueError exception if the edge already exists
        """
        if self.is_edge(x, y):
            raise ValueError("Edge already exists")
        self._edge_costs[(x, y)] = cost
        self._successors[x].append(y)
        self._predecessors[y].append(x)

    def remove_edge(self, x, y):
        """
        method that removes an edge from the graph
        Input: x, y - the source and target vertices of the edge
        Output: -
        Exceptions: ValueError exception if the edge does not exist
        """
        if not self.is_edge(x, y):
            raise ValueError("Edge does not exit")
        del self._edge_costs[(x, y)]
        self._successors[x].remove(y)
        self._predecessors[y].remove(x)

    def add_vertex(self, vertex):
        """
        method that adds a vertex to the graph
        Input: the vertex id
        Output: -
        Exceptions: ValueError exception if the vertex already exists
        """
        if vertex in self._predecessors.keys():
            raise ValueError("Vertex already exists")
        self._successors[vertex] = list()
        self._predecessors[vertex] = list()

    def remove_vertex(self, vertex):
        """
        method that removes a vertex from the graph along with its connections
        Input: the vertex id
        Output:-
        Exceptions: ValueError exception if the vertex does not exist
        """
        if vertex not in self._predecessors.keys():
            raise ValueError("Vertex does not exist")
        # first we remove all the edges that contain the vertex
        for v in self._successors[vertex]:
            self._predecessors[v].remove(vertex)
            del self._edge_costs[(vertex, v)]
         
        for v in self._predecessors[vertex]:
            self._successors[v].remove(vertex)
            del self._edge_costs[(v, vertex)]
        # remove the vertex
        del self._successors[vertex]
        del self._predecessors[vertex]

    def get_copy(self):
        """
        method that returns a deep copy of the graph
        Input: -
        Output: a deep copy of the graph
        Exceptions: -
        """
        from copy import deepcopy
        return deepcopy(self)


    def write_to_file(self, file_name):
        """
        method that writes the graph to a file
        Input: file_ame - the name of the file
        Output: -
        Exceptions: IO exception if something goes wrong with the writing
        """
        string = str(self.get_vertices_number()) + " " + str(self.get_edges_number()) + "\n"
        for edge in self._edge_costs.keys():
            string = string + str(edge[0]) + ' ' + str(edge[1]) + ' ' + str(self._edge_costs[edge]) + '\n'
        with open(file_name, 'w') as f:
            f.write(string)
    def shortest_path_bfs(self, s, t):
        prev = dict()
        l = dict()
        queue = list()
        visited = list()
        queue.append(s)
        visited.append(s)
        # length = 0
        l[s] = 0
        while len(queue) != 0:
            x = queue[0]
            queue = queue[1:]
            for y in self._successors[x]:
                if y not in visited:
                    queue.append(y)
                    visited.append(y)
                    l[y] = l[x] + 1
                    prev[y] = x     
        if t in visited:
            print("shortest path is:\n")
            print(l[t])
            path = list()
            x = t
            path.append(x)
            while x != s:
                x = prev[x]
                path.append(x)
            path.reverse()
            print(path)
        else:
            print("not accessible!")

    def shortest_path_backward_bfs(self, s, t):
        succesor = dict()
        l = dict()
        queue = list()
        visited = list()
        queue.append(t)
        visited.append(t)
        # length = 0
        l[t] = 0
        while len(queue) != 0:
            x = queue[0]
            queue = queue[1:]
            for y in self._predecessors[x]:
                if y not in visited:
                    queue.append(y)
                    visited.append(y)
                    l[y] = l[x] + 1
                    succesor[y] = x
                if s == y:
                    print("shortest path is:\n")
                    print(l[s])
                    path = list()
                    x = s
                    path.append(x)
                    while x != t:
                        x = succesor[x]
                        path.append(x)
                    print(path)
                    return   
        if s not in visited:
            print("not accessible!")     


        # if s in visited:
        #     print("shortest path is:\n")
        #     print(l[s])
        #     path = list()
        #     x = s
        #     path.append(x)
        #     while x != t:
        #         x = succesor[x]
        #         path.append(x)
        #     # path.reverse()
        #     print(path)
        # else:
        #     print("not accessible!")

    def lowest_cost_walk_with_a_matrix(self, s, t):
        int_max = sys.maxsize * 2 + 1
        matrix = list()
        for _ in range(0, self._number_of_vertices + 1):
            the_list = [int_max] * self._number_of_vertices
            matrix.append(the_list)
        for k in range(0, self._number_of_vertices + 1):
            matrix[k][s] = 0
        for x in self._successors[s]:
            matrix[1][x] = self._edge_costs[(s,x)] 
        for k in range(2, self._number_of_vertices + 1):
            for x in self._successors:
                for y in self._predecessors[x]:
                    if matrix[k - 1][x] < (matrix[k-1][y] + self._edge_costs[(y,x)]):
                        if matrix[k][x] > matrix[k - 1][x]:
                            matrix[k][x] = matrix[k - 1][x]
                    else:
                        if matrix[k][x] >  (matrix[k-1][y] + self._edge_costs[(y,x)]):
                            matrix[k][x] =  (matrix[k-1][y] + self._edge_costs[(y,x)])
        for x in range(0,self._number_of_vertices):
            if matrix[self._number_of_vertices - 1][x] != matrix[self._number_of_vertices][x]:
                print("negative cost cycles")
                return
        # print(matrix)
        cost_of_shortest_walk = matrix[self._number_of_vertices-1][t]
        # print(shortest_walk)
        
        length_of_shortest_path = self._number_of_vertices-1
        while True:
            if matrix[length_of_shortest_path][t] == matrix[length_of_shortest_path - 1][t]:
                length_of_shortest_path -= 1
            else:
                break
        # print(length_of_shortest_path)
        shortest_walk = [t]
        k = length_of_shortest_path
        last = t
        while k >= 1:
            for y in self._predecessors[last]:
                if (matrix[k - 1][y] + self._edge_costs[(y,last)]) == matrix[k][last]:
                    last = y
                    shortest_walk.append(y)
                    k -= 1
                    break
        shortest_walk.reverse()
        print("The cost of the shortest path is: ", cost_of_shortest_walk)
        print(shortest_walk)

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
        directed_graph = Directed_graph(number_of_vertices)
        for _ in range(number_of_edges):
            line = file.readline()
            line = line.strip('\n')
            line = line.split(' ')
            x = int(line[0])
            y = int(line[1])
            cost = int(line[2])
            directed_graph.add_edge(x, y, cost)
    return directed_graph


def create_random_graph(number_of_vertices, number_of_edges):
    """ 
    method that creates a random graph with a given number of edges and vertices, and writes it to a file
	Input: number_of_vertices - the number of vertices, number_of_edges - the number of edges, file_name - the name of the file the generated graph will be written
	Output: -
    Exceptions: ValueError exception if the number_of_edges > number_of_vertices * (number_of_vertices - 1)
    """
    if number_of_vertices * number_of_vertices < number_of_edges:
        raise ValueError("To many edges!\n")
    import random
    graph = Directed_graph(number_of_vertices)
    while graph.get_edges_number() is not number_of_edges:
        x = random.randint(0, number_of_vertices - 1)
        y = random.randint(0, number_of_vertices - 1)
        cost = random.randint(-100, 100)
        if graph.is_edge(x,y):
            continue
        graph.add_edge(x,y,cost)
    return graph

class Console():
    def __init__(self):
        pass
    
    def run(self):
        command = input("Choose what graph to use:\n1. graph10k from file\n2. random generated graph\n")
        if command == "1":
            # graph = Directed_graph(10000)
            graph = read_graph_from_file("graph7.txt")
        elif command == "2":
            graph = read_graph_from_file("graph1k.txt")
        elif command == "3":
            graph = read_graph_from_file("graph10k.txt")
        elif command == "4":
            graph = read_graph_from_file("graph100k.txt")
        elif command == "a":
            graph = read_graph_from_file("manual1.txt")
        elif command == "b":
            graph = read_graph_from_file("manual2.txt")
        elif command == "c":
            graph = read_graph_from_file("neg_cost_cycles.txt")
        elif command == "5":
            while True:
                x = int(input("insert the number of vetices: \n"))
                y = int(input("insert the number of edges: \n"))
                try:
                    graph = create_random_graph(x,y)
                    break
                except Exception as ex:
                    print(str(ex))
                    # x = int(input("insert the number of vetices: \n"))
                    # y = int(input("insert the number of edges: \n"))
        while True:
            try:
                command = input("insert command:\n>>>")
                if command == "x":
                    return 
                elif command == "1":
                    print("The number of vertices: ", graph.get_vertices_number(), "\n")
                elif command == "2":
                    x = int(input("the source vertex is:\n"))
                    y = int(input("the target vertex is:\n"))
                    if graph.is_edge(x,y) == True:
                        print("There is an edge!\n")
                    else:
                        print("There is not an edge!\n")
                elif command == "3":
                    x = int(input("the source vertex is:\n"))
                    y = int(input("the target vertex is:\n"))
                    print("the cost of the edge is: ",graph.get_edge_cost(x,y),"\n")
                elif command == "4":
                    x = int(input("the source vertex is:\n"))
                    y = int(input("the target vertex is:\n"))
                    cost = int(input("new cost:\n"))
                    graph.set_edge_cost(x,y,cost)
                elif command == "5":
                    x = int(input("Insert the vertex:\n"))
                    print("The in degree is: ", graph.get_in_degree(x))
                elif command == "6":
                    x = int(input("Insert the vertex:\n"))
                    print("The out degree is: ", graph.get_out_degree(x))
                elif command == "7":
                    for vertex in graph.iterate_vertices():
                        print(vertex, end=" ")
                elif command == "8":
                    x = int(input("Insert the vertex:\n"))
                    print("The out-bound edges: ")
                    for edge in graph.iterate_outbound_edges(x):
                        print(edge, end=" ")
                    print("\n")
                elif command == "9":
                    x = int(input("Insert the vertex:\n"))
                    print("The in-bound edges: ")
                    for edge in graph.iterate_inbound_edges(x):
                        print(edge, end=" ")
                elif command == "10":
                    x = int(input("Insert the vertex:\n"))
                    graph.add_vertex(x)
                elif command == "11":
                    x = int(input("Insert the vertex:\n"))
                    graph.remove_vertex(x)
                elif command == "12":
                    x = int(input("the source vertex is:\n"))
                    y = int(input("the target vertex is:\n"))
                    cost = int(input("new cost:\n"))
                    graph.add_edge(x,y,cost)
                elif command == "13":
                    x = int(input("the source vertex is:\n"))
                    y = int(input("the target vertex is:\n"))
                    graph.remove_edge(x,y)
                elif command == "14":
                    file_name = input("insert file name:\n")
                    graph.write_to_file(file_name)
                elif command == "15":
                    graph = graph.get_copy()
                elif command == "16":
                    x = int(input("the source vertex is:\n"))
                    y = int(input("the target vertex is:\n"))
                    graph.shortest_path_backward_bfs(x, y)
                elif command == "17":
                    x = int(input("the source vertex is:\n"))
                    y = int(input("the target vertex is:\n"))
                    graph.lowest_cost_walk_with_a_matrix(x, y)
            except Exception as ex:
                print(str(ex))

def main():
    ui = Console()
    ui.run()


main()