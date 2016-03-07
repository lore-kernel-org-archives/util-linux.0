Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbcCGNOB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 08:14:01 -0500
Date: Mon, 7 Mar 2016 14:13:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
Message-ID: <20160307131358.kzu4qb5yu6u7fd4x@ws.net.home>
References: <56D7409A.6050407@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56D7409A.6050407@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 02, 2016 at 08:35:54PM +0100, Stanislav Brabec wrote:
> There are some controversial things with the straightforward fix:
> 
> setsid() prevents TIOCSTI attack described in the report (easy to
> reproduce), but it has side effects: It disconnects the task from job
> control. With setsid(), ^Z cannot be used for sending the application
> to background any more (easy to reproduce by calling setsid()
> unconditionally in the same place).
> 
> su-common.c now calls setsid() only if new session is requested.

Yes, it's pretty stupid situation. 

We have exactly specified setsid() use-cases and now TIOCSTI ioctl
forces us to modify the things (and maybe introduce regressions),
because the crazy ioctl is not possible to disable by any another
way...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
