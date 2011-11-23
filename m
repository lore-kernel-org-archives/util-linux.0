Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30116 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab1KWQxC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Nov 2011 11:53:02 -0500
Date: Wed, 23 Nov 2011 17:52:59 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] login-utils maintenance fixes
Message-ID: <20111123165259.GC3092@nb.net.home>
References: <CAG27Bk2uza2TVvZguXRcWbg58NJ=Fpo3608c9rRyBhynNM2h-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2uza2TVvZguXRcWbg58NJ=Fpo3608c9rRyBhynNM2h-w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 19, 2011 at 10:43:35PM +0100, Sami Kerola wrote:
>       chfn: use libc error printing facilities

 Please, see how the original code uses "msg" in check_gecos_string().
 I think that proper fix is:

 if (msg)
    warnx (_("%s: '%c' is not allowed"), msg, c);
 else
    warnx (_("'%c' is not allowed"), c);

 and so on...

 It also seems that check_gecos_string() in main() should be called
 with static strings, so you can remove the strcats, the strings
 (e.g. "full name") should be also translated

    status = check_gecos_string(_("full name"), optarg);

 see also ask_info() where are the strings too. It would be better to
 use the same strings :-)

>       chfn, chsh, setpwnam: use stdbool.h

 hmm... what about to use old good 'int'?

>       chfn, chsh: share require password error print definition

 The macros are horrible. Please, see is_pam_failure() and
 loginpam_err() in login.c. I think it would be better to create
 pamfail.h with inline functions / macros. 
 
 Note that we cannot share this code with login.c where is also
 necessary to call syslog() and sleep()).

>       build-sys: trust autotools setting *_SOURCES definitions

 This commit subject is odd... do you mean "fix coding style"? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
