Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141AbbGXHvN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jul 2015 03:51:13 -0400
Date: Fri, 24 Jul 2015 09:51:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Joel Holdsworth <joel.holdsworth@vcatechnology.com>
Cc: util-linux@vger.kernel.org, Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: Re: [PATCH] build-sys: cal requires both ncurses and tinfo
Message-ID: <20150724075110.GD3432@ws.net.home>
References: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 23, 2015 at 11:56:39PM +0100, Joel Holdsworth wrote:
> From: Joel Holdsworth <joel@airwebreathe.org.uk>
> 
> This fixes a bug in the build system when building without ncurses
> and tinfo. When cal is linked, it depends on both these libraries
> and will fail to link if either of them is not available.

It's optional dependence. I have no problem to to build without the
libs:

  $ ldd ./cal
  linux-vdso.so.1 (0x00007fff9099e000)
  libc.so.6 => /lib64/libc.so.6 (0x0000003f99400000)
  /lib64/ld-linux-x86-64.so.2 (0x0000003f99000000)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
