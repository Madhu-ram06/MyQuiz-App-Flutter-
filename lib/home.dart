import 'package:flutter/material.dart';

import 'answer.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Structures And Algo Quiz',
          style: TextStyle(color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 25.0,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
              (answer) => Answer(
                answerText: answer['answerText'],
                answerColor: answerWasSelected
                    ? answer['score']
                        ? Colors.green
                        : Colors.red
                    : null,
                answerTap: () {
                  // if answer was already selected then nothing happens onTap
                  if (answerWasSelected) {
                    return;
                  }
                  //answer is being selected
                  _questionAnswered(answer['score']);
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
                
              ),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Please select an answer before going to the next question'),
                  ));
                  return;
                }
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Restart Quiz' : 'Next Question',),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '${_totalScore.toString()}/${_questions.length}',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            if (answerWasSelected && !endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected
                        ? 'Good Job ! You got it right!!'
                        : 'Wrong Answer ! Better Luck Next Time!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    _totalScore > 4
                        ? 'Congratulations! Your final score is: $_totalScore'
                        : 'Your final score is: $_totalScore. Better luck next time!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore > 4 ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'How can we describe an array in the best possible way?',
    'answers': [
      {'answerText': 'Arrays are immutable', 'score': false},
      {'answerText': 'Container that stores the elements of similar types', 'score': true},
      {'answerText': 'Array shows a hierarchical structure.', 'score': false},
    ],
  },
  {
    'question':
        ' Which one of the following is the process of inserting an element in the stack?',
    'answers': [
      {'answerText': 'Insert', 'score': false},
      {'answerText': 'Add', 'score': false},
      {'answerText': 'Push', 'score': true},
    ],
  },
  {
    'question': 'If the size of the stack is 10 and we try to add the 11th element in the stack then the condition is known as___?',
    'answers': [
      {'answerText': 'Underflow', 'score': false},
      {'answerText': 'Garbage collection', 'score': false},
      {'answerText': 'Overflow', 'score': true},
    ],
  },
  {
    'question': ' Which of the following principle does Queue use?',
    'answers': [
      {'answerText': 'LIFO principle', 'score': false},
      {'answerText': 'FIFO principle', 'score': true},
      {'answerText': 'Ordered array', 'score': false},
    ],
  },
  {
    'question':
        'How can we define a AVL tree?',
    'answers': [
      {'answerText': 'A tree which is binary search tree and height balanced tree.', 'score': true},
      {'answerText': 'A tree which is a binary search tree but unbalanced tree.', 'score': false},
      {'answerText': 'A tree with utmost two children', 'score': false},
    ],
  },
  {
    'question': 'Which of the following sorting algorithms in its typical implementation gives best performance when applied on an array which is sorted or almost sorted (maximum 1 or two elements are misplaced).',
    'answers': [
      {'answerText': 'Insertion sort', 'score': true},
      {'answerText': 'Quick Sort', 'score':false },
      {'answerText': 'Bubble Sort', 'score': false},
    ],
  },
  {
    'question': 'Which of the following algorithms can be used to most efficiently determine the presence of a cycle in a given graph ?',
    'answers': [
      {'answerText': 'Depth First Search', 'score': true},
      {'answerText': 'Breadth First Search', 'score': false},
      {'answerText': 'Prim`s', 'score': false},
    ],
  },
  {
    'question': 'Given a directed graph where weight of every edge is same, we can efficiently find shortest path from a given source to destination using',
    'answers': [
      {'answerText': 'Dijkstra', 'score': false},
      {'answerText': 'Krushkals', 'score': false},
      {'answerText': 'BFS', 'score': true},
    ],
  },
  {
    'question': 'What is the time complexity of Huffman Coding',
    'answers': [
      {'answerText': 'O(N)', 'score': false},
      {'answerText': 'O(N^2)', 'score': false},
      {'answerText': 'O(NlogN)', 'score': true},
    ],
  },
];
