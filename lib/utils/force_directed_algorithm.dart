import 'dart:math';

class ForceDirectedAlgorithm {
  ForceDirectedAlgorithm(
      {required this.nodes,
      required this.edges,
      this.k = 0.1,
      this.c = 100,
      this.width = 500,
      this.height = 500,
      this.temperature = 100}) {
    area = width * height;
  }

  late double area; // 画布面积
  double c; // 斥力系数
  List<Edge> edges;
  double height; // 画布高度
  double k; // 弹簧劲度系数
  List<Node> nodes;
  double temperature; // 温度参数
  double width; // 画布宽度

  void run(int iterations) {
    for (int i = 0; i < iterations; i++) {
      for (var node in nodes) {
        // 计算节点受到的斥力
        Vector repulsiveForce = calculateRepulsiveForce(node);

        // 计算节点受到的引力
        Vector attractiveForce = calculateAttractiveForce(node);

        // 更新节点位置
        node.position += (attractiveForce + repulsiveForce) * temperature;
        node.position.x = node.position.x.clamp(0, width);
        node.position.y = node.position.y.clamp(0, height);
      }

      // 降低温度
      temperature *= 0.95;
    }
  }

  Vector calculateRepulsiveForce(Node node) {
    Vector force = Vector.zero();
    for (var otherNode in nodes) {
      if (otherNode != node) {
        Vector delta = node.position - otherNode.position;
        double distance = delta.magnitude().clamp(0.01, double.infinity);
        Vector direction = delta.normalize();
        double repulsiveStrength = (c * c) / distance;

        force += direction * repulsiveStrength;
      }
    }
    return force;
  }

  Vector calculateAttractiveForce(Node node) {
    Vector force = Vector.zero();
    for (var edge in edges) {
      if (edge.from == node) {
        Vector delta = edge.to.position - node.position;
        double distance = delta.magnitude().clamp(0.01, double.infinity);
        Vector direction = delta.normalize();
        double attractiveStrength = (distance * distance) / k;

        force += direction * attractiveStrength;
      }
    }
    return force;
  }
}

class Node {
  Node(this.position);

  Vector position;
}

class Edge {
  Edge(this.from, this.to);

  Node from;
  Node to;
}

class Vector {
  Vector(this.x, this.y);

  Vector.zero()
      : x = 0,
        y = 0;

  double x;
  double y;

  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);

  Vector operator -(Vector other) => Vector(x - other.x, y - other.y);

  Vector operator *(double scalar) => Vector(x * scalar, y * scalar);

  double magnitude() => sqrt(x * x + y * y);

  Vector normalize() {
    double mag = magnitude();
    return Vector(x / mag, y / mag);
  }
}
