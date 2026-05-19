#!/usr/bin/env python3
"""Intelligent XML formatter: each attribute on its own indented line."""
import sys
from lxml import etree

INDENT = "  "


def _ns_to_prefix(element):
    result = {}
    for prefix, uri in element.nsmap.items():
        result[uri] = prefix
    return result


def _tag_str(element):
    tag = element.tag
    if not tag.startswith("{"):
        return tag
    uri, local = tag[1:].split("}", 1)
    prefix = _ns_to_prefix(element).get(uri)
    return f"{prefix}:{local}" if prefix else local


def _attr_name(key, element):
    if not key.startswith("{"):
        return key
    uri, local = key[1:].split("}", 1)
    prefix = _ns_to_prefix(element).get(uri)
    return f"{prefix}:{local}" if prefix else local


def _ns_declarations(element):
    parent_nsmap = element.getparent().nsmap if element.getparent() is not None else {}
    decls = []
    for prefix, uri in element.nsmap.items():
        if parent_nsmap.get(prefix) != uri:
            decls.append(f'xmlns="{uri}"' if prefix is None else f'xmlns:{prefix}="{uri}"')
    return decls


def _serialize(element, level=0):
    pad = INDENT * level
    child_pad = INDENT * (level + 1)
    attr_pad = pad + INDENT

    tag = _tag_str(element)
    attrs = _ns_declarations(element) + [
        f'{_attr_name(k, element)}="{v}"' for k, v in element.attrib.items()
    ]
    children = list(element)
    has_text = bool(element.text and element.text.strip())

    # Build the opening tag — single attr stays inline, multiple go one-per-line
    if not attrs:
        open_tag = f"{pad}<{tag}"
    elif len(attrs) == 1:
        open_tag = f"{pad}<{tag} {attrs[0]}"
    else:
        attr_block = "\n".join(f"{attr_pad}{a}" for a in attrs)
        open_tag = f"{pad}<{tag}\n{attr_block}"

    if not children and not has_text:
        return f"{open_tag}/>"

    lines = [f"{open_tag}>"]

    if has_text:
        lines.append(f"{child_pad}{element.text.strip()}")

    for child in children:
        lines.append(_serialize(child, level + 1))
        if child.tail and child.tail.strip():
            lines.append(f"{child_pad}{child.tail.strip()}")

    lines.append(f"{pad}</{tag}>")
    return "\n".join(lines)


def main():
    raw = sys.stdin.buffer.read()
    has_decl = raw.lstrip().startswith(b"<?xml")

    parser = etree.XMLParser(remove_blank_text=True, resolve_entities=False)
    try:
        root = etree.fromstring(raw, parser)
    except etree.XMLSyntaxError as e:
        sys.stderr.write(f"xmlformat: parse error: {e}\n")
        sys.exit(1)

    if has_decl:
        sys.stdout.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    sys.stdout.write(_serialize(root) + "\n")


if __name__ == "__main__":
    main()
