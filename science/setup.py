from setuptools import find_packages, setup

setup(
    name='src',
    packages=find_packages(),
    version='0.1.0',
    description='use KerasNLP to load a pre-trained Large Language Model (LLM) - GPT-2 model on OpenShift with NVIDIA GPUs.',
    author='dmarcus-wire',
    license='MIT',
)
