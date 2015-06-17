Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32876 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbbFQJtw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Jun 2015 05:49:52 -0400
MIME-Version: 1.0
In-Reply-To: <yq1d20vfimj.fsf@sermon.lab.mkp.net>
References: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
	<20150615133154.GV1992@ws.net.home>
	<CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
	<yq1zj3zfuna.fsf@sermon.lab.mkp.net>
	<CAGnHSEkBXevNmrL7NFO=nKekZdZE6KtzjGvA8sM=onjUfd8KHQ@mail.gmail.com>
	<yq1d20vfimj.fsf@sermon.lab.mkp.net>
Date: Wed, 17 Jun 2015 17:49:51 +0800
Message-ID: <CAGnHSEnMgivXU_0gDaOkHFkbc=Ve8PaPR0ho8+VhdcUuNu89Gw@mail.gmail.com>
Subject: Re: optimal io size / custom alignment
From: Tom Yan <tom.ty89@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 17 June 2015 at 05:28, Martin K. Petersen <martin.petersen@oracle.com> wrote:
> There are plenty of SSDs that report 4K physical sectors, fwiw.

Oh didn't know that. Wonder if it's yet another garbage info. Though
4k is often a nice value to make use of.

> We gave up on USB-SATA bridges long ago. Their designers appear to have
> a pretty comprehensive misunderstanding of both the ATA and SCSI
> protocols.

Aren't there tons of thumb drives make use of it anyway?

> Tom> I just feel like the kernel shouldn't bind values from totally
> Tom> different source (raid stripe vs vpd limit) to the same variable.
>
> RAID devices communicate the stripe width through the Block Limits VPD.

No I put it in the wrong way. What I meant was "sd vs md". For
example, couldn't the scsi disk driver bind the value it reads from
the VPD to another variable instead of "optimal i/o size", so that
this value would be exclusively for RAID (and other virtual devices)?
Is it even necessary for it to report? Because it seems only to make
this variable ambiguous.

If it HAS TO BE ambiguous, I see no reason why fdisk should use it to
derive the alignment. It should simply let the users do their
judgement and provide a way for them to adjust manually.
