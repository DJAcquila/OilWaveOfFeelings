import json
from enum import Enum

'''
    ‘Thoughts are the shadows of our feelings-always darker, emptier, and simpler’. Nietzsche, The gay science p. 203. 
'''

class Msg(Enum):
	simple_msg = 1
	sadness = 2
	happiness = 3

class Connect:
	def __init__(self):
		self.file_path = 'log.json'
		self.initData()
		self.total = 0
		self.sadness = 0.0
		self.happiness = 0.0

	def initData(self):
		data = {}
		data['last_msg'] = ''
		data['last_sentiment'] = ''
		data['sadness_degree'] = ''
		data['happiness_degree'] = ''
		data['msg_log'] = []
		with open(self.file_path, 'w+') as file:
			json.dump(data, file)

	def balance(self, msg_type):
		self.total += 1
		if msg_type is Msg.happiness:
			self.happiness += 1
			
		elif msg_type is Msg.sadness:
			self.sadness += 1


	def write(self, msg_type, msg):
		with open(self.file_path, 'r+') as file:
			data = json.load(file)
			if msg_type is Msg.simple_msg:
				data['last_msg'] = msg
				data['msg_log'].append(msg)
				print("Mensagem inserida no json")
				
			elif msg_type is Msg.sadness:
				
				data['last_msg'] = msg
				data['msg_log'].append(msg)

				self.balance(msg_type)
				data['last_sentiment'] = 'neg'
				data['sadness_degree'] = self.sadness/self.total
				data['happiness_degree'] = self.happiness/self.total
				print("Mensagem inserida no json")
			
			elif msg_type is Msg.happiness:
				
				data['last_msg'] = msg
				data['msg_log'].append(msg)

				self.balance(msg_type)
				data['last_sentiment'] = 'pos'
				data['happiness_degree'] = self.happiness/self.total
				data['sadness_degree'] = self.sadness/self.total
				print("Mensagem inserida no json")
				

			file.seek(0)
			json.dump(data, file)
			file.truncate()
			

