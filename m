Return-Path: util-linux-owner@vger.kernel.org
Received: from charlotte.tuxdriver.com ([70.61.120.58]:37715 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969Ab2L1V0w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Dec 2012 16:26:52 -0500
Date: Fri, 28 Dec 2012 16:26:30 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Cc: util-linux@vger.kernel.org, kerolasa@gmail.com, grawity@gmail.com,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2] sys-tools: Enhance unshare command to support the
 switching of namespaces
Message-ID: <20121228212630.GA3483@hmsreliant.think-freely.org>
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
 <1356027729-26098-1-git-send-email-nhorman@tuxdriver.com>
 <50DD9695.4080507@zoho.com>
 <20121228161217.GA5325@neilslaptop.think-freely.org>
 <50DDF41D.9030805@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50DDF41D.9030805@zoho.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 28, 2012 at 08:33:49PM +0100, Ángel González wrote:
> >> There are also pid and user namespaces there, but support for those are
> >> better handled in a different patch IMHO.
> >>
> > I'm not really sure what you mean by a different patch here.  Why would I add
> > support for setns for other pid/uts namespaces in a different patch?
> 
> Because unshare doesn't currently support launching processes in a new
> pid or user namespace. :)
> 
Oh, I see what you mean, sorry.  Yes, I agree, we can add support for both
unsharing and setns abilities when the 3.8 kernel is released.
Neil

> 
> 
> 
