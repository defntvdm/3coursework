#!/usr/bin/env python3

from argparse import ArgumentParser
import sys
from time import time
from my_lib import start_experiment

def parse_args():
	'''Парсер аргументов'''
	parser = ArgumentParser(epilog='(c) Николаев Вадим, КБ-301', 
							description='Находит среднюю часть удалённых вершин из цепи из треугольников до разрыва цепи',
							usage=f'{sys.argv[0]} [--height HEIGHT] [--width WIDTH] [--exp EXPERIMENTS]')
	parser.add_argument('--height', type=int, default=50, help='высота в вершинах (50 по умолчанию)')
	parser.add_argument('--width', type=int, default=50, help='ширина в вершинах (50 по умолчанию)')
	parser.add_argument('--exp', type=int, default=100, help='число экспериментов (100 по умолчанию)')
	return parser.parse_args()

def main():
	args = parse_args()
	exp, width, height = args.exp, args.width, args.height
	if width < 2:
		print('Ширина не меньше 2')
		exit(0)
	if height < 2:
		print('Высота не меньше 2')
		exit(0)
	if width < 3 and height < 3:
		print('В квадрате 2x2 невозможно удалить необходимое количество вершин')
		exit(0)
	res = 0
	start_time = time()
	for _ in range(exp):
		res += start_experiment(width, height)
	end_time = time()
	res = res/(width*height*exp)
	print('Затрачено:', f'{end_time-start_time:.4f}c')
	print('Результат:', f'{res:.4f}')

if __name__ == '__main__':
	main()
