Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbaFDKV1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Jun 2014 06:21:27 -0400
Date: Wed, 4 Jun 2014 12:21:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: build-sys: how to install pylibmount after libmount?
Message-ID: <20140604102117.GU9000@x2.net.home>
References: <201406031552.50670.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406031552.50670.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 03, 2014 at 03:52:50PM +0200, Ruediger Meier wrote:
> Hi,
> 
> This should be easy to reproduce if you don't have a global installed 
> libmount.
> 
> $ sudo mkdir /usr/lib64/away
> $ sudo mv /usr/lib64/libmount.* /usr/lib64/away
> 
> $ ./configure --disable-use-tty-group \
> 	--prefix=/tmp/dest \

 Just note, it's usually bad idea to override the default prefix
 (especially for package like util-linux), it's better to use 
 standard prefix and use "make install  DESTDIR=/tmp/dest".

> Unfortunately some systems set per default
>   link_all_deplibs=no
> instead of "unknown" in ./libtool. Don't know whether this is a bug in 
> libtool or automake macros. But we could work around this if we would 
> make sure to install pylibmount always after libmount.
> 
> This is how it looks in Makefile.in:
> install-exec-am: install-binPROGRAMS install-dist_usrbin_execSCRIPTS \
>         install-pylibmountexecLTLIBRARIES \
>         install-pylibmountexecSCRIPTS install-sbinPROGRAMS \
>         install-usrbin_execPROGRAMS install-usrlib_execLTLIBRARIES \
>         install-usrsbin_execPROGRAMS
>         @$(NORMAL_INSTALL)
>         $(MAKE) $(AM_MAKEFLAGS) install-exec-hook
> 
> How could we force to put
>   install-pylibmountexecLTLIBRARIES
> after
>   install-usrlib_execLTLIBRARIES

hmm.. I don't know, I think it's libtool job to generate the right order.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
