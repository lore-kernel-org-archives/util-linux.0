Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:53108 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352AbcCRODq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Mar 2016 10:03:46 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/2] ipcs: more robust and compatible /proc parsing
Date: Fri, 18 Mar 2016 15:03:32 +0100
Cc: util-linux@vger.kernel.org
References: <1458301758-21853-1-git-send-email-sweet_f_a@gmx.de> <20160318134822.hx2f5byqrocdoysn@ws.net.home>
In-Reply-To: <20160318134822.hx2f5byqrocdoysn@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603181503.32657.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 18 March 2016, Karel Zak wrote:
> On Fri, Mar 18, 2016 at 12:49:16PM +0100, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > If this looks ok for shm then we could also add similar patches for
> > sem and msg.
>
> Seems good, I'll wait for complete set of the patches, ok?

For msg and sem we don't have compatibility problems or bugs in real 
life but only these _potential_ fscanf issues. Not so important for 
2.28.

I would like to do that later in a project wide scanf review but without 
hurry.

cu,
Rudi 
