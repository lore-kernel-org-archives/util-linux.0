Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60478 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010AbbBFJV0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 6 Feb 2015 04:21:26 -0500
Date: Fri, 6 Feb 2015 10:21:19 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk will happily create a partition of size zero
Message-ID: <20150206092119.GA8546@x2.net.home>
References: <1422698319.1391339.221285309.35047434@webmail.messagingengine.com>
 <54D3CBAE.2000402@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54D3CBAE.2000402@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 05, 2015 at 02:59:42PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 1/31/2015 4:58 AM, Benno Schulenberg wrote:
> > /dev/sda4               93755392  312581807  218826416  104.4G   5
> > Extended |-/dev/sda5             93757440   93757440          0
> > 0B  83 Linux `-Free space            93759488  312581807  218822320
> > 104.4G
> > 
> > Strange.  Start and end of sda5 are on the same sector?
> 
> Looks like there is also an off by one error in the size calculation
> since a partition that starts and ends on the same sector does still
> occupy that one sector, so its size can not be zero.

It was core of the problem -), all this should be already fixed. Try it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
