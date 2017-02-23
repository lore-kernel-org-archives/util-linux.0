Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbdBWQlK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Feb 2017 11:41:10 -0500
Date: Thu, 23 Feb 2017 17:33:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Shaun Tancheff <shaun@tancheff.com>,
        Util-Linux <util-linux@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
Message-ID: <20170223163303.22arjqv27brm3p3k@ws.net.home>
References: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
 <20170216103352.rxt4jyxry6zpuxrb@ws.net.home>
 <1487247307.2341564.882965648.11DC77E0@webmail.messagingengine.com>
 <ea1698c4-b055-e498-b154-d8931817bc36@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea1698c4-b055-e498-b154-d8931817bc36@wdc.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 17, 2017 at 09:12:29AM +0900, Damien Le Moal wrote:
> Benno,
> 
> On 2/16/17 21:15, Benno Schulenberg wrote:
> > 
> > On Thu, Feb 16, 2017, at 11:33, Karel Zak wrote:
> >>   blkzone report [--zone <offset>] [--count <length>]
> >>   blkzone reset  [--zone <offset>] [--count <length>]
> > 
> > "blkzone --zone" feels a bit strange.  I would suggest:
> > 
> >   blkzone <command> [--offset <sector>] [--count <number>]
> 
> Indeed, it is a little awkward. And to be consistent with other tools
> such as blkdiscard, I would also suggest --length instead of --count.
> 
> So:
> 
> blkzone report [--offset <offset>] [--length <length>]
> blkzone reset  [--offset <offset>] [--length <length>]

 blkzone(8) implemented, blkreset and blkreport removed. 

 Please, retest and review:
 https://github.com/karelzak/util-linux/blob/master/sys-utils/blkzone.c
 https://github.com/karelzak/util-linux/blob/master/sys-utils/blkzone.8

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
