Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498Ab2FOLTm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 07:19:42 -0400
Date: Fri, 15 Jun 2012 13:19:39 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] require C99, add robustness and small fixes
Message-ID: <20120615111939.GB23464@x2.net.home>
References: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
 <20120611094851.GA21893@x2.net.home>
 <CAG27Bk0AK4rA9TGczXzSnUABd29p0krr-vdPH=Eyp8LO8GpVFw@mail.gmail.com>
 <20120615104635.GA23464@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120615104635.GA23464@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 15, 2012 at 12:46:35PM +0200, Karel Zak wrote:
> On Mon, Jun 11, 2012 at 10:19:02PM +0200, Sami Kerola wrote:
> >       blkdev: add blkdev_scsi_type_to_name()
> >       lsblk: use blkdev_scsi_type_to_name()

 I have modified this code. It seems better to return static strings
 from blkdev_scsi_type_to_name() (Please, don't use xalloc.h stuff in
 lib/ as we use the functions from lib/ in shared libraries.)

 It seems better to have fallbacks for unknown SCSI types in
 applications (for example lsblk uses "part" or "disk").

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
