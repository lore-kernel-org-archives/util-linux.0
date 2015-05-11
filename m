Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35029 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbbEKIFf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 May 2015 04:05:35 -0400
Date: Mon, 11 May 2015 10:05:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Isaac Dunham <ibid.ag@gmail.com>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix parallel builds w/setarch links
Message-ID: <20150511080528.GK27969@ws.net.home>
References: <1430711464-4943-1-git-send-email-vapier@gentoo.org>
 <55489D6D.9010303@draigBrady.com>
 <20150510203807.GA1832@newbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150510203807.GA1832@newbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 10, 2015 at 01:38:08PM -0700, Isaac Dunham wrote:
> On Tue, May 05, 2015 at 11:37:33AM +0100, Pádraig Brady wrote:
> > On 04/05/15 04:51, Mike Frysinger wrote:
> > > From: Mike Frysinger <vapier@chromium.org>
> > > 
> > > The symlink generation tries to write to the sys-utils/ subdir but does
> > > not make sure that dir exists.  This can sometimes lead to parallel build
> > > failures when building out-of-tree
> > 
> > >  $(SETARCH_MAN_LINKS):
> > > +	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
> > >  	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
> > >  
> > >  install-exec-hook-setarch:
> > 
> > The `test -d ... ||` bit is racy and redundant I think
> 
> Racy, yes, but no more so than "mkdir -p $DIR && install $FILE $DIR":
> it's an inherent limitation of shell scripts.
> 
> Redundant, certainly: mkdir -p $DIR is required to succeed if $DIR is
> a preexisting directory (though it will fail if part of the path is a
> regular file).

 It seems that 'test || mkdir' is nothing unusual in makefiles. The
 problem is "mkdir -p" portability (at least from autotools point of
 view :-), it seems that the proper way is to use 

    @$(MKDIR_P) $(dir $@)

 rather than directly call mkdir.


    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
