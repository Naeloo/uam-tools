from argparse import ArgumentParser
from uamtools.analyse.dicom import view_dicom

from uamtools.common.errors import InvalidUsageError
class AnalyseTool:
    def get_name():
        return "analyse"
    def get_version():
        return .1
    def verify_usage(args):
        if not args.view:
            raise InvalidUsageError("Provide one of --view")
    def prepare_args(parser: ArgumentParser):
        parser.add_argument("--view", action="count")
        parser.add_argument("--dicom", type=str, help="Path to DICOM folder to scan")
    def execute(args):
        if args.view:
            view_dicom(args.dicom)
