import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  static const String baseUrl = 'http://your-spring-boot-server:8080/api';

  static Future<List<Project>> getProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<Project> createProject(Project project) async {
    final response = await http.post(
      Uri.parse('$baseUrl/projects'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(project.toJson()),
    );

    if (response.statusCode == 201) {
      return Project.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create project');
    }
  }

  static Future<void> deleteProject(String projectId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/projects/$projectId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete project');
    }
  }

  static Future<List<ProjectItem>> getProjectItems(String projectId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/projects/$projectId/items'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProjectItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load project items');
    }
  }

  static Future<ProjectItem> addProjectItem(
    String projectId,
    ProjectItem item,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/projects/$projectId/items'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode == 201) {
      return ProjectItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add project item');
    }
  }

  static Future<void> deleteProjectItem(
    String projectId,
    String itemId,
  ) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/projects/$projectId/items/$itemId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete project item');
    }
  }
}
