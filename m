Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f170.google.com ([209.85.128.170]:65189 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759503Ab3BMO7Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Feb 2013 09:59:25 -0500
Received: by mail-ve0-f170.google.com with SMTP id 14so1119425vea.1
        for <util-linux@vger.kernel.org>; Wed, 13 Feb 2013 06:59:24 -0800 (PST)
Date: Wed, 13 Feb 2013 09:52:46 -0500
From: Dave Reisner <d@falconindy.com>
To: Karel Zak <kzak@redhat.com>
Cc: Richard Weinberger <richard@nod.at>, util-linux@vger.kernel.org
Subject: Re: [PATCH] [RFC] switch_root: Add a sanity check
Message-ID: <20130213145246.GR594@rampage>
References: <1360434170-27206-1-git-send-email-richard@nod.at>
 <20130213142536.GA30987@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130213142536.GA30987@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 13, 2013 at 03:25:36PM +0100, Karel Zak wrote:
> On Sat, Feb 09, 2013 at 07:22:50PM +0100, Richard Weinberger wrote:
> > As switch_root basically does rm -Rf / we should make sure
> > that / is really an initramfs.
> 
> Oh, nice (we should not ask for details, right? :-) Applied, thanks.
> 
>     Karel
> 

Wouldn't it be better to check that / is tmpfs or ramfs instead of
insistence on being a very specific device?
