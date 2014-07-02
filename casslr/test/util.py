# coding:utf-8
from xml.etree import ElementTree
from casslr.lib import szradm


class TestFarmRoleEngine(szradm.FarmRoleEngine):
    def __init__(self):
        self.responses = []
        self.params = []

    def _szradm(self, params):
        self.params.append(params)
        return ElementTree.fromstring(self.responses.pop(0))