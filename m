Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab2DQOsK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Apr 2012 10:48:10 -0400
Date: Tue, 17 Apr 2012 16:48:01 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 5/8] sfdisk: fix silly mbyte typo
Message-ID: <20120417144801.GA2391@x2.net.home>
References: <4F8D2D12.8070206@bernhard-voelker.de>
 <4F8D76AB.2090806@draigBrady.com>
 <4F8D7AB3.1010406@bernhard-voelker.de>
 <4F8D7EEF.8060601@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4F8D7EEF.8060601@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 17, 2012 at 03:32:15PM +0100, Pádraig Brady wrote:
> On 04/17/2012 03:14 PM, Bernhard Voelker wrote:
> > On 04/17/2012 03:56 PM, Pádraig Brady wrote:
> >> On 04/17/2012 09:42 AM, Bernhard Voelker wrote:
> >>> Karel Zak wrote:
> >>>
> >>>> On Mon, Apr 16, 2012 at 12:22:12PM +0200, Voelker, Bernhard wrote:
> >>>>> Maybe this is better?
> >>>>>
> >>>>> -	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
> >>>>> +	printf(_("Units = 1MiB, blocks of 1024*1024 bytes"
> >>
> >> Blocks are 1024 bytes in this mode, as confirmed with:
> >> sfdisk -uM -l /dev/sda
> > 
> > I don't understand. What's wrong?
> > 
> > $ wc -c </dev/sda1
> > 12582912000
> > 
> > $ echo '12582912000 / (1024*1024)' | bc
> > 12000
> > 
> > $ ./sfdisk -uM -l /dev/sda | egrep 'sda1|MiB'
> > Units = 1MiB, blocks of 1024*1024 bytes, counting from 0
> >    Device Boot Start   End    MiB    #blocks   Id  System
> > /dev/sda1   *     1  12000  12000   12288000   83  Linux
> 
> Well I thought the "blocks of" was referring to the blocks column,
> rather than the units?
> 
> $ echo $((12582912000 / 1024))
> 12288000

 yep, my +1 was about s/mebibytes/MiB/, I have overlooked the
 1024*1024 math in the patch. Pádraig is right, (s)fdisk uses 1024
 byte blocks in output (probably too keep things more confusing ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
