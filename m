Return-Path: util-linux-owner@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:24752
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751518AbbGaMOE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 31 Jul 2015 08:14:04 -0400
Date: Fri, 31 Jul 2015 14:14:02 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.27-rc1
Message-ID: <20150731121402.GL3164@type.bordeaux.inria.fr>
References: <20150731112832.GB2619@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150731112832.GB2619@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Karel Zak, le Fri 31 Jul 2015 13:28:32 +0200, a écrit :
> The util-linux release v2.27-rc1 is available

This fails to build on non-Linux systems on the use of signalfd in
term-utils/script.c, introduced by

cc1a88fb59474642fe848491f404890eff1fa5ab
Author: Sami Kerola <kerolasa@iki.fi>
Date:   Fri Dec 26 11:51:00 2014 +0000

    script: use signalfd() to catch signals

Samuel
