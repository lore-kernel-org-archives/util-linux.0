Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab3LRKzA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Dec 2013 05:55:00 -0500
Date: Wed, 18 Dec 2013 11:54:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: regression bug: user loses DISPLAY & REMOTEHOST with  'su -p -
 username"
Message-ID: <20131218105454.GA21748@x2.net.home>
References: <52B0DA78.8060109@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52B0DA78.8060109@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Linda,

On Tue, Dec 17, 2013 at 03:12:56PM -0800, Linda Walsh wrote:
> 
> "su --preserve_environment - username" no longer preserves
> your REMOTEHOST and DISPLAY values.  They should be
> in the same class as 'TERM', as they are passed from the
> pre-login environment.
> 
> I don't know if there are other values that shouldn't be
> removed -- but it is bad to clear the environment just
> because one wants a shell called with '-<shell>'.

Please, when you call a problem "regression" then it would be nice
to know which version was correct... because util-linxu su(1) is code
from coreutils and I see in the original code as well as in the
current code:

 if (simulate_login) {
    ... reset environment ...

 } else if (change_environment) {  
    ... modify HOME, SHELL, ...
 }


it means that --login and --preserve-environment has been always
mutually exclusive and the latest version prints wanning when the
options are use together. It's also described in the man page.

> The preserve environment flag is NOT incompatible with login.
> It means don't clear the env, but do call login via -<shell>.
> 
> -p means don't clear the ENV -- but do call the user's shell
> with a '-' in front of it.  That has always been the functionality
> of 'su'.
>
> If you want to make 'su' fancier, maybe it needs a "/etc/suers.conf"
> file so specific values can be easily changed to reflect
> site policy rather than hard coding them.

It would be probably better to use PAM for such things.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
