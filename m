Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35079 "EHLO
	mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcHLVKZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 12 Aug 2016 17:10:25 -0400
Received: by mail-qt0-f173.google.com with SMTP id x25so18309794qtx.2
        for <util-linux@vger.kernel.org>; Fri, 12 Aug 2016 14:09:05 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Micha=C5=82_Bartoszkiewicz?= <mbartoszkiewicz@gmail.com>
Date: Fri, 12 Aug 2016 23:09:04 +0200
Message-ID: <CAJzQX7phYjCFRxPP2_yvJzOWOuqLdL5wgi81PR+3HLGveJNo5A@mail.gmail.com>
Subject: empty result from lsns
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lsns from util-linux 2.28.1 does not display anything on my system.

End of strace output:
open("/proc/31676", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 4
fstat(4, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
fstat(4, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
openat(4, "stat", O_RDONLY)             = 5
fcntl(5, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
fstat(5, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
read(5, "31676 (ext4-rsv-conver) S 2 0 0 "..., 1024) = 169
newfstatat(4, "ns/mnt", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
newfstatat(4, "ns/net", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
newfstatat(4, "ns/pid", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
newfstatat(4, "ns/uts", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
newfstatat(4, "ns/ipc", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
newfstatat(4, "ns/user", 0x7ffd30d84020, 0) = -1 ENOENT (No such file
or directory)
close(5)                                = 0
close(4)                                = 0
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
close(1)                                = 0
close(2)                                = 0
exit_group(0)                           = ?
+++ exited with 0 +++

I have user namespaces disabled in my kernel (CONFIG_USER_NS=n).
I thinkthe reason for the empty output is that the ENOENT for ns/user
causes read_process to ignore the process completely.

Thanks,
--
Michał Bartoszkiewicz <mbartoszkiewicz@gmail.com>
