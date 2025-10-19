#Requires AutoHotkey v2.0

merge_objects(default, override) {
    result := {}

    for k, v in default
        result.%k% := v

    for k, v in override
        result.%k% := v

    return result
}
