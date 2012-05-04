Return-Path: cosoleto@gmail.com
MIME-Version: 1.0
In-Reply-To: <1336131332.17719.1.camel@offworld>
References: <1336131332.17719.1.camel@offworld>
Date: Fri, 4 May 2012 15:53:20 +0200
Message-ID: <CAMFXF531o-SWQb3-Hcw02jwVBeYnoN8HLcbPfTPTuPxOHj8QEg@mail.gmail.com>
Subject: Re: [PATCH] fdisk: fix segfault on bsd label
From: Francesco Cosoleto <cosoleto@gmail.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

2012/5/4 Davidlohr Bueso <dave@gnu.org>:
> From: Davidlohr Bueso <dave@gnu.org>
>
> Commit 8db8295d824cd0c8cba9385e4635d6e311d69d3f added a regression that causes the program to crash when
> touching the partition structure (pte) for BSD/OSF labels. Since DOS has its own initialization function,
> allow BSD labels to use it as well.
>
> Steps to reproduce:
>
> $> fdisk bsd.img (obtained from blkid regression test files)
> Command (m for help): p
> ...
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disk identifier: 0x00000000
>
> Segmentation fault

Thanks Davidlohr for pointing out that regression. Does it occurs with
the command to print the partition table when the drive has a BSD
label and hasn't a valid DOS label, and it has no partition? Fdisk
switches from BSD label to DOS label without initializing DOS
structures, right?

fdisk.c:
    bsd_command_prompt();
    /* If we return we may want to make an empty DOS label? */
    disklabel = DOS_LABEL;
