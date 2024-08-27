"""This module contains the configuration and functions to create call
graphs."""

import re
from typing import Dict, List

from jinja2 import Environment, PackageLoader, select_autoescape
from z3 import Z3Exception

from mythril.laser.ethereum.svm import NodeFlags
from mythril.laser.smt import simplify

default_opts = {
    "autoResize": True,
    "height": "100%",
    "width": "100%",
    "manipulation": False,
    "layout": {
        "improvedLayout": True,
        "hierarchical": {
            "enabled": True,
            "levelSeparation": 450,
            "nodeSpacing": 200,
            "treeSpacing": 100,
            "blockShifting": True,
            "edgeMinimization": True,
            "parentCentralization": False,
            "direction": "LR",
            "sortMethod": "directed",
        },
    },
    "nodes": {
        "color": "#000000",
        "borderWidth": 1,
        "borderWidthSelected": 2,
        "chosen": True,
        "shape": "box",
        "font": {"align": "left", "color": "#FFFFFF"},
    },
    "edges": {
        "font": {
            "color": "#FFFFFF",
            "face": "arial",
            "background": "none",
            "strokeWidth": 0,
            "strokeColor": "#ffffff",
            "align": "horizontal",
            "multi": False,
            "vadjust": 0,
        }
    },
    "physics": {"enabled": False},
}

phrack_opts = {
    "nodes": {
        "color": "#000000",
        "borderWidth": 1,
        "borderWidthSelected": 1,
        "shapeProperties": {"borderDashes": False, "borderRadius": 0},
        "chosen": True,
        "shape": "box",
        "font": {"face": "courier new", "align": "left", "color": "#000000"},
    },
    "edges": {
        "font": {
            "color": "#000000",
            "face": "courier new",
            "background": "none",
            "strokeWidth": 0,
            "strokeColor": "#ffffff",
            "align": "horizontal",
            "multi": False,
            "vadjust": 0,
        }
    },
}

default_colors = [
    {
        "border": "#26996f",
        "background": "#2f7e5b",
        "highlight": {"border": "#26996f", "background": "#28a16f"},
    },
    {
        "border": "#9e42b3",
        "background": "#842899",
        "highlight": {"border": "#9e42b3", "background": "#933da6"},
    },
    {
        "border": "#b82323",
        "background": "#991d1d",
        "highlight": {"border": "#b82323", "background": "#a61f1f"},
    },
    {
        "border": "#4753bf",
        "background": "#3b46a1",
        "highlight": {"border": "#4753bf", "background": "#424db3"},
    },
    {
        "border": "#26996f",
        "background": "#2f7e5b",
        "highlight": {"border": "#26996f", "background": "#28a16f"},
    },
    {
        "border": "#9e42b3",
        "background": "#842899",
        "highlight": {"border": "#9e42b3", "background": "#933da6"},
    },
    {
        "border": "#b82323",
        "background": "#991d1d",
        "highlight": {"border": "#b82323", "background": "#a61f1f"},
    },
    {
        "border": "#4753bf",
        "background": "#3b46a1",
        "highlight": {"border": "#4753bf", "background": "#424db3"},
    },
]

phrack_color = {
    "border": "#000000",
    "background": "#ffffff",
    "highlight": {"border": "#000000", "background": "#ffffff"},
}


def extract_nodes(statespace) -> List[Dict]:
    """
    Extract nodes from the given statespace and create a list of node dictionaries
    with visual attributes for graph representation.

    :param statespace: The statespace object containing nodes and states information.
    :return: A list of dictionaries representing each node with its attributes.
    """
    nodes = []
    color_map = {}
    for node_key, node in statespace.nodes.items():
        instructions = [state.get_current_instruction() for state in node.states]
        code_split = []

        for instruction in instructions:
            address = instruction["address"]
            opcode = instruction["opcode"]
            if opcode.startswith("PUSH"):
                code_line = f"{address} {opcode} {instruction.get('argument', '')}"
            elif (
                opcode.startswith("JUMPDEST")
                and NodeFlags.FUNC_ENTRY in node.flags
                and address == node.start_addr
            ):
                code_line = node.function_name
            else:
                code_line = f"{address} {opcode}"

            code_line = re.sub(r"([0-9a-f]{8})[0-9a-f]+", r"\1(...)", code_line)
            code_split.append(code_line)

        truncated_code = (
            "\n".join(code_split)
            if len(code_split) < 7
            else "\n".join(code_split[:6]) + "\n(click to expand +)"
        )

        contract_name = node.get_cfg_dict()["contract_name"]
        if contract_name not in color_map:
            color = default_colors[len(color_map) % len(default_colors)]
            color_map[contract_name] = color

        nodes.append(
            {
                "id": str(node_key),
                "color": color_map.get(contract_name, default_colors[0]),
                "size": 150,
                "fullLabel": "\n".join(code_split),
                "label": truncated_code,
                "truncLabel": truncated_code,
                "isExpanded": False,
            }
        )

    return nodes


def extract_edges(statespace):
    """

    :param statespace:
    :return:
    """
    edges = []
    for edge in statespace.edges:
        if edge.condition is None:
            label = ""
        else:
            try:
                label = str(simplify(edge.condition)).replace("\n", "")
            except Z3Exception:
                label = str(edge.condition).replace("\n", "")

        label = re.sub(
            r"([^_])([\d]{2}\d+)", lambda m: m.group(1) + hex(int(m.group(2))), label
        )

        edges.append(
            {
                "from": str(edge.as_dict["from"]),
                "to": str(edge.as_dict["to"]),
                "arrows": "to",
                "label": label,
                "smooth": {"type": "cubicBezier"},
            }
        )
    return edges


def generate_graph(
    statespace,
    title="Mythril / Ethereum LASER Symbolic VM",
    physics=False,
    phrackify=False,
):
    """

    :param statespace:
    :param title:
    :param physics:
    :param phrackify:
    :return:
    """
    env = Environment(
        loader=PackageLoader("mythril.analysis"),
        autoescape=select_autoescape(["html", "xml"]),
    )
    template = env.get_template("callgraph.html")

    graph_opts = default_opts

    graph_opts["physics"]["enabled"] = physics

    return template.render(
        title=title,
        nodes=extract_nodes(statespace),
        edges=extract_edges(statespace),
        phrackify=phrackify,
        opts=graph_opts,
    )
