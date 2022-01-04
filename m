Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DF2C433F5
	for <util-linux@archiver.kernel.org>; Tue,  4 Jan 2022 16:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiADQbH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jan 2022 11:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiADQbG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jan 2022 11:31:06 -0500
X-Greylist: delayed 364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jan 2022 08:31:06 PST
Received: from mail.namespace.at (mail.namespace.at [IPv6:2a01:190:1801:100::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C53BC061761
        for <util-linux@vger.kernel.org>; Tue,  4 Jan 2022 08:31:06 -0800 (PST)
Date:   Tue, 4 Jan 2022 17:24:54 +0100
From:   Chris Hofstaedtler <zeha@debian.org>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     1003095@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

[adding util-linux@vger.kernel.org to CC:]

Dear наб,

thank you for your report.

* наб <nabijaczleweli@nabijaczleweli.xyz> [220104 00:06]:
> Package: bsdutils
> Version: 1:2.37.2-5
> Severity: normal
> File: /usr/bin/script
> 
> Dear Maintainer,
> 
> Consider the following:
>   $ script -c 'for i in $(seq 10); do echo $i; done; read -r a; echo a=$a' < term-utils/script.c
> 
> What do you expect to happen here? Well, numbers 1-10, of course, then
> "a=/*" from the heading, right?
> 
> This is, of course, a trick question: that holds on 4.4BSD-Lite script.
>
> However, util-linux script returns:
>   Script started, output log file is 'typescript'.
>
> That's it, it hangs. Due to the funny nature of signal handling here,
> you have to terminate it from a different terminal.
> 
> Stracing it reveals the nature of this beast:
>   $ strace -eread,write,poll script -c 'for i in $(seq 10); do echo a; sleep 0.1; done; read -r a; echo a=$a' < term-utils/script.c
>   read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\22\0\0\0\0\0\0"..., 832) = 832
>   read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@n\2\0\0\0\0\0"..., 832) = 832
>   read(3, "# Locale name alias data base.\n#"..., 3072) = 2996
>   read(3, "", 3072)                       = 0
>   write(1, "Script started, output log file "..., 49Script started, output log file is 'typescript'.
>   ) = 49
>   read(4, "# /etc/nsswitch.conf\n#\n# Example"..., 512) = 510
>   read(4, "", 512)                        = 0
>   read(4, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0003\0\0\0\0\0\0"..., 832) = 832
>   read(4, "root:x:0:\ndaemon:x:1:\nbin:x:2:\ns"..., 2048) = 1768
>   read(7, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\v\0\0\0\v\0\0\0\0"..., 3072) = 2696
>   read(7, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\v\0\0\0\v\0\0\0\0"..., 3072) = 1698
>   poll([{fd=5, events=POLLIN|POLLERR|POLLHUP}, {fd=3, events=POLLIN|POLLERR|POLLHUP}, {fd=0, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1 ([{fd=0, revents=POLLIN}])
>   read(0, "/*\n * Copyright (C) 1980      Re"..., 8192) = 8192
>   write(3, "/*\n * Copyright (C) 1980      Re"..., 8192) = 8192
>   poll([{fd=5, events=POLLIN|POLLERR|POLLHUP}, {fd=3, events=POLLIN|POLLERR|POLLHUP}, {fd=0, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 2 ([{fd=3, revents=POLLIN}, {fd=0, revents=POLLIN}])
>   read(3, "/*\r\n * Copyright (C) 1980      R"..., 8192) = 499
>   write(1, "/*\r\n * Copyright (C) 1980      R"..., 499/*
>    * Copyright (C) 1980      Regents of the University of California.
>    * Copyright (C) 2013-2019 Karel Zak <kzak@redhat.com>
>    *
>    * All rights reserved.
>    *
>    * Redistribution and use in source and binary forms, with or without
>    * modification, are permitted provided that the following conditions
>    * are met:
>    * 1. Redistributions of source code must retain the above copyright
>    *    notice, this list of conditions and the following disclaimer.
>    * 2. Redistributions in binary form must r) = 499
>   read(0, "n log;\t/* already defined */\n\n\tl"..., 8192) = 8192
>   write(3, "n log;\t/* already defined */\n\n\tl"..., 8192
> 
> (This, at least, responds to ^\, but it also seems to function
>  slightly differently. Also, this is a race and you're more
>  likely to lose it under strace. The loopy thing seems
>  like it's pretty good at hitting it 100% of the time.)
> 
> script is deadlocked on writing to the master pty
> against the child writing its data.
> 
> I've found this when re-writing NetBSD script(1) to use a single process
> and poll(2), because I saw poll() in this implementation's strace.
> There are a few ways I see to potentially work around this:
>   1. poll() the master PTY on POLLOUT, too; this doesn't work on NetBSD,
>      because writes to ptys don't seem to shard there ‒ even if the
>      master pty is POLLOUT, writing 1024 bytes to it will block forever,
>      but maybe it will on Linux;
>   2. Forcibly interrupt the write call with an alarm. This sucks ass,
>      of course, but it's the least intrusive if it does work.
>   3. In the original implementation, there's two controlling processes:
>        leader       ‒ main()     ‒ copies stdin to the master pty
>          child      ‒ dooutput() ‒ copies master pty to stdout/fscript
>            subchild ‒ doshell()  ‒ execs $SHELL -i/sh -c "command"
> 
> The original implementation is fundamentally not susceptible to this,
> techically making this the rare "regression against 4.4BSD-Lite".


Alright. Some questions:

1) is this Debian-specific or already present upstream?

2) did this work with previous versions of util-linux?

> Best,
> наб

Best,
Chris

