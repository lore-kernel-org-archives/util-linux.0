Return-Path: <SRS0=C4d5=6A=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B14C2BB85
	for <util-linux@archiver.kernel.org>; Thu, 16 Apr 2020 08:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2DA20784
	for <util-linux@archiver.kernel.org>; Thu, 16 Apr 2020 08:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwzulByo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502785AbgDPIxw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:53:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22547 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502964AbgDPIxL (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 16 Apr 2020 04:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587027139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9B2YrrXcb0GtiupZUx77R09vvSKAmzRIrB0mzccBaQ=;
        b=XwzulByo23gMoRe/h+TosZN9akevx8gDqq46UY0etTQI5Hzn9jpMbI3v7cW4xUCSRjwymt
        3LScTWX2dd8huz02qOUFwwJe0vXMpePWep1VDESX7f6YWGA93ldMmc+ESzFS2NPv7E0PvM
        C26NHYYAe9b8CjrYZBSB++wska+Dy1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-ogr8xKYaO-yhKD38abjSMA-1; Thu, 16 Apr 2020 04:52:14 -0400
X-MC-Unique: ogr8xKYaO-yhKD38abjSMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F747800D5C;
        Thu, 16 Apr 2020 08:52:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1737C10027B6;
        Thu, 16 Apr 2020 08:52:10 +0000 (UTC)
Date:   Thu, 16 Apr 2020 10:52:07 +0200
From:   Karel Zak <kzak@redhat.com>
To:     michael-dev@fami-braun.de
Cc:     util-linux@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Fix PID namespace persistence
Message-ID: <20200416085207.t653byxtup4ehlsp@ws.net.home>
References: <20200415211653.5455-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415211653.5455-1-michael-dev@fami-braun.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Eric, can you review this unshare(8) patch? Please.

    Karel

On Wed, Apr 15, 2020 at 11:16:53PM +0200, michael-dev@fami-braun.de wrote:
> From: michael-dev <michael-dev@fami-braun.de>
> 
> After unshare(...) is called, /proc/self/ns/pid does not change.
> Instead, only /proc/self/ns/pid_for_children is affected. So bind-mounting /proc/self/ns/pid results in the original namespace getting bind-mounted.
> 
> Fix this by instead bind-mounting ns/pid_for_children.
> 
> Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
> ---
>  sys-utils/unshare.c | 66 ++++++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 28 deletions(-)
> 
> diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
> index 8652ebdaf..c3ba18e32 100644
> --- a/sys-utils/unshare.c
> +++ b/sys-utils/unshare.c
> @@ -63,7 +63,7 @@ static struct namespace_file {
>  	{ .type = CLONE_NEWIPC,   .name = "ns/ipc"  },
>  	{ .type = CLONE_NEWUTS,   .name = "ns/uts"  },
>  	{ .type = CLONE_NEWNET,   .name = "ns/net"  },
> -	{ .type = CLONE_NEWPID,   .name = "ns/pid"  },
> +	{ .type = CLONE_NEWPID,   .name = "ns/pid_for_children"  },
>  	{ .type = CLONE_NEWNS,    .name = "ns/mnt"  },
>  	{ .type = CLONE_NEWTIME,  .name = "ns/time"  },
>  	{ .name = NULL }
> @@ -361,6 +361,7 @@ int main(int argc, char *argv[])
>  	const char *procmnt = NULL;
>  	const char *newroot = NULL;
>  	const char *newdir = NULL;
> +	pid_t pid_bind = 0;
>  	pid_t pid = 0;
>  	int fds[2];
>  	int status;
> @@ -501,13 +502,37 @@ int main(int argc, char *argv[])
>  			"unsharing of a time namespace (-t)"));
>  
>  	if (npersists && (unshare_flags & CLONE_NEWNS))
> -		bind_ns_files_from_child(&pid, fds);
> +		bind_ns_files_from_child(&pid_bind, fds);
>  
>  	if (-1 == unshare(unshare_flags))
>  		err(EXIT_FAILURE, _("unshare failed"));
>  
> -	if (npersists) {
> -		if (pid && (unshare_flags & CLONE_NEWNS)) {
> +	if (force_boottime)
> +		settime(boottime, CLOCK_BOOTTIME);
> +
> +	if (force_monotonic)
> +		settime(monotonic, CLOCK_MONOTONIC);
> +
> +	if (forkit) {
> +		// force child forking before mountspace binding
> +		// so pid_for_children is populated
> +		pid = fork();
> +
> +		switch(pid) {
> +		case -1:
> +			err(EXIT_FAILURE, _("fork failed"));
> +		case 0:	/* child */
> +			if (pid_bind && (unshare_flags & CLONE_NEWNS))
> +				close(fds[1]);
> +			break;
> +		default: /* parent */
> +      break;
> +		}
> +	}
> +
> +	if (npersists && (pid || !forkit)) {
> +		// run in parent
> +		if (pid_bind && (unshare_flags & CLONE_NEWNS)) {
>  			int rc;
>  			char ch = PIPE_SYNC_BYTE;
>  
> @@ -518,7 +543,7 @@ int main(int argc, char *argv[])
>  
>  			/* wait for bind_ns_files_from_child() */
>  			do {
> -				rc = waitpid(pid, &status, 0);
> +				rc = waitpid(pid_bind, &status, 0);
>  				if (rc < 0) {
>  					if (errno == EINTR)
>  						continue;
> @@ -533,29 +558,14 @@ int main(int argc, char *argv[])
>  			bind_ns_files(getpid());
>  	}
>  
> -	if (force_boottime)
> -		settime(boottime, CLOCK_BOOTTIME);
> -
> -	if (force_monotonic)
> -		settime(monotonic, CLOCK_MONOTONIC);
> -
> -	if (forkit) {
> -		pid = fork();
> -
> -		switch(pid) {
> -		case -1:
> -			err(EXIT_FAILURE, _("fork failed"));
> -		case 0:	/* child */
> -			break;
> -		default: /* parent */
> -			if (waitpid(pid, &status, 0) == -1)
> -				err(EXIT_FAILURE, _("waitpid failed"));
> -			if (WIFEXITED(status))
> -				return WEXITSTATUS(status);
> -			else if (WIFSIGNALED(status))
> -				kill(getpid(), WTERMSIG(status));
> -			err(EXIT_FAILURE, _("child exit failed"));
> -		}
> +	if (pid) {
> +		if (waitpid(pid, &status, 0) == -1)
> +			err(EXIT_FAILURE, _("waitpid failed"));
> +		if (WIFEXITED(status))
> +			return WEXITSTATUS(status);
> +		else if (WIFSIGNALED(status))
> +			kill(getpid(), WTERMSIG(status));
> +		err(EXIT_FAILURE, _("child exit failed"));
>  	}
>  
>  	if (kill_child_signo != 0 && prctl(PR_SET_PDEATHSIG, kill_child_signo) < 0)
> -- 
> 2.17.1
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

