Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:50338 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320Ab3AYPHd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 10:07:33 -0500
Date: Fri, 25 Jan 2013 16:07:28 +0100
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 3/5] nsenter: respect --exec no matter where it appears
Message-ID: <20130125150728.GR4278@in.waw.pl>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
 <1358750287-17732-4-git-send-email-zbyszek@in.waw.pl>
 <20130125150255.GM27413@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130125150255.GM27413@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 25, 2013 at 04:02:55PM +0100, Karel Zak wrote:
> On Mon, Jan 21, 2013 at 01:38:03AM -0500, Zbigniew Jędrzejewski-Szmek wrote:
> >  sys-utils/nsenter.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> 
>  It seems necessary for --all only, right?
Hm, no. If I understand the (original) code correctly, doing something
like 'nsenter --exec --pid' would ignore the '--exec' argument.

Zbyszek

