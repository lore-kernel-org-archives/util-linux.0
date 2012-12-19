Return-Path: util-linux-owner@vger.kernel.org
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40249 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab2LSVBP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Dec 2012 16:01:15 -0500
Date: Wed, 19 Dec 2012 16:01:10 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, grawity@gmail.com
Subject: Re: [PATCH] sys-tools: Add setns utility to sys-tools
Message-ID: <20121219210110.GE4390@hmsreliant.think-freely.org>
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>>On 2012-12-19 21:06, Neil Horman wrote:
>> ...
>> +.BR \-u\ <pid> , " \-\-uts=<pid>"
>> +Migrate to the uts namespace of <pid>
>> +.TP
>> +.BR \-i\ <pid> , " \-\-ipc=<pid>"
>> +Migrate to the ipc namespace of <pid>
>> +.TP
>> +.BR \-n\ <pid> , " \-\-net\<pid>"
>> +Migrate to the net namespace of <pid>
>
>Wouldn't it be more useful to accept an arbitrary path, and just hand it
>to setns(2)? That way, the utility would automatically gain support for
>new namespace types (for example `setns /proc/$pid/ns/mount`), and would
>allow joining namespaces that are linked outside /proc.
>
>For example, I seem to remember someone saying that `mount --bind
>/proc/$pid/ns/net /tmp/foo-namespace` can be used to make that
>particular namespace persist even after the process quits. Then `setns
>/tmp/foo-namespace someprogram` could be used to join that namespace again.

Yeah, that makes sense, I'll respin this tomorrow, and repost.  I'm also going
to batch the namespace switches, by opening all the file descriptors first, then
calling setns on them.  It was pointed out to me by doing them one by one like
this, if you setns the mount namespace you might loose access to the paths that
were specified. 

Thanks!
Neil

