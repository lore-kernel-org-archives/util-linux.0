Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: scsi_debug, iosize optimal < minimum
Date: Wed, 3 Feb 2016 22:55:44 +0100
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Douglas Gilbert <dgilbert@interlog.com>
References: <201601291131.29201.sweet_f_a@gmx.de> <201601291718.21185.sweet_f_a@gmx.de> <yq1fuxcr5lk.fsf@sermon.lab.mkp.net>
In-Reply-To: <yq1fuxcr5lk.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201602032255.44508.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 01 February 2016, Martin K. Petersen wrote:
> >>>>> "Ruediger" == Ruediger Meier <sweet_f_a@gmx.de> writes:
>
> Ruediger> I've noticed a possible problem with scsi_debug devices
> where Ruediger> optimal_io_size < minimum_io_size.
>
> Ruediger> The problem seems reproducable with kernel 4.4.0 and also
> with Ruediger> stable version 4.1.15. For stable tree the last known
> working Ruediger> version is 4.1.13.
>
> http://git.kernel.org/cgit/linux/kernel/git/mkp/scsi.git/commit/?h=4.
>5/scsi-fixes&id=d0eb20a863ba7dc1d3f4b841639671f134560be2


Ah thanks!

But I'm still wondering a bit. Using kernel 4.5-rc2 (where 9c1d9c20 and 
d0eb20a8 is included) I get

$ getconf PAGESIZE
4096
$ modprobe scsi_debug
$  cat /sys/block/$devname/queue/{minimum_io_size,optimal_io_size}
512
524288

In past (kernel<=4.1) optimal_io_size io size was 32768. Is this really 
correct now?

cu,
Rudi
