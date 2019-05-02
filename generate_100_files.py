import random
import unittest

# Using this interpretation of "printable characters" instead of string.printable 
# since string.printable also contains newlines, conflicts with section of the problem 
# definition "Each file should contain __a line__..."
printable_chars = [chr(i) for i in range(32,128)]

def get_all_file_contents(up_to):
	for i in range(up_to):
		with open('%d' % i, 'r') as file_handler:
			yield file_handler.read()

def write_files():
	for i in range(100):
		with open('%d' % i, 'w') as file_handler:
			if i % 7 == 0 and i > 0:
				file_handler.write(''.join(list(get_all_file_contents(i))))
			else:
				char_count = random.randint(1,65)
				random_chars = [random.choice(printable_chars) for _ in range(char_count)]
				string_to_write = ''.join(random_chars)
				if i % 5 == 0 and i > 0:
					string_to_write += "This is every fifth file!"
				file_handler.write(string_to_write)

class TestFiles(unittest.TestCase):

	def test_file_count(self):
		try:
			for i in range(100):
				open('%d' % i, 'r')
		except IOError as e:
			self.fail('Not all required files found. %s' % e)

	def test_sevens(self):
		for i in range(7,100,7):
			expected = ''
			for j in range(i):
				with open('%d' % j, 'r') as f:
					expected += f.read()
			with open('%d' % i, 'r') as g:
				self.assertEqual(expected, g.read())

	def test_fives(self):
		for i in range(5,100,5):
			if i % 7 == 0:
				continue
			with open('%d' % i, 'r') as f:
				self.assertIn("This is every fifth file!", f.read())

	def test_length(self):
		for i in [x for x in range(100) if x%5 != 0 and x%7 != 0]:
			with open('%d' % i, 'r') as f:
				char_count = len(f.read())
				self.assertGreaterEqual(char_count, 1)
				self.assertLessEqual(char_count, 65)
				
if __name__ == "__main__":
	write_files()
	unittest.main()
