Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.halfdog.net ([37.186.9.82]:49831 "EHLO mail.halfdog.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965490AbeAKTXO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 Jan 2018 14:23:14 -0500
Received: from [169.254.0.1] (helo=localhost)
        by mail.halfdog.net with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <me@halfdog.net>)
        id 1eZhxd-00019S-V3
        for util-linux@vger.kernel.org; Thu, 11 Jan 2018 18:52:22 +0000
From: halfdog <me@halfdog.net>
To: util-linux@vger.kernel.org
Subject: util-linux mount/unmount ASLR bypass via environment variable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 11 Jan 2018 18:51:59 +0000
Message-ID: <820-1515696719.436169@jYEA.ctRK.4WZD>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello list,

Cleaning up another issue, I noticed that I haven't reported this
one yet. Debugging of libmount can be activated, also in SUID
binaries, thus spilling out the heap addresses. Note that "CXT"
structure contains function pointers to overwrite.

Test:

LIBMOUNT_DEBUG=all /bin/umount /

Output:

2401: libmount:      CXT: [0x562d3abb0760]: ----> allocate [RESTRICTED]
2401: libmount:      CXT: [0x562d3abb0760]: umount: /
2401: libmount:      CXT: [0x562d3abb0760]: umount: lookup FS for '/'
2401: libmount:      CXT: [0x562d3abb0760]: checking for writable tab files
2401: libmount:    UTILS: utab: /run/mount/utab
2401: libmount:    CACHE: [0x562d3abb1950]: alloc
2401: libmount:    CACHE: [0x562d3abb1950]: canonicalize path /
2401: libmount:    CACHE: [0x562d3abb1950]: add entry [ 1] (path): /: /
2401: libmount:      CXT: [0x562d3abb0760]: tabfilter ENABLED!
2401: libmount:      TAB: [0x562d3abb35b0]: alloc
...

The output can easily be used by creating a local domain socket
with only 4k buffer size, filling it up until writes are blocking
and then start umount with that socket as stdout. This allows
race-free reading of the address output before umount accesses
other user-controlled resource. Thus any error during the downstream
procedure creating some kind of write-where vulnerability will
always find the correct target.

hd


