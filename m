Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18223 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411Ab1JCNOQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Oct 2011 09:14:16 -0400
Date: Mon, 3 Oct 2011 15:14:09 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] retire mandoc syntax
Message-ID: <20111003131409.GF1982@nb.net.home>
References: <CAG27Bk2O5ynXup+P_toB4aALK+fumY61tkeEAiLZXKvwrDifTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2O5ynXup+P_toB4aALK+fumY61tkeEAiLZXKvwrDifTQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 18, 2011 at 09:38:17PM +0200, Sami Kerola wrote:
> Hi,
> 
> This is mostly about retiring mandoc syntax. The util-linux uses groff
> man macros instead.
> 
> The following changes since commit 277a6dd53569a409e05316a7bdaed0e78e326762:
> 
>   mount: check for target before source on remount (2011-09-13 22:59:39 +0200)
> 
> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit manuals
> 
> Sami Kerola (15):
>       docs: chcpu and readprofile are sysadmin utils
>       docs: fix return value table in fsck.8

 bug (typo) ...  s/36/32/  Fsck canceled by user request

>       docs: align vipw.8 with howto-man-page.txt
>       docs: align logger.1  with howto-man-page.txt
>       docs: align renice.1 with howto-man-page.txt

 Note, be careful with schetutils and renice, it does not use
 traditional getopt() concept, for example you cannot use

    renice -p <pid> -n <priority>

 The order of the options is very strict and "[-n] <priority>" has to
 be the first argument on the command line. Maybe this rule should be
 mentioned in the -n/--priority description in the man page.

>       docs: align script.1 with howto-man-page.txt
>       docs: align scriptreplay.1 with howto-man-page.txt

 the example scriptreplay.1 uses hidden (hardcoded) typescript file
 and redirection of stderr, it sucks. What about:

   $ script --timing=file.tm file
   ...
   $ scriptreplay --timing file.tm --typescript file


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
