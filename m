Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758843AbaEMIXz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 May 2014 04:23:55 -0400
Date: Tue, 13 May 2014 10:23:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: bugs on exotic archs
Message-ID: <20140513082349.GL8951@x2.net.home>
References: <201405122045.18801.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405122045.18801.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 12, 2014 at 08:45:18PM +0200, Ruediger Meier wrote:
> Hi,
> 
> If somebody of you wants to do some sports...
> 
> Here I have a list of failing tests on certain architectures. If you own 
> such system you may want to confirm and fix the one or the other issue. 
> IMO most interesting are the fdisk failures on ppc and ppc64 and 
> utmpdump on aarch64 which are IMO real bugs. The other ones might be 
> bugs in the test suite or broken build hosts.
> 
> Failing test on certain archs:
> 
> %ifarch ppc ppc64
>   hexdump

 this is not a bug, but the hexdump test disadvantage -- the output
 may be different on big-endian if the output is composed from more input bytes.

>   fdisk/bsd

 BSD disklabel location depends on arch 

> %endif
> 
> %ifarch ppc
>   fdisk/gpt

 this is strange

> %endif
> 
> %ifarch armv6l armv7l aarch64
>   misc/setarch

 setarch: armv7l: Unrecognized architecture

> %endif
> 
> %ifarch armv6l aarch64
>   fdisk/gpt
>   fdisk/oddinput
>   fdisk/sunlabel

   Unsupported ioctl: cmd=0xffffffff801c0204 (1c)

>   misc/ionice

   qemu: Unsupported syscall: 314
   ionice: ioprio_set failed: Function not implemented

>   misc/swaplabel

   Unsupported ioctl: cmd=0xffffffff801c0204 (1c)

>   kill/name
>   kill/print_pid

  kill: cannot find process "naYZRDhfqEzs9bP".

> %endif
> 
> %ifarch aarch64
>   utmpdump
> %endif

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
