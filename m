Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2174 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab2C3PFB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Mar 2012 11:05:01 -0400
Date: Fri, 30 Mar 2012 17:04:57 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] chkdupexe, a bug, version numbers and bashisms
Message-ID: <20120330150457.GE23437@x2.net.home>
References: <CAG27Bk3Jrh_22adczBYq77u4p7GqmtUw2ELbABU77j3_4SySvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3Jrh_22adczBYq77u4p7GqmtUw2ELbABU77j3_4SySvA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Merged, but

On Tue, Mar 20, 2012 at 08:27:01PM +0100, Sami Kerola wrote:
> Sami Kerola (31):
>       chkdupexe: reimplement command in C

please, send the new chkdupexe to mailing list for review.

>       addpart: align with util-linux coding standards
>       delpart: align with util-linux coding standards

Fixed...

         if ((fd = open(argv[1], O_RDONLY)) < 0)
                err(EXIT_FAILURE, "%s", argv[1]);
         ...
         err(EXIT_FAILURE, "BLKPG");

"%s", "BLKPG" are not usable error messages.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
