Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab2HFLLC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Aug 2012 07:11:02 -0400
Date: Mon, 6 Aug 2012 13:10:59 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
Message-ID: <20120806111059.GB24621@x2.net.home>
References: <501D42D2.6050904@draigBrady.com>
 <20120806081533.GA24621@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120806081533.GA24621@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 06, 2012 at 10:15:33AM +0200, Karel Zak wrote:
> I'll fix it to use iscntrl() and \x?? hex (to be consistent our
> another outputs).

Fixed:

 - mount(8) uses '?' like coreutils for control chars (note that
   listing mode in mount(8) is in maintenance mode, use findmnt(8) if
   you want something better)

 - \x<code> is used in findmnt, lsblk, partx, ... for control and non-printable
   chars

 - in the raw and export (NAME=data) output are also replaced already existing
   \x<code> sequences (aaa\x20bbb --> aaa\x5cx20bbb).

   This is not used in the default output to keep it human readable (\x?? is
   pretty common in /dev/disk/by-*).


I have also fixed the way how lib/tt.c counts cells, it's possible
that old findmnt, lsblk, ... versions have a problem with some languages
(e.g JP) where more than one cell is necessary to print one multibyte.


    Karel

