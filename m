Return-Path: jrnieder@gmail.com
Date: Wed, 25 Apr 2012 10:16:03 -0500
From: Jonathan Nieder <jrnieder@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH] sfdisk: fix calculation due to type mismatch (ix86)
Message-ID: <20120425151603.GA31410@burratino>
References: <1333723993-11424-1-git-send-email-petr.uzel@suse.cz>
 <20120410103422.GJ19784@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120410103422.GJ19784@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

Karel Zak wrote:
> On Fri, Apr 06, 2012 at 04:53:13PM +0200, Petr Uzel wrote:

>> Addresses: https://bugzilla.novell.com/show_bug.cgi?id=754789
>> Reported-by: Dan Mares <dan.mares@norcrossgroup.com>
>> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
>
>  Ah.. pretty dirty bug. Applied, thanks.

(This is 9c45d49fe01c "sfdisk: fix calculation due to type mismatch
(ix86)".)  Thanks.  Do you think this fix might belong in currently
maintained stable/ branches, too, and if so, how can I help make that
happen?

Context: http://bugs.debian.org/670127

Sincerely,
Jonathan
