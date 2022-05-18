from argparse import ArgumentParser
import sys
from uamtools.analyse.tool import AnalyseTool
from uamtools.common.errors import InvalidUsageError

tools = [AnalyseTool]

def main():
    # Verify parameters
    if len(sys.argv) < 2:
        help()
        sys.exit()
    # Find tool
    try:
        tool = next(tool for tool in tools if tool.get_name() == sys.argv[1])
    except StopIteration:
        help()
        sys.exit()
    print(f"uamtools {tool.get_name()} {tool.get_version()}")
    # Collect parameters
    parser = ArgumentParser(prog=f"uamtools {tool.get_name()}")
    tool.prepare_args(parser)
    args = parser.parse_args(sys.argv[2:])
    # Verify parameters
    try:
        tool.verify_usage(args)
    except InvalidUsageError as iue:
        parser.error(iue)
    # Execute tool
    tool.execute(args)

def help():
    print(f"usage: uamtools [{'|'.join(tool.get_name() for tool in tools)}]")