Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20350 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab2FOKqk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 06:46:40 -0400
Date: Fri, 15 Jun 2012 12:46:35 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] require C99, add robustness and small fixes
Message-ID: <20120615104635.GA23464@x2.net.home>
References: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
 <20120611094851.GA21893@x2.net.home>
 <CAG27Bk0AK4rA9TGczXzSnUABd29p0krr-vdPH=Eyp8LO8GpVFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0AK4rA9TGczXzSnUABd29p0krr-vdPH=Eyp8LO8GpVFw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 11, 2012 at 10:19:02PM +0200, Sami Kerola wrote:
> Sami Kerola (13):
>       setarch: do not use -1 as array index [cppcheck]
>       blkid: fix realloc memory leak [cppcheck]
>       uuidd: use output redirection which works [checkbashisms]
>       include: fix spurious list.h warnings
>       build: fix redundant redeclaration warnings
>       build: fix unused parameter warnings
>       sysfs: fix printf format warnings
>       include: fix void pointer arithmetics warnings
>       docs: clean up partx.8 manual
>       eject: inform if CD-ROM drive is not ready
>       wipefs: use symbolic value for markup mode
>       blkdev: add blkdev_scsi_type_to_name()
>       lsblk: use blkdev_scsi_type_to_name()

 Merged, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
