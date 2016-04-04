Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:59023 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838AbcDDJHf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Apr 2016 05:07:35 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 1/3] chrt: make --sched-* short options to require an argument
Date: Mon, 4 Apr 2016 10:07:11 +0100
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi> <20160404002100.eqclqk2rqbttbued@ws.net.home> <20160404082749.tqyzkgyba2ed77kr@ws.net.home>
In-Reply-To: <20160404082749.tqyzkgyba2ed77kr@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604041107.12672.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 04 April 2016, Karel Zak wrote:
> On Mon, Apr 04, 2016 at 02:21:00AM +0200, Karel Zak wrote:
> > On Sun, Apr 03, 2016 at 09:35:27AM +0100, Sami Kerola wrote:
> > > These options are expecting an argument, and the long options
> > > struct already required them.
> >
> >  Good catch, but deadline and runtime should be optional arguments
> > (it seems I have merged wrong version of my patch:-(
>
> Sorry, didn't read the patch correctly. You're right. Applied,
> thanks.

BTW I like the coreutils convention that new options with optional 
arguments should be long options only. This is less confusing for the 
users.

cu,
Rudi
