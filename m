Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59863 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab3JOI1h (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Oct 2013 04:27:37 -0400
Date: Tue, 15 Oct 2013 10:27:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] a few more man-page improvements
Message-ID: <20131015082731.GA31477@x2.net.home>
References: <1381783511.18298.33939989.442C9894@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381783511.18298.33939989.442C9894@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 14, 2013 at 10:45:11PM +0200, Benno Schulenberg wrote:
> 
> Attached is another small set of man-page tweaks.  The second
> patch is a big one: it standardizes the phrases for the --help
> and --version options in all man pages.
> 
> 
> By the way, when trying to build util-linux from git, I get errors
> for mount and getopt.  The output of a second 'make -k':
> 
> make  all-recursive
> make[1]: Entering directory `/home/ben/UTLNX'
> Making all in po
> make[2]: Entering directory `/home/ben/UTLNX/po'
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory `/home/ben/UTLNX/po'
> make[2]: Entering directory `/home/ben/UTLNX'
> rm: cannot remove 'mount': Is a directory
> make[2]: *** [mount] Error 1
> rm: cannot remove 'getopt': Is a directory
> make[2]: *** [getopt] Error 1
> make[2]: Target `all-am' not remade because of errors.
> make[2]: Leaving directory `/home/ben/UTLNX'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/ben/UTLNX'
> make: *** [all] Error 2
> 
> This has been like this for quite a while.  I thought I must be
> doing something wrong or missing some tool, but I wonder.
> 
> Trying a 'make clean' ends in:
> 
> Making clean in .
> make[1]: Entering directory `/home/ben/UTLNX'
>  rm -f dmesg mount umount wdctl mountpoint lsblk findmnt kill
> rm: cannot remove 'mount': Is a directory
> make[1]: *** [clean-binPROGRAMS] Error 1
> make[1]: Leaving directory `/home/ben/UTLNX'
> make: *** [clean-recursive] Error 1

 Oh, it seems you have very old stuff in your work tree, try:
 
    git clean -xdf
    git checkout -f
 
 or you can delete all and git clone again ;-)
 
    Karel
 
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
