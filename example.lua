-- this function will be executed first
function checkRAW()

    local protoType = GetHEPProtoType()

    Logp("DEBUG", "protoType", protoType)

    -- Check if we have SIP type
    if protoType ~= 1 then
        return
    end

    -- original SIP message Payload
    local raw = GetRawMessage()
    Logp("DEBUG", "raw", raw)

    -- local _, _, name, value = string.find(raw, "(Call-ID:)%s*:%s*(.+)")
    -- local name, value = raw:match("(CSeq):%s+(.-)\n")

    -- Set the raw message back
    SetRawMessage(raw)

    return

end

-- this function will be executed second
function checkHEP()

    -- get GetHEPSrcIP
    local src_ip = GetHEPSrcIP()

    Logp("ERROR", "src_ip:", src_ip)

    -- a struct can be nil so better check it
    if (src_ip == nil or src_ip == '') then
        return
    end

    if src_ip == "10.153.177.21" then
        Logp("ERROR", "found bad src IP:", src_ip)
        local new_ip = "1.1.1.1"
        SetHEPField("SrcIP", new_ip)
        Logp("ERROR", "replace to new src IP:", new_ip)
    end

    local dst_ip = GetHEPDstIP()

    -- a struct can be nil so better check it
    if (dst_ip == nil or dst_ip == '') then
        return
    end

    if dst_ip == "10.153.177.21" then
        Logp("ERROR", "found bad dst IP:", dst_ip)
        local new_ip = "8.8.8.8"
        SetHEPField("DstIP", new_ip)
        Logp("ERROR", "replace to new dst IP:", new_ip)
    end

    -- ports

    local src_port = GetHEPSrcPort()

    if src_port == 5060 then
        Logp("ERROR", "found bad src port", src_port)
        local new_src_port = "9060"
        SetHEPField("SrcPort", new_src_port)
        Logp("ERROR", "set new port ", new_src_port)
    end

    local dst_port = GetHEPDstPort()

    if dst_port == 5060 then
        Logp("ERROR", "found bad dst port", dst_port)
    end

    SetHEPField("DstPort", "9999")

    return

end
