var node = <Map<String, dynamic>>[
  {
    'id': 0,
    'label': '人',
    'properties': {'age': 18},
    'name': '刘圣鑫',
  },
  {
    'id': 1,
    'label': '',
    'properties': {'age': 18},
    'name': '丁须扬',
  },
  {
    'id': 2,
    'label': 'fish',
    'properties': {'age': 18},
    'name': '黄安然',
  },
  {
    'id': 3,
    'label': 'Person',
    'properties': {'age': 18},
    'name': '魏浩同',
  },
  {
    'id': 4,
    'label': 'cow',
    'properties': {'age': 18},
    'name': '王嘉祺',
  },
];

var relationship = <Map<String, dynamic>>[
  {
    'id': 0,
    'start': 0,
    'end': 1,
    'type': '同学',
  },
  {
    'id': 1,
    'start': 0,
    'end': 2,
    'type': '同学',
  },
  {
    'id': 2,
    'start': 2,
    'end': 3,
    'type': '朋友',
  },
  {
    'id': 3,
    'start': 0,
    'end': 4,
    'type': '嘿嘿',
  },
];

var node_lables = [''];
