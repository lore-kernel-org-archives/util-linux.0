Return-Path: util-linux-owner@vger.kernel.org
Received: from shell.v3.sk ([92.60.52.57]:59830 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755458AbeDWON6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 23 Apr 2018 10:13:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7BD60AB6F5
        for <util-linux@vger.kernel.org>; Mon, 23 Apr 2018 16:07:51 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CaqS8_N73y8B for <util-linux@vger.kernel.org>;
        Mon, 23 Apr 2018 16:07:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DCD72AB6F9
        for <util-linux@vger.kernel.org>; Mon, 23 Apr 2018 16:07:41 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bHR8QGXM_dJQ for <util-linux@vger.kernel.org>;
        Mon, 23 Apr 2018 16:07:41 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id F3F20AB6F5
        for <util-linux@vger.kernel.org>; Mon, 23 Apr 2018 16:07:40 +0200 (CEST)
Message-ID: <1524492459.713764.57.camel@v3.sk>
Subject: terminal-colors.d(5) clarifications needed
From: Lubomir Rintel <lkundrak@v3.sk>
To: util-linux@vger.kernel.org
Date: Mon, 23 Apr 2018 16:07:39 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi everyone,

we (the NetworkManager crowd) are currently pondering addition of
terminal-colors.d(5) support to nmcli, our command line utility.

We intend to be consistent with the specification and ideally implement
it the same way as the existing implementations. There's several
details I feel should be cleared up before my work [1] could be
merged. 

[1] https://cgit.freedesktop.org/NetworkManager/NetworkManager/commit/?
h=lr/nmcli-colors&id=db7479c

Here's my notes:

1.) It is unclear whether multiple .schem files should override each
    other or be merged. We use the overriding behavior -- take the
    highest priority one and ignore the rest.

2.) Is "name.schem" or "@term.schem" "more specific"? We assume it's
    "name.schem".

3.) What is the "Color names" paragraph for? How was the set chosen?
    (Why is "white" not present?) Can it be used in place of
    an ansi-sequence and translated somehow? We just ignore it.

4.) Of what use would "Escape sequences" in ansi-sequence be? We don't
    accept that.

5.) We don't implement TERMINAL_COLORS_DEBUG because it's unclear what
    should it do.

Perhaps you could help me getting things done right, comment on the
points above, and maybe figure out how can the manual be improved for
future implementers?

Thanks,
Lubo
