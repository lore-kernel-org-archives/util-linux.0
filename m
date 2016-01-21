Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.prgmr.com ([71.19.149.6]:38985 "EHLO mail.prgmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbcAUW21 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jan 2016 17:28:27 -0500
Subject: Re: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners
To: Karel Zak <kzak@redhat.com>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
 <20160120103042.clphjleuiesjrl52@ws.net.home>
Cc: "Wayne R. Roth" <wayneroth42@gmail.com>, util-linux@vger.kernel.org
From: Sarah Newman <srn@prgmr.com>
Message-ID: <56A1596C.3060507@prgmr.com>
Date: Thu, 21 Jan 2016 14:19:24 -0800
MIME-Version: 1.0
In-Reply-To: <20160120103042.clphjleuiesjrl52@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/20/2016 02:30 AM, Karel Zak wrote:
> On Tue, Jan 19, 2016 at 10:37:06AM -0800, Wayne R. Roth wrote:
>> Logic copied from sys-utils/swapon.c
> 
> Why? I think swapon is the right place for this check.
> 
>     Karel
> 

Hi Karel,

Warnings are probably best put in *both* mkswap and swapon for the following two reasons:

1. The person(s) reviewing the output for swapon may not be the same person(s) reviewing the output for mkswap. For example, this might happen with a
company with a separate development and quality assurance department.

2. To my best knowledge the release of mkswap and swapon do not have to match. An example of when this might happen is the build process for an
embedded device or virtual machine. I am pretty sure busybox does not warn on world readable swap right now.

This patch does not break any existing behavior. The worst case possibility from accepting this patch is it will annoy some people, and best case it
will save millions of devices from being shipped with insecure permissions.

Thanks, Sarah
