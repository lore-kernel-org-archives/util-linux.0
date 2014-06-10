Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:55227 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbaFJNlM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jun 2014 09:41:12 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] build-sys: use gettext 0.18.3 if possible
Date: Tue, 10 Jun 2014 15:41:05 +0200
Cc: util-linux@vger.kernel.org
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de> <201406101404.42618.sweet_f_a@gmx.de> <20140610122300.GI30975@x2.net.home>
In-Reply-To: <20140610122300.GI30975@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406101541.05880.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 10 June 2014, Karel Zak wrote:
> On Tue, Jun 10, 2014 at 02:04:42PM +0200, Ruediger Meier wrote:
> > Ooops, in the cover letter I've mentioned that the new function
> > would probably need some more small portability/safety fixes before
> > final patch. Anyway I'll send them later.
>
> It seems travis does not like the patch.

Hehe, that's the shell portability I had guessed.

Looks like travis' /bin/sh does not have option "-e" for echo:
  warning, force autopoint to use old gettext "-e 0.18"
  ...
  is older. Please upgrade to gettext-"-e 0.18" or newer.

cu,
Rudi
