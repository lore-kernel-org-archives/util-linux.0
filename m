Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753419AbeCFKlN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Mar 2018 05:41:13 -0500
Date: Tue, 6 Mar 2018 11:41:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty /etc/issue handling
Message-ID: <20180306104110.k4tis2b23eqykqeh@ws.net.home>
References: <2fb8c760-3be8-a77f-0ab1-ad67ebca63cb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2fb8c760-3be8-a77f-0ab1-ad67ebca63cb@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 06, 2018 at 10:40:14AM +0100, Ludwig Nussel wrote:
> I just noticed that agetty gained support for /etc/issue.d. Very cool!

Thanks, according this feedback
https://github.com/karelzak/util-linux/commit/1fc82a1360305f696dc1be6105c9c56a9ea03f52#commitcomment-27947668

it seems that /etc/issue.d may conflict with already existing
solutions in OpenSUSE. Is it true?

I'll probably add --disable-agetty-issued to make it fully backwardly
compatible.

> Are there any plans to extend the way it reads those files to a systemd
> style layering ie with read only parts in /usr, potentially generated
> ones in /run etc?

Good idea.

> Especially the read only part would be interesting. That way distros
> wouldn't need to ship /etc/isse at all and packages would put their
> extension in /usr. Ie no interference with admin space.

What is expected semantic (order)?

Note that agetty requires the /etc/issue file, the directory is an
extension to the file. The file may be empty or symlink. This is
because "rm /etc/issue" is a way how some admins disable agetty output
at all.

with layering:

 - verify /etc/issue (access F_OK -- required)
 - read /etc/issue.d/*.issue
 - read /run/agetty/issue.d/*.issue
 - read /usr/lib/agetty/issue.d/*.issue

use-case:
    - /etc = system specific files
    - /run = generated files
    - /usr = installed 3rd party files 

right?

IMHO it's too late to implement it for v2.32.

(CC: to our list)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
