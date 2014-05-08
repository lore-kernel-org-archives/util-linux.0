Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53646 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754921AbaEHU3T (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 May 2014 16:29:19 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: [PATCH] tests: make kill to go-around when /proc is not available
Date: Thu, 8 May 2014 22:29:16 +0200
Cc: "util-linux" <util-linux@vger.kernel.org>
References: <1399482068-6460-1-git-send-email-kerolasa@iki.fi> <201405072212.12680.sweet_f_a@gmx.de> <CAG27Bk0EkS3kha5Gab+1pWDYT3n=dWCc1q=8MdSAaSHF7ouACQ@mail.gmail.com>
In-Reply-To: <CAG27Bk0EkS3kha5Gab+1pWDYT3n=dWCc1q=8MdSAaSHF7ouACQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405082229.16627.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 08 May 2014, Sami Kerola wrote:
> On 7 May 2014 21:12, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > On Wednesday 07 May 2014, Sami Kerola wrote:
> >> [PATCH] tests: make kill to go-around when /proc is not available
> >
> > Do you really want to get it work when whole /proc is not available
> > or just if /proc/$pid/status is still missing?
>
> Hi Rudi,
>
> Right, sloppy from my side. The title should say 'if
> /proc/$pid/status is missing'. Test to check availability of /proc
> should be in test/functions.sh, and where /proc is missing should
> gracefully bail out before starting signal helper. If /proc/$pid is
> available, but not the status file then waiting is unlikely to help,
> and opportunistic sleep is most likely the best option.

Have you also noticed my other comments to the test code?

> I'll write new change before Sunday.

thanks,
Rudi
