Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:60671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdFSOhb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 10:37:31 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/4] flock: cleanup usage issues
Date: Mon, 19 Jun 2017 16:37:17 +0200
Cc: util-linux@vger.kernel.org
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de> <201706191436.17101.sweet_f_a@gmx.de> <20170619142420.yzmqhilscitwgsmz@ws.net.home>
In-Reply-To: <20170619142420.yzmqhilscitwgsmz@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706191637.17889.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 19 June 2017, Karel Zak wrote:
> On Mon, Jun 19, 2017 at 02:36:17PM +0200, Ruediger Meier wrote:
> > Sorry I forgot that the fputs/puts repacement adds another newline.
> >
> > I could either
> >   1. remove the newlines from the strings (but would this cause
> > extra work for translators?)
> >   2. use printf instead of puts
> >   3. don't change anything, just use constant FILE argument stdout.
>
> I think fputs(..., stdout) is non-invasive change, better than modify
> all strings and probably more effective than printf().
>
>     Karel


I'm using

-static void usage(FILE * out) {
-    FILE * out = stdout;
-    fputs(USAGE_HEADER, out);
+static void usage(void) {
+    FILE * out = stdout;
+    fputs(USAGE_HEADER, out);
    ...
}

This will give the smallest patches when I go through all the other 
commands.

Here it is updated:
https://github.com/karelzak/util-linux/pull/465

cu,
Rudi
