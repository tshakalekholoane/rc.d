import lldb

# Avoid pathological ReadMemory calls on corrupt data.
max_data_len = 1024


def opt_str8(valobj, internal_dict):
    if valobj.TypeIsPointerType():
        return valobj.GetValue()

    data = valobj.GetChildMemberWithName("data")
    if not data.IsValid():
        return "<invalid opt_t(str8_t) data>"

    data = data.GetValueAsUnsigned(0)
    if not data:
        return "opt_none"

    data_len = valobj.GetChildMemberWithName("data_len")
    if not data_len.IsValid():
        return "<invalid opt_str8_t data_len>"

    data_len = data_len.GetValueAsUnsigned(0)
    if not data_len:
        return 'opt_some("")'

    proc = valobj.GetProcess()
    if not proc.IsValid():
        return "<no process>"

    err = lldb.SBError()

    mem = proc.ReadMemory(data, min(data_len, max_data_len), err)
    if not err.Success() or mem is None:
        return f"<{err.GetCString()}>"

    text = (
        mem.decode("utf-8", "replace")
        .replace("\\", "\\\\")
        .replace('"', '\\"')
        .replace("\n", "\\n")
    )
    text += "..." if data_len > max_data_len else ""

    return f'opt_some("{text}")'


def str8(valobj, internal_dict):
    if valobj.TypeIsPointerType():
        return valobj.GetValue()

    data_len = valobj.GetChildMemberWithName("data_len")
    if not data_len.IsValid():
        return "<invalid str8_t data_len>"

    data_len = data_len.GetValueAsUnsigned(0)
    if not data_len:
        return '""'

    data = valobj.GetChildMemberWithName("data")
    if not data.IsValid():
        return "<invalid str8_t data>"

    data = data.GetValueAsUnsigned(0)
    if not data:
        return "<invalid str8_t: nullptr data with non-zero data_len>"

    proc = valobj.GetProcess()
    if not proc.IsValid():
        return "<no process>"

    err = lldb.SBError()

    mem = proc.ReadMemory(data, min(data_len, max_data_len), err)
    if not err.Success() or mem is None:
        return f"<{err.GetCString()}>"

    text = (
        mem.decode("utf-8", "replace")
        .replace("\\", "\\\\")
        .replace('"', '\\"')
        .replace("\n", "\\n")
    )
    text += "..." if data_len > max_data_len else ""

    return f'"{text}"'
