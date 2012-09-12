Return-Path: dave@gnu.org
Message-ID: <1347490070.9103.4.camel@offbook>
Subject: Re: [PATCH] blkdiscard: add new command
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Kay Sievers <kay@vrfy.org>
Cc: Lukas Czerner <lczerner@redhat.com>, util-linux@vger.kernel.org,
        kzak@redhat.com
Date: Thu, 13 Sep 2012 00:47:50 +0200
In-Reply-To: <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
	 <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-09-13 at 00:43 +0200, Kay Sievers wrote:
> On Wed, Sep 12, 2012 at 11:49 PM, Lukas Czerner <lczerner@redhat.com> wrote:
> > blkdiscard is used to discard device sectors. This is useful for
> > solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
> > fstrim this command is used directly on the block device.
> 
> Should this maybe live in blockdev(8)?

+1

> 
> It's kind of unfortunate to create standalone tools for every other
> rather exotic block device feature.
> 
> Thanks,
> Kay
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
