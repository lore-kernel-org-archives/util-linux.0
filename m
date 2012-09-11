Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:40261 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753695Ab2IKQb5 convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Sep 2012 12:31:57 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Ondrej Oprala <ooprala@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: RE: segfault message supressed with su -c
Date: Tue, 11 Sep 2012 16:19:04 +0000
Message-ID: <A75C39900FCF0B42A2CE8B26F837D2C305BB3C@MCHP02MSX.global-ad.net>
References: <504F5246.4030304@redhat.com>
In-Reply-To: <504F5246.4030304@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ondrej Oprala wrote: 
> Hi,
> I've written a tiny patch that should fix this issue with su:
> https://bugzilla.redhat.com/show_bug.cgi?id=747592.
> None of the shells' output propagates back
> to the shell where su was called (except TCSH, which reports segfault
> to stdout; I've tested this with sh,ksh,zsh,bash).
> So, with this patch, su should print a warning if
> WIFSIGNALED(status) && WCOREDUMP(status) is true.

Good catch!

> +	      fprintf (stderr, _("Segmentation fault (core dumped)\n"));

Maybe the error message should point out that it
was not su which dumped core ... ;-)

Have a nice day,
Berny

