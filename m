Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:48802 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab2LSUT5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Dec 2012 15:19:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TlQ7Y-00051c-4m
	for util-linux@vger.kernel.org; Wed, 19 Dec 2012 21:20:04 +0100
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 19 Dec 2012 21:20:04 +0100
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 19 Dec 2012 21:20:04 +0100
To: util-linux@vger.kernel.org
From: "Mantas M." <grawity@gmail.com>
Subject: Re: [PATCH] sys-tools: Add setns utility to sys-tools
Date: Wed, 19 Dec 2012 22:16:10 +0200
Message-ID: <kat7a9$6pv$1@ger.gmane.org>
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2012-12-19 21:06, Neil Horman wrote:
> ...
> +.BR \-u\ <pid> , " \-\-uts=<pid>"
> +Migrate to the uts namespace of <pid>
> +.TP
> +.BR \-i\ <pid> , " \-\-ipc=<pid>"
> +Migrate to the ipc namespace of <pid>
> +.TP
> +.BR \-n\ <pid> , " \-\-net\<pid>"
> +Migrate to the net namespace of <pid>

Wouldn't it be more useful to accept an arbitrary path, and just hand it
to setns(2)? That way, the utility would automatically gain support for
new namespace types (for example `setns /proc/$pid/ns/mount`), and would
allow joining namespaces that are linked outside /proc.

For example, I seem to remember someone saying that `mount --bind
/proc/$pid/ns/net /tmp/foo-namespace` can be used to make that
particular namespace persist even after the process quits. Then `setns
/tmp/foo-namespace someprogram` could be used to join that namespace again.

-- 
Mantas Mikulėnas <grawity@gmail.com>

