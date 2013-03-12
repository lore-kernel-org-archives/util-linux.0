Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755183Ab3CLOmx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Mar 2013 10:42:53 -0400
Date: Tue, 12 Mar 2013 15:29:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/7] kill: modernization after undeprecation
Message-ID: <20130312142958.GA26680@x2.net.home>
References: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 07, 2013 at 11:27:17PM +0000, Sami Kerola wrote:
> Sami Kerola (7):
>       kill: add long options
>       kill: align with howto-usage-function.txt
>       kill: use libc error printing facilities and exit values
>       kill, procs: fix coding style

>       kill, procs: move function declarations to kill.h

  Not applied this one. The include/ headers are usually for lib/
  stuff. The another reason that the misc-util/proc.c code would be
  better to move to lib/procutils.c (after some refactoring) -- I'll
  do that.

>       kill, procs: use pid_t for pids
>       docs: add long options and tidy up kill.1
> 
>  misc-utils/kill.1  |  88 ++++++-----
>  misc-utils/kill.c  | 442 ++++++++++++++++++++++++++---------------------------
>  misc-utils/kill.h  |   8 +-
>  misc-utils/procs.c | 170 +++++++++++----------
>  4 files changed, 360 insertions(+), 348 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
