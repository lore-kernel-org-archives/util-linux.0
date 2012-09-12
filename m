Return-Path: kay@vrfy.org
MIME-Version: 1.0
In-Reply-To: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
From: Kay Sievers <kay@vrfy.org>
Date: Thu, 13 Sep 2012 00:43:01 +0200
Message-ID: <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com>
Subject: Re: [PATCH] blkdiscard: add new command
To: Lukas Czerner <lczerner@redhat.com>
Cc: util-linux@vger.kernel.org, kzak@redhat.com
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 12, 2012 at 11:49 PM, Lukas Czerner <lczerner@redhat.com> wrote:
> blkdiscard is used to discard device sectors. This is useful for
> solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
> fstrim this command is used directly on the block device.

Should this maybe live in blockdev(8)?

It's kind of unfortunate to create standalone tools for every other
rather exotic block device feature.

Thanks,
Kay
