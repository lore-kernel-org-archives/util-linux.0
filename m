Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59623 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965024AbcCNMRs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 08:17:48 -0400
Date: Mon, 14 Mar 2016 13:17:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/10] pull: release v2.28 prep work
Message-ID: <20160314121744.iw3hcjnwrzyhpqfu@ws.net.home>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 13, 2016 at 10:31:39AM +0000, Sami Kerola wrote:
>   getopt: fix memory leaks and integer overflows [ASAN & valgrind]

Not applied, it's really not elegant to have private definition of
options struct for getopt_long().

>   lsipc, lslogins, rtcwake: replace asctime() with strftime()

Not applied, I think we need more discussion about it.

>   isosize: stop unmeaningful printing errno message
>   setsid: fix argument count bug
>   bash-completion: fsck.cramfs, isosize: find files an argument
>   bash-completion: ipcmk: add missing completion file
>   bash-completion: lslogins: add missing completion file
>   bash-completion: lsns: add missing completion file
>   docs: update AUTHORS file

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
