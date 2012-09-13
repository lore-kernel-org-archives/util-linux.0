Return-Path: lczerner@redhat.com
Date: Thu, 13 Sep 2012 09:37:30 -0400 (EDT)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Kay Sievers <kay@vrfy.org>
cc: Lukas Czerner <lczerner@redhat.com>, util-linux@vger.kernel.org,
        kzak@redhat.com
Subject: Re: [PATCH] blkdiscard: add new command
In-Reply-To: <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1209130934290.2222@new-host-2>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com> <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Thu, 13 Sep 2012, Kay Sievers wrote:

> Date: Thu, 13 Sep 2012 00:43:01 +0200
> From: Kay Sievers <kay@vrfy.org>
> To: Lukas Czerner <lczerner@redhat.com>
> Cc: util-linux@vger.kernel.org, kzak@redhat.com
> Subject: Re: [PATCH] blkdiscard: add new command
> 
> On Wed, Sep 12, 2012 at 11:49 PM, Lukas Czerner <lczerner@redhat.com> wrote:
> > blkdiscard is used to discard device sectors. This is useful for
> > solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
> > fstrim this command is used directly on the block device.
> 
> Should this maybe live in blockdev(8)?
> 
> It's kind of unfortunate to create standalone tools for every other
> rather exotic block device feature.

Discard is hardly exotic feature nowadays :). But anyway, I was not aware of
blockdev(8) and indeed it seems like a better place to put this
functionality. I'll look into it.

Thanks!
-Lukas

> 
> Thanks,
> Kay
> 
