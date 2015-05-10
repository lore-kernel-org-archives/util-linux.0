Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35938 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbEJUiD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 May 2015 16:38:03 -0400
Received: by pabsx10 with SMTP id sx10so93245677pab.3
        for <util-linux@vger.kernel.org>; Sun, 10 May 2015 13:38:02 -0700 (PDT)
Date: Sun, 10 May 2015 13:38:08 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix parallel builds w/setarch links
Message-ID: <20150510203807.GA1832@newbook>
References: <1430711464-4943-1-git-send-email-vapier@gentoo.org>
 <55489D6D.9010303@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <55489D6D.9010303@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 05, 2015 at 11:37:33AM +0100, Pádraig Brady wrote:
> On 04/05/15 04:51, Mike Frysinger wrote:
> > From: Mike Frysinger <vapier@chromium.org>
> > 
> > The symlink generation tries to write to the sys-utils/ subdir but does
> > not make sure that dir exists.  This can sometimes lead to parallel build
> > failures when building out-of-tree
> 
> >  $(SETARCH_MAN_LINKS):
> > +	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
> >  	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
> >  
> >  install-exec-hook-setarch:
> 
> The `test -d ... ||` bit is racy and redundant I think

Racy, yes, but no more so than "mkdir -p $DIR && install $FILE $DIR":
it's an inherent limitation of shell scripts.

Redundant, certainly: mkdir -p $DIR is required to succeed if $DIR is
a preexisting directory (though it will fail if part of the path is a
regular file).

Thanks,
Isaac Dunham
