Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15212 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989Ab2E2Lec (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 May 2012 07:34:32 -0400
Date: Tue, 29 May 2012 13:34:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: su(1) wish list
Message-ID: <20120529113418.GB374@x2.net.home>
References: <4FBE3059.3030806@suse.de>
 <20120529090609.GO3757@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120529090609.GO3757@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 29, 2012 at 11:06:09AM +0200, Karel Zak wrote:
> On Thu, May 24, 2012 at 02:58:01PM +0200, Ludwig Nussel wrote:
> > I've also filed a pull request on github:
> > https://github.com/karelzak/util-linux/pull/10
> 
>  Merged, but you forgot man page ;-) I don't think we need whole
>  history for the man page, so just copy and edit any existing su.1
>  man page and send it as a patch.

another issue:

  - why su.c expects "PATH" and "SUPATH" login default variables, but
    login.c expects "ENV_PATH" and "ENV_SUPATH"?

    See also login.def man page from shadow-utils where ENV_* is
    documented (for login as well as for su).

    IMHO we need to share the configuration between login and su.


and wish list:

  - remove MAX(), use max() from c.h
  - use err(), errx() and warn() and warnx() rather than error()
  - share init_environ() from login.c with su.c
  - cleanup usage()
  - move longopts[] to main
  - remove horrible PAM_BAIL macro, see is_pam_failure() in login.c
  - remove #if 0 code

  - simplify xsetenv(), move it to include/env.h as inline function,
    and use it in su.c, login.c etc.

    IMHO we can use code without putenv(), something like

       if (setenv(name, value, ow) != 0)
          err(EXIT_FAILURE, "failed to set %s variable", name);



    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
