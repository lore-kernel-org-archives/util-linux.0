Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33448 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbcHOJGr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Aug 2016 05:06:47 -0400
Date: Mon, 15 Aug 2016 11:06:44 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?Q?Micha=C5=82?= Bartoszkiewicz <mbartoszkiewicz@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: empty result from lsns
Message-ID: <20160815090644.ilxb4csjpel6domp@ws.net.home>
References: <CAJzQX7phYjCFRxPP2_yvJzOWOuqLdL5wgi81PR+3HLGveJNo5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAJzQX7phYjCFRxPP2_yvJzOWOuqLdL5wgi81PR+3HLGveJNo5A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 12, 2016 at 11:09:04PM +0200, Michał Bartoszkiewicz wrote:
> End of strace output:
> open("/proc/31676", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 4
> fstat(4, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> fstat(4, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> openat(4, "stat", O_RDONLY)             = 5
> fcntl(5, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> fstat(5, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> read(5, "31676 (ext4-rsv-conver) S 2 0 0 "..., 1024) = 169
> newfstatat(4, "ns/mnt", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
> newfstatat(4, "ns/net", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
> newfstatat(4, "ns/pid", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
> newfstatat(4, "ns/uts", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
> newfstatat(4, "ns/ipc", {st_mode=S_IFREG|0444, st_size=0, ...}, 0) = 0
> newfstatat(4, "ns/user", 0x7ffd30d84020, 0) = -1 ENOENT (No such file
> or directory)
> close(5)                                = 0
> close(4)                                = 0
> getdents(3, /* 0 entries */, 32768)     = 0
> close(3)                                = 0
> close(1)                                = 0
> close(2)                                = 0
> exit_group(0)                           = ?
> +++ exited with 0 +++
> 
> I have user namespaces disabled in my kernel (CONFIG_USER_NS=n).
> I thinkthe reason for the empty output is that the ENOENT for ns/user
> causes read_process to ignore the process completely.

Good point.

Fixed (Well, I have no such kernel, so please test it).

Thanks!
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
