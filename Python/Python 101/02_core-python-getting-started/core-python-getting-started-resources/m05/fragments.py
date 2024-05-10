import random
import sys
from os.path import dirname, abspath, expanduser
from pathlib import Path
import logging

from replay_python import Idea

from editron import prepare_edit_script

logger = logging.getLogger(__name__)

this_module_dirpath = Path(dirname(abspath(__file__)))
steps_dirpath = this_module_dirpath / "steps"

# These four snapshot define the edit sequence
snapshot_filepaths = [
    steps_dirpath / "words_00.py",
    steps_dirpath / "words_01.py",
    steps_dirpath / "words_02.py",
]

# This edit script will contain three "batches" of operations,
# which will be used a three "fragments" for this slide.
edit_script = prepare_edit_script(
    lexer_name="python3",
    snapshot_filepaths=snapshot_filepaths
)

def prepare():
    """Do initial setup to PyCharm, after the editor has been started and the project loaded.
    """
    with Idea.localhost(14415) as idea:
        virtual_environment_python = sys.executable  # Use the Python we're already running in
        virtual_environment_python = expanduser("~/.virtualenvs/corepy/bin/python")
        #virtual_environment_dirpath = this_module_dirpath / "venv"
        #logger.info("Preparing PyCharm with virtual environment: %s", virtual_environment_python)
        #idea.create_virtual_env(virtual_environment_dirpath, "/usr/local/Cellar/python/3.7.4_1/Frameworks/Python.framework/Versions/3.7/bin/python3.7")
        idea.use_existing_virtual_env(virtual_environment_python)
        idea.set_font_size(24)


def fragment_0(rate):
    prng = random.Random(0)
    logger.info("fragment_0 delegate rate = %f", rate)
    with Idea.localhost(14415, prng=prng) as idea:
        idea.play_editron_single_batch(edit_script, 0, rate=rate)


def fragment_1(rate):
    prng = random.Random(1)
    logger.info("fragment_1 delegate rate = %f", rate)
    with Idea.localhost(14415, prng=prng) as idea:
        idea.play_editron_single_batch(edit_script, 1, rate=rate)

# def fragment_2(rate):
#     prng = random.Random(2)
#     logger.info("fragment_2 delegate rate = %f", rate)
#     with Idea.localhost(14415, prng=prng) as idea:
#         idea.open_python_console()

# def fragment_3(rate):
#     prng = random.Random(3)
#     logger.info("fragment_3 delegate rate = %f", rate)
#     with Idea.localhost(14415, prng=prng) as idea:
#         idea.type_text("from airtravel import Flight", rate=rate)
#         idea.type_execute_statement(rate=rate)

# def fragment_4(rate):
#     prng = random.Random(4)
#     logger.info("fragment_4 delegate rate = %f", rate)
#     with Idea.localhost(14415, prng=prng) as idea:
#         idea.type_text("Flight", rate=rate)
#         idea.type_execute_statement(rate=rate)

# def fragment_5(rate):
#     prng = random.Random(5)
#     logger.info("fragment_5 delegate rate = %f", rate)
#     with Idea.localhost(14415, prng=prng) as idea:
#         idea.type_text("f = Flight()", rate=rate)
#         idea.type_execute_statement(rate=rate)

# def fragment_6(rate):
#     prng = random.Random(6)
#     logger.info("fragment_6 delegate rate = %f", rate)
#     with Idea.localhost(14415, prng=prng) as idea:
#         idea.type_text("type(f)", rate=rate)
#         idea.type_execute_statement(rate=rate)