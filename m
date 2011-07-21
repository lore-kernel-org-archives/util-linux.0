Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab1GULVc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jul 2011 07:21:32 -0400
Date: Thu, 21 Jul 2011 13:21:28 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Davidlohr Bueso <dave@gnu.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] minix: v3 super-block does not have s_state field
Message-ID: <20110721112128.GE22568@nb.net.home>
References: <1310529931.4444.7.camel@offbook> <CAG27Bk0vW2LZySAf8B38OBbVaXpSDP81C+wVuA1vSW1rwhgwgg@mail.gmail.com> <20110713121232.GC3486@nb.net.home> <CAG27Bk2m+d=N9yVTSbByzhfkMUmP-d7heQXS643uWE3n+05+Mw@mail.gmail.com> <20110713173430.GD3486@nb.net.home> <1310609005.3482.0.camel@offbook> <20110714091829.GE3486@nb.net.home> <CAG27Bk0DYx+jCD-iqQvt1n=VdHszceTEAQQRvCKLvPXqpagTXA@mail.gmail.com> <20110718221926.GE4354@nb.redhat.com> <CAG27Bk3pxKEUPVE92=rZwA-FDHqA81TSM71J0Ati3mFXcGvE3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3pxKEUPVE92=rZwA-FDHqA81TSM71J0Ati3mFXcGvE3g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 20, 2011 at 08:53:11PM +0200, Sami Kerola wrote:
>  disk-utils/Makefile.am           |    4 +-
>  disk-utils/fsck.minix.c          |   99 ++++++++++---------
>  disk-utils/minix.h               |  202 --------------------------------------
>  disk-utils/minix_programs.h      |  113 +++++++++++++++++++++
>  disk-utils/mkfs.minix.c          |   77 +++++++-------
>  include/Makefile.am              |    1 +
>  include/minix.h                  |   97 ++++++++++++++++++
>  libblkid/src/partitions/minix.c  |    6 +-
>  libblkid/src/superblocks/minix.c |   33 +------

 Merged. I have removed the "static" variables from the
 minix_programs.h file. It's better to use normal global variables.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
