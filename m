Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27889 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab2DBLKl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Apr 2012 07:10:41 -0400
Date: Mon, 2 Apr 2012 13:10:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: Re: [PATCH 3/3] chkdupexe: reimplement command in C
Message-ID: <20120402111029.GA1084@x2.net.home>
References: <20120330150457.GE23437@x2.net.home>
 <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
 <1333304372-25944-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333304372-25944-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 01, 2012 at 08:19:32PM +0200, Sami Kerola wrote:
> The new version of the command is nearly identical to old.  Major
> differences are:
> 
> * New output is a little rough what comes to alignment.  This is
>   flagged as FIXME item in source.
> * The command is much quicker than perl implementation which used
>   to exec ls -ldU.
> * Size of chkdupexe binary is about five times bigger than perl
>   script.

I have doubts about chkdupexe, do we really need this command?

 * it provides very rarely used functionality (for example nobody
   complains that the command is missing in Fedora/RHEL ;-)

 * it seems that you can replace it by

    ls $(echo "$PATH" | tr : ' ') | sort | uniq -d

   or we can extend which(1) or so...


 I see two possible ways:

 1) mark chkdupexe as deprecated and remove it from distros

 2) or add new command (lspath ?) and get much more information from
 $PATH (like duplicates, per-directory stats, per-owner stats,
 per-device stats, selinux summary, suids, etc.) and make chkdupexe as
 alias to the new command (just for backward compatibility).

 If 2) makes sense then it would be better to have it in coreutils ;-)


 CC: Padraig

 ... let's flame :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
