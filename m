Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53190 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab3AJJ0C (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Jan 2013 04:26:02 -0500
Date: Thu, 10 Jan 2013 10:25:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] ipcmk: allow user to create more ipc resources at a
 time
Message-ID: <20130110092551.GA1729@x2.net.home>
References: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
 <1357760216-4068-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357760216-4068-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 09, 2013 at 07:36:55PM +0000, Sami Kerola wrote:
> There is no reason why 'ipcmk -Q -Q' would should not work, so allow that
> and any other combination of switches such as:

 Well, we can implement whatever, but does it make sense? How many
 people look for the feature?

> ipcmk -Q -Q -p 700 -M 42 -Q -S 13
> 
> The behavior of '-p' changed in this commit. 

 Unacceptable, backwardly incompatible change.


 Sami, if you want to help then try to write tests, many many utils
 and features are still not covered by regression tests (hexdump,
 lsblk, ipc*, dmesg, blockdev, utmpdump, tailf, ....).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
