Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21916 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab2I0RDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Sep 2012 13:03:36 -0400
Date: Thu, 27 Sep 2012 13:03:30 -0400 (EDT)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
cc: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
In-Reply-To: <yq14nmja2kd.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LFD.2.00.1209271242550.31136@dhcp-187-45.bos.redhat.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com> <alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com> <20120927094256.GA18644@x2.net.home> <alpine.LFD.2.00.1209271113040.31136@dhcp-187-45.bos.redhat.com>
 <yq14nmja2kd.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810047-1520344557-1348765412=:31136"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810047-1520344557-1348765412=:31136
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Sep 2012, Martin K. Petersen wrote:

> Date: Thu, 27 Sep 2012 11:49:22 -0400
> From: Martin K. Petersen <martin.petersen@oracle.com>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
> Subject: Re: [PATCH] blkdiscard: add new command
> 
> >>>>> "Lukáš" == Lukáš Czerner <lczerner@redhat.com> writes:
> 
> Lukáš> TBH this is fugly :). Also what actually is the advantage of
> Lukáš> doing this ? So we saved 50 lines of code for this ugliness and
> Lukáš> instead of two separate binaries we have this one hybrid and
> Lukáš> symlink. I am not sure it's worth it. Can't we just have two
> Lukáš> separate binaries ? What is the problem with that ?
> 
> It's not just discard. We should also consider the zeroout and write
> same use cases. They have nothing to do with fstrim.
> 
> Time to incorporate and extend Garzik's blktool, perhaps?
> 

Hmm, I do not know. blktool seems to be very similar to blockdev in
the sense that it is for querying and changing block device setting
which is not what we do with, discard, write same or zeroout where
we actually change the data on the device itself. In my mind it just
somehow does not fit there.

But you're right that it is not just about discard or secure
discard, we have other quite similar functionalities and it might be
worth having one separate tool for all those, thanks for pointing this
out.

(CCing linux-fsdevel ... for the whole discussion see
http://www.spinics.net/lists/util-linux-ng/msg06832.html)

Thanks!
-Lukas
---1463810047-1520344557-1348765412=:31136--
