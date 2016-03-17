Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38393 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbcCQNNW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 09:13:22 -0400
Date: Thu, 17 Mar 2016 14:13:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] build-sys: install missing bash completions
Message-ID: <20160317131320.tj343znddbo6vqex@ws.net.home>
References: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de>
 <1458209046-18526-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458209046-18526-2-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 17, 2016 at 11:04:06AM +0100, Ruediger Meier wrote:
> We haven't installed these files since three years. Hopefully
> they will work.

 I have added tools/checkcompletion.sh (sorry about my shell
 programming skills, it requires bash:-), so now:

 $ make checkcompletion 
 Missing completion scripts:
    agetty
    findfs
    kill
    line
    login
    runuser
    sulogin
    switch_root
    vipw


> +if BUILD_MOUNT
> +dist_bashcompletion_DATA += bash-completion/mount
> +dist_bashcompletion_DATA += bash-completion/umount
> +endif

 ... and checkcompletion does not check for incomplete Makefiles of
 course, but better than nothing.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
