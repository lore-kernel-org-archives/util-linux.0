Return-Path: util-linux-owner@vger.kernel.org
Received: from aserp1040.oracle.com ([141.146.126.69]:44131 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbbFRVB3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Jun 2015 17:01:29 -0400
To: Tom Yan <tom.ty89@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: optimal io size / custom alignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAGnHSE=gtd2WVcxOBoyfqnp3QtT4RHfK356GHastBbiK5mtmFA@mail.gmail.com>
	<20150615133154.GV1992@ws.net.home>
	<CAGnHSEm6wDq_EjJXYwqV2Tt2868DbR0bNRYvevhN1AM4qJpaPw@mail.gmail.com>
	<yq1zj3zfuna.fsf@sermon.lab.mkp.net>
	<CAGnHSEkBXevNmrL7NFO=nKekZdZE6KtzjGvA8sM=onjUfd8KHQ@mail.gmail.com>
	<yq1d20vfimj.fsf@sermon.lab.mkp.net>
	<CAGnHSEnMgivXU_0gDaOkHFkbc=Ve8PaPR0ho8+VhdcUuNu89Gw@mail.gmail.com>
Date: Thu, 18 Jun 2015 17:01:19 -0400
In-Reply-To: <CAGnHSEnMgivXU_0gDaOkHFkbc=Ve8PaPR0ho8+VhdcUuNu89Gw@mail.gmail.com>
	(Tom Yan's message of "Wed, 17 Jun 2015 17:49:51 +0800")
Message-ID: <yq1a8vwenog.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:

Tom> No I put it in the wrong way. What I meant was "sd vs md". For
Tom> example, couldn't the scsi disk driver bind the value it reads from
Tom> the VPD to another variable instead of "optimal i/o size", so that
Tom> this value would be exclusively for RAID (and other virtual
Tom> devices)?

Who says that RAID is a virtual device? Hardware RAID controllers as
well as SAS, iSCSI and Fibre Channel disk arrays all use the Block
Limits VPD to communicate their preferred I/O size and alignment to
us. As do enterprise disk drives.

We deal with broken devices by blacklisting them. I suggest you try to
find a way we can reliably identify your UAS devices. If there is a
common pattern, we can entertain adding a workaround.

-- 
Martin K. Petersen	Oracle Linux Engineering
