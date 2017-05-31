Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbdEaUhD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 16:37:03 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Assaf Gordon <assafgordon@gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
Date: Wed, 31 May 2017 22:36:49 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home> <201705312036.39054.sweet_f_a@gmx.de> <20170531200553.GB30064@gmail.com>
In-Reply-To: <20170531200553.GB30064@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201705312236.49632.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 31 May 2017, Assaf Gordon wrote:
> On Wed, May 31, 2017 at 08:36:38PM +0200, Ruediger Meier wrote:
> >musl supports both utmp and utmpx. We are using utmpx. Could you
> > show us all your test diffs?:
> >
> >  find tests/diff -type f  | xargs tail -n +1
>
> Attached.

Thanks. The utmp problem is just another gnu-diff incompatibility. I'll 
fix a few of your issues and send patches later. 

cu,
Rudi


