Return-Path: lczerner@redhat.com
Date: Wed, 26 Sep 2012 16:14:25 -0400 (EDT)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Kay Sievers <kay@vrfy.org>
cc: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>,
        util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: [PATCH] blkdiscard: add new command
In-Reply-To: <CAPXgP11oktXSe3yxdOZCMzNOSrfVawtL95nBuM_NYxB9KPvOdA@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1209261612370.31136@dhcp-187-45.bos.redhat.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com> <alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com> <CAPXgP11oktXSe3yxdOZCMzNOSrfVawtL95nBuM_NYxB9KPvOdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="269102523-456632067-1348690466=:31136"
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--269102523-456632067-1348690466=:31136
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Sep 2012, Kay Sievers wrote:

> Date: Wed, 26 Sep 2012 22:04:37 +0200
> From: Kay Sievers <kay@vrfy.org>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: util-linux@vger.kernel.org, kzak@redhat.com
> Subject: Re: [PATCH] blkdiscard: add new command
> 
> On Wed, Sep 26, 2012 at 9:47 PM, Lukáš Czerner <lczerner@redhat.com> wrote:
> > On Wed, 12 Sep 2012, Lukas Czerner wrote:
> >
> >> Date: Wed, 12 Sep 2012 17:49:15 -0400
> >> From: Lukas Czerner <lczerner@redhat.com>
> >> To: util-linux@vger.kernel.org, kzak@redhat.com
> >> Cc: Lukas Czerner <lczerner@redhat.com>
> >> Subject: [PATCH] blkdiscard: add new command
> >>
> >> blkdiscard is used to discard device sectors. This is useful for
> >> solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
> >> fstrim this command is used directly on the block device.
> >>
> >> blkkdiscard uses BLKDISCARD ioctl or BLKSECDISCARD ioctl for the secure
> >> discard.
> >>
> >> All data in the discarded region on the device will be lost!
> >
> > Hi Karel,
> >
> > any progress here ?
> 
> Where is the patch for blockdev?

There is not.

> 
> I'm still convinced randomly named tools per new kernel ioctl is not
> what we want. People should get their act together, and not add the
> tool of the week to util-linux.

And I am still convinced that multiplexing different functionalities
together into a single tool is not always the best way to go,
especially when they does not have nothing in common.

Thanks!
-Lukas

> 
> Thanks,
> Kay
> 
--269102523-456632067-1348690466=:31136--
