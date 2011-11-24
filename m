Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38932 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045Ab1KXJ3O (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Nov 2011 04:29:14 -0500
Message-ID: <4ECE0E68.4000104@suse.de>
Date: Thu, 24 Nov 2011 10:29:12 +0100
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
Cc: Thorsten Kukuk <kukuk@suse.de>, util-linux@vger.kernel.org
Subject: Re: login: PAM-only, login.defs, -H
References: <20111017110210.GA22648@nb.net.home> <20111117103147.GA6195@suse.de> <20111118121420.GQ7916@nb.net.home>
In-Reply-To: <20111118121420.GQ7916@nb.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Nov 17, 2011 at 11:31:47AM +0100, Thorsten Kukuk wrote:
>> On Mon, Oct 17, Karel Zak wrote:
>>
>>>  Git tree: https://karelzak@github.com/karelzak/util-linux.git branch 'login'.
>>>  URL: https://github.com/karelzak/util-linux/tree/login
>>
>> Ok, I found one bug: pam_setcred() is only called after pam_open_session(),
>> but has to be called before:
> 
>  Well, this is discussable... login(1) for years called pam_setcred()
>  after pam_open_session(), but I agree it's not optional.
>  
>  After discussion with our PAM maintainer we decided that the best is
>  probably to use PAM_ESTABLISH_CRED before and PAM_REINITIALIZE_CRED
>  after pam_open_session(). This solution should be probably the most
>  robust (it's probably used by openssh). 

Modules must work with one call before pam_open_session() as that's the
only documented and correct way. So that's what other applications such
as login managers, su etc do. IOW a module that would break due to login
using pam calls in the correct order is quite unlikely to exist at all.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
