Return-Path: util-linux-owner@vger.kernel.org
Received: from quantum.linuxfromscratch.org ([216.171.237.234]:34502 "EHLO
	quantum.linuxfromscratch.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752541Ab2CILiM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Mar 2012 06:38:12 -0500
MIME-Version: 1.0
Date: Fri, 9 Mar 2012 4:30:02 -0700
From: Matthew Burgess <matthew@linuxfromscratch.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount -f regression in v2.21's new-mount
In-Reply-To: <20120309105304.GF17711@x2.net.home>
References: <20120309105304.GF17711@x2.net.home>
Message-ID: <5fde29ffbccb41cf5eb3a286c2f7e954@quantum.linuxfromscratch.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 9 Mar 2012 11:53:04 +0100, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Mar 08, 2012 at 08:25:00PM +0000, Matt Burgess wrote:
>> I've attached LIBMOUNT_DEBUG output from the 'mount -a' call that our
>> bootscript does.  Note how mount correctly detects that /proc, /sys
> 
>  No, it calls mount(2) syscall for /proc. The problem is that the
>  detection code expects /proc/self/mountinfo (used on systems with
>  mtab -> /proc/mounts symlink), but your system uses regular mtab.
> 
>  I'll fix it. Thanks.

Thanks!  Is there a consensus opinion on whether users should be
using a regular mtab or a symlink to /proc/self/mountinfo?

Regards,

Matt.

