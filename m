Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:56391 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbaE0OvD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 May 2014 10:51:03 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] cal: all output must use my_putstring
Date: Tue, 27 May 2014 16:50:54 +0200
Cc: util-linux@vger.kernel.org,
        =?iso-8859-1?q?P=E1draig_Brady?= <P@draigbrady.com>
References: <201405271250.41256.sweet_f_a@gmx.de> <1401196025-7090-1-git-send-email-sweet_f_a@gmx.de> <20140527141203.GG2968@x2.net.home>
In-Reply-To: <20140527141203.GG2968@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405271650.54650.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 27 May 2014, Karel Zak wrote:
> On Tue, May 27, 2014 at 03:07:05PM +0200, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > Replace all puts, fputs and printf calls by my_putstring() because
> > we don't want to mix different output channels (buffers).
>
>  Oh, this is well know problem I fixed one year ago, see
>  e66ba1bfaf070682e26c1a53e64af1088fea56bc.

Funny that this one was also a fix for Fedora 18. Probably F-18 has bad 
ncurses-libs or glibc because usually it seemed to be compatible to 
printf function family.

putp() uses tputs() which uses putc() per default. putc() should be 
mixable with any other stdio output function.

cu,
Rudi



