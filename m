Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbaEZJ5y (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 05:57:54 -0400
Date: Mon, 26 May 2014 11:57:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: add rename(1) checks
Message-ID: <20140526095744.GC2968@x2.net.home>
References: <1401055103-28558-1-git-send-email-kerolasa@iki.fi>
 <1401055103-28558-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401055103-28558-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 25, 2014 at 10:58:23PM +0100, Sami Kerola wrote:
> Check basic file moves, symlink relinking, and both file moves and
> symlinks when operations are have directory in destination path.

 Thanks!

> +mkdir rename_a{a,b}
> +touch rename_a{a,b}/aa
> +$TS_CMD_RENAME -v a x rename_a?/aa >> $TS_OUTPUT 2>&1
> +find rename_a{a,b} >> $TS_OUTPUT 2>&1

 Please, keep $CWD, ts/* and expected/* read-only. The test has to
 write to $TS_OUTDIR only.

   mkdir $TS_OUTDIR/rename_a{a,b}
   touch $TS_OUTDIR/rename_a{a,b}/aa
   ...

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
