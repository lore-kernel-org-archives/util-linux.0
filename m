Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:59440 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab1HVMem (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Aug 2011 08:34:42 -0400
Message-ID: <4E524CE1.5020502@suse.de>
Date: Mon, 22 Aug 2011 14:34:41 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Thorsten Kukuk <kukuk@suse.de>
Subject: Re: PAM-only login(1)
References: <20110812115758.GC1843@nb.net.home> <4E523B50.8080204@suse.de> <20110822120123.GC20457@nb.net.home>
In-Reply-To: <20110822120123.GC20457@nb.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Aug 22, 2011 at 01:19:44PM +0200, Ludwig Nussel wrote:
>> Karel Zak wrote:
>>>   I'd like to clean up login(1) code for v2.21. The current code is
>>>   mess with many #ifdef and support for some unused (and badly tested) 
>>>   features (e.g. non-PAM support for /etc/securetty and /etc/usertty).
>>>
>>>   What about to finally create nice and readable PAM-only login(1) for
>>>   Linux?
>>
>> +1
>>
>> On openSUSE we already use a pam-only login program¹. It was forked
> 
> It would be nice to merge all back to util-linux and share the code
> rather than maintain forks.

Sure.

>> from util-linux > ten years ago AFAICT. It also includes features
>> from shadow-utils, like reading settings from /etc/login.defs.
> 
> Does make anything other than MAIL_DIR sense for login(1)?

That one isn't even used by our login. AFAICT the following settings are
honored:

DEFAULT_HOME
ENV_PATH
ENV_ROOTPATH
FAIL_DELAY
HUSHLOGIN_FILE
LOGIN_TIMEOUT
LOG_UNKFAIL_ENAB
MOTD_FILE
TTYGROUP
TTYPERM
TTYTYPE_FILE

I agree that most of them are either superfluous or could be handled by
pam modules. Probably interesting are LOGIN_TIMEOUT and
LOG_UNKFAIL_ENAB. The former is hard-coded in util-linux and the latter
feature is missing. It replaces unknown user names with "UNKNOWN" in the
logs.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
