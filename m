Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435AbbAFJmq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Jan 2015 04:42:46 -0500
Date: Tue, 6 Jan 2015 10:42:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/14] pull: chsh, newgrp, and script changes
Message-ID: <20150106094233.GA18528@x2.net.home>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

On Mon, Dec 22, 2014 at 11:47:03AM +0000, Sami Kerola wrote:
>   chsh: remove function prototypes
>   chfn, chsh: share illegal_passwd_chars() function
>   chsh: use getline() to support arbitrarily long lines
>   chsh: set few variables read-only and rename one of them
>   chsh: allow user to set shell to /bin/sh if none is set
>   chsh: clean up parse_argv()
>   chsh: rewrite function interacting with user to get path to new shell
>   chsh: simplify check_shell()
>   chsh: fail get_shell_list() check when /etc/shells cannot be opened
>   newgrp: simplify if else clauses
>   newgrp: move shell determination closer where it is used
>   newgrp: set function arguments read-only when possible

I have merged 'chsh' and 'newgrp' branches from github.

>   script: remove function prototypes
>   script: add struct script_control and remove global variables

I'm going to merge this together with another changes from 'script' branch.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
